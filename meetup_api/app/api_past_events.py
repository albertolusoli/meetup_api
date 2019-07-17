from __future__ import unicode_literals

import psycopg2
from config import Config
import settings
import  params
import requests
import json
import time
import codecs
import sys
reload(sys)
sys.setdefaultencoding('utf8')
import datetime
UTF8Writer = codecs.getwriter('utf8')
sys.stdout = UTF8Writer(sys.stdout)


urlname=''
def insert_into_past_events(group_data):
    """ insert multiple vendors into the vendors table  """
    sql = "INSERT INTO past_events(event_id, name, description, number_of_participants, event_date, event_time, link, venue_address, venue_lat, venue_lon, venue_name, group_id, created_at, updated_at, urlname) VALUES(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s, %s) ON CONFLICT (event_id) DO UPDATE SET (name, description, number_of_participants, event_date, event_time, link, venue_address, venue_lat, venue_lon, venue_name, group_id, updated_at, urlname) =(EXCLUDED.name, EXCLUDED.description , EXCLUDED.number_of_participants, EXCLUDED.event_date, EXCLUDED.event_time, EXCLUDED.link, EXCLUDED.venue_address, EXCLUDED.venue_lat, EXCLUDED.venue_lon, EXCLUDED.venue_name, EXCLUDED.group_id, EXCLUDED.updated_at,EXCLUDED.urlname)"

    conn = None
    try:
        # read database configuration
        params = Config()
        # connect to the PostgreSQL database
        conn = psycopg2.connect(settings.database_credentials)
        # conn = psycopg2.connect(params)

 #       conn = psycopg2.connect(**params)
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


def main(urlname, status):

        data_to_store= []
        columns = ['id', 'name', 'description', 'yes_rsvp_count','time' , 'link']
        venue_columns = ['address_1','lat', 'lon', 'name']
        group_info = { 'group': 'id' }

        api_key = settings.api_key
        per_page = params.events_per_page

        count = 0

        response = get_results(urlname,{"key":api_key, "status":status,"page":per_page })
        if response == []:
            print 'empty []'
            return

        for grp_index,group in enumerate(response):
            count += 1
            row_entry = ()
            for column in columns:
                if column in response[grp_index]:
                    if column == 'time':
                        date = (datetime.datetime.fromtimestamp(response[grp_index][column]/1000).date())
                        time = (datetime.datetime.fromtimestamp(response[grp_index][column]/1000).time())
                        row_entry += (date,time,)
                    else:
                        row_entry += (response[grp_index][column],)
                else:
                   row_entry += (None,)

            for col in venue_columns:
                row_entry += inspect_function(col, response, grp_index)

            for key, value in group_info.iteritems():
                if value in response[grp_index][key]:
                    row_entry += (response[grp_index][key][value],)
                else:
                    row_entry += (None,)

            row_entry += (datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S"),)
            row_entry += (datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S"),)
            row_entry +=(urlname,)


            data_to_store.append(row_entry)

        insert_into_past_events(data_to_store)

        print '**************End EVENTS BATCH; Records: 1 - %d ************ ' % (count),urlname,'\n'



def get_results(urlname, params):
    #V3 API Request
    returned = requests.get("http://api.meetup.com/" + urlname + "/events",params=params)

    response = returned.json()

    if 'errors' in response:
        if response["errors"][0]["code"] == 'blocked' or response["errors"][0]["code"] == 'throttled':
            print'EVENT REQUEST'
            print 'error: throttled; limit reached at ', datetime.datetime.now() - datetime.timedelta(minutes=480), '\n'
            print 'Recommencing...at ', datetime.datetime.now() - datetime.timedelta(minutes=420)
            time.sleep(3600)
            returned = requests.get("http://api.meetup.com/" + urlname + "/events",params=params)
            response = returned.json()
            return response
        else:
            print 'error:  EVENT REQUEST -------- \n'
            return ''
    else:
        return response

def inspect_function(attr, response, grp_index):
    if 'venue' in response[grp_index]:
        if attr in response[grp_index]['venue']:
            return (response[grp_index]['venue'][attr],)
        else:
            return (None,)
    else:
        return (None,)


if __name__=="__main__":
        main("YVR-Startups", "past")

