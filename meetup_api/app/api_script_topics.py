from __future__ import unicode_literals

import psycopg2
from config import Config
import settings
import params
import requests
import json
import time
import codecs
import sys
import datetime

reload(sys)
sys.setdefaultencoding('utf8')
from ast import literal_eval
UTF8Writer = codecs.getwriter('utf8')
sys.stdout = UTF8Writer(sys.stdout)


def insert_into_topic(group_data):

    sql = "INSERT INTO topics(topic_id, name, description, lang, member_count, group_count, urlkey, topickeyword, created_at) VALUES(%s,%s,%s,%s,%s,%s,%s,%s,%s) ON CONFLICT (topic_id) DO UPDATE SET ( name, description, lang, member_count, group_count, urlkey, topickeyword, updated_at) = (EXCLUDED.name, EXCLUDED.description, EXCLUDED.lang, EXCLUDED.member_count, EXCLUDED.group_count, EXCLUDED.urlkey, EXCLUDED.topickeyword, EXCLUDED.updated_at )"

    conn = None
    try:
        # read database configuration
        params = Config()
        # connect to the PostgreSQL database
        conn = psycopg2.connect(settings.database_credentials)
        # conn = psycopg2.connect(params)

        # conn = psycopg2.connect(**params)
        # create a new cursor
        cur = conn.cursor()
        # execute the INSERT statement
        cur.executemany(sql,group_data)
        # commit the changes to the database
        conn.commit()
        # close communication with the database
        cur.close()
        print 'success'
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()




def main(topic):
        print '------- add script topics ------'
        # cities = params.cities
        created_time= (datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S"),)

        # for index,location in enumerate(cities):
        #     city = cities[index][0]
        #     state = cities[index][1]
        #     country = cities[index][2]
        #     lat = cities[index][3]
        #     lon = cities[index][4]
        #     radius = cities[index][5]

        data_to_store = []

        response = get_results({ 'query':topic, "key":settings.api_key, 'page':params.topics_per_page})

        if response == []:
            print 'empty []'
            return

        for grp_index,group in enumerate(response):
            if response[grp_index]['group_count'] == 0:
                continue
            row_entry = ()
            row_entry += inspect_function('id', response, grp_index)
            row_entry += inspect_function('name', response, grp_index)
            row_entry += inspect_function('description', response, grp_index)
            row_entry += inspect_function('lang', response, grp_index)
            row_entry += inspect_function('member_count', response, grp_index)
            row_entry += inspect_function('group_count', response, grp_index)
            row_entry += inspect_function('urlkey', response, grp_index)
            row_entry += (topic,)
            row_entry += created_time

            data_to_store.append(row_entry)
       #     print data_to_store


        insert_into_topic(data_to_store)

def inspect_function(check, response, grp_index):
    if check in response[grp_index]:
        return (response[grp_index][check],)
    else:
        return (None,)



def get_results(params):

    #V3 Api Request
    returned = requests.get("http://api.meetup.com/find/topics",params=params)

    response = returned.json()

    if 'errors' in response:
        if response["errors"][0]["code"] == 'blocked' or response["errors"][0]["code"] == 'throttled':
            print 'error: throttled; limit reached at ', datetime.datetime.now() - datetime.timedelta(minutes=480), '\n'
            print 'Recommencing...at ', datetime.datetime.now() - datetime.timedelta(minutes=420)
            time.sleep(3600)
            returned = requests.get("http://api.meetup.com/find/topics",params=params)
            response = returned.json()
            return response
        else:
            print 'error --------'
            return ''
    else:
        return response


if __name__=="__main__":
    topics = ['startups','entrepreneurship','innovation']

    for topic in topics:
        main(topic)



