from __future__ import unicode_literals

import sys
import find_group_ids as select
import psycopg2
from config import Config
import settings
import find_topic_ids as topics
import requests
import json
import time
import codecs
import datetime
import settings
import params
import find_topic_ids as topics
import adjustsettings

UTF8Writer = codecs.getwriter('utf8')
sys.stdout = UTF8Writer(sys.stdout)
reload(sys)
sys.stdout = codecs.getwriter('utf8')(sys.stdout)

topic_ids=[]

def insert_into_groups(group_data):

    sql = "INSERT INTO groups(group_id, name, city, lat, lon, link, who, members, description, urlname, date_of_creation,category_name, category_id, meta_category_name, meta_category_id, meta_category_category_ids, organizer_id, created_at, topic_id, location_id, topickeyword) VALUES(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s) ON CONFLICT (group_id) DO UPDATE SET (name, city, lat, lon, link, who, members, description, urlname, date_of_creation,category_name, category_id, meta_category_name, meta_category_id, meta_category_category_ids, organizer_id, updated_at, topic_id, location_id, topickeyword) =( EXCLUDED.name, EXCLUDED.city , EXCLUDED.lat, EXCLUDED.lon, EXCLUDED.link, EXCLUDED.who, EXCLUDED.members, EXCLUDED.description, EXCLUDED.urlname, EXCLUDED.date_of_creation, EXCLUDED.category_name, EXCLUDED.category_id, EXCLUDED.meta_category_name, EXCLUDED.meta_category_id, EXCLUDED.meta_category_category_ids, EXCLUDED.organizer_id, EXCLUDED.created_at, EXCLUDED.topic_id, EXCLUDED.location_id, EXCLUDED.topickeyword)"

    sql2 = "INSERT INTO groups_history(group_id, name, city, lat, lon, link, who, members, description, urlname, date_of_creation,category_name, category_id, meta_category_name, meta_category_id, meta_category_category_ids, organizer_id, created_at, topic_id, location_id, topickeyword) VALUES(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s) ON CONFLICT (group_id, created_at) DO UPDATE SET (name, topic_id, location_id, topickeyword) = (EXCLUDED.name, EXCLUDED.topic_id, EXCLUDED.location_id, EXCLUDED.topickeyword)"

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

        conn.commit()

        cur.executemany(sql2,group_data)
        # rows_affected=cur.rowcount
        # print rows_affected,'-----'
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


def main(topic_id, created_time, location, keyword):

   #     print location
        lat = location[0]
        lon = location[1]
        radius = location[2]
        city="San Francisco"
        city=location[3]
        location_id=location[4]
        print location_id
        print keyword
        data_to_store= []
      #  print location
       # print lat, lon
        columns = ['id', 'name',  'city', 'lat', 'lon', 'link','who','members','description', 'urlname', 'created' ]

        cat_columns = { 'category': ['name','id'],
                        'meta_category': ['name','id','category_ids']
                    }
        leader = { 'organizer': 'id' }

        per_page = params.groups_per_page
        ids = []
        offset = params.groups_offset
        more_records = True
        while (more_records):
            count = 0
            response = get_results({"topic_id":topic_id,"lat":lat, "lon":lon,"radius": radius,"location":city, "key":settings.api_key, "page":per_page, "offset":offset })

            offset += 1
         #   print response
            if response == []:
                print 'empty []'
                return
            if response == '':
                return
            else:
                for grp_index,group in enumerate(response):
                    count += 1
                    row_entry = ()
                    for column in columns:
                        try:
                            if column == 'created':
                                date = (datetime.datetime.fromtimestamp(response[grp_index][column]/1000).date())
                                row_entry += (date,)
                            else:
                                row_entry += (response[grp_index][column],)
                        except NameError:
                           print 'var not defined'
                           row_entry += (None,)

                    for key, values in cat_columns.iteritems():

                        for index, attr in enumerate(values):
                            row_entry += inspect_function(values[index], key, grp_index, response)

                    for key, value in leader.iteritems():
                        row_entry += inspect_function(value, key, grp_index, response)

                    row_entry += created_time
                    row_entry += (topic_id,)
                    row_entry += (location_id,)
                    row_entry += (keyword,)

                    index = 0
                    for item in row_entry:
                        index +=1
                    #print row_entry

                    ids.append(response[grp_index]['id'])

                    data_to_store.append(row_entry)

                insert_into_groups(data_to_store)
                start = (params.groups_per_page * (offset-1))
                if count < params.groups_per_page:
                    more_records = False
                    print '************** END: GROUPS BATCH: # %d ; Records: %d - %d ************ \n' % (offset, start,(start + count))
                else:
                    print ids
                    print len(ids)

                    print '************** LOOPING...GROUPS BATCH: # %d ; Records: %d - %d ************ \n' % (offset, start,(params.groups_per_page * offset))


def get_results(params):

    returned = requests.get("http://api.meetup.com/find/groups",params=params)
    response = returned.json()
    time.sleep(1)

    throttle_count=0
    if "errors" in response:
        while ("errors" in response):
            if response["errors"][0]["code"] == 'blocked' or response["errors"][0]["code"] == 'throttled':
                throttle_count += 1
                print'GROUPS request'
                print 'error: throttled; throttle count = %d; limit reached at ' % (throttle_count), datetime.datetime.now() - datetime.timedelta(minutes=480), '\n'
                if throttle_count >= 4:
                    print 'Recommencing...at ', datetime.datetime.now() - datetime.timedelta(minutes=450)  #420
                    time.sleep(1800)
                else:
                    print 'Recommencing...at ', datetime.datetime.now() - datetime.timedelta(minutes=479)  #420
                    time.sleep(30)
                returned = requests.get("http://api.meetup.com/find/groups",params=params)
                response = returned.json()
                if "errors" in response:
                    pass
                else:
                    return response
            else:
                print 'error: GROUP REQUEST -------- \n'
                return ''
        return response
    else:

        return response

    #V3 API Request
    # if 'errors' in response:
    #     if response["errors"][0]["code"] == 'blocked' or response["errors"][0]["code"] == 'throttled':
    #         print 'GROUPS REQUEST'
    #         print 'error: throttled; limit reached at ', datetime.datetime.now() - datetime.timedelta(minutes=480), '\n'

    #         print 'Recommencing...at ', datetime.datetime.now() - datetime.timedelta(minutes=420)
    #         time.sleep(3600)
    #         returned = requests.get("http://api.meetup.com/find/groups",params=params)
    #         response = returned.json()
    #         return response
    #     else:
    #         print 'error: GROUP REQUEST -------- \n'
    #         return ''
    # else:
    #     return response

def inspect_function(attr, key, grp_index, response):
    if attr in response[grp_index]:
        return (response[grp_index][attr],)
    else:
        return (None,)
        print "none"


if __name__=="__main__":
        created_time= (datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S"),)
        locations, words = adjustsettings.pull_params()
        print locations

        for location in locations:
            main(21681, created_time, location, 'startup')

        print params.topic_order
        print params.topic_limit


        topic_ids, keyword=topics.select_topic_ids(params.topic_order, params.topic_limit)
     #   created_time= (datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S"),)
        print topic_ids
        # for topic_id in topic_ids:
        #     main(topic_id, created_time, location)
