#229022

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
UTF8Writer = codecs.getwriter('utf8')
sys.stdout = UTF8Writer(sys.stdout)

par2= 'dbname=meetup_data user=PeterHunt host=localhost'


def insert_into_events(group_data):
    """ insert multiple vendors into the vendors table  """
    sql = "INSERT INTO events(event_id, name, description, number_of_participants, event_time, event_date, duration, link, venue_name, venue_address,venue_city, venue_state, venue_country, lat, lon, group_id, created_at, updated_at) VALUES(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s) ON CONFLICT (event_id) DO UPDATE SET (name, description, number_of_participants, event_time, event_date, duration, link, venue_name, venue_address,venue_city, venue_state, venue_country, lat, lon, group_id, updated_at) =( EXCLUDED.name, EXCLUDED.description, EXCLUDED.number_of_participants, EXCLUDED.event_time, EXCLUDED.event_date, EXCLUDED.duration, EXCLUDED.link, EXCLUDED.venue_name, EXCLUDED.venue_address,EXCLUDED.venue_city, EXCLUDED.venue_state, EXCLUDED.venue_country, EXCLUDED.lat, EXCLUDED.lon, EXCLUDED.group_id, EXCLUDED.updated_at)"




    # (550,'group1','entrepreneurship',54,'vancouver','business',6683,'this is a group',49.03,123.06,'http://example.com',[56,32],'yuppies',56,100,)

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






def main():

        # cities =[("Vancouver","BC")]


        data_to_store= []
        # predefined data columns to extract
        event_columns = { 'events': ['id', 'name', 'description', 'yes_rsvp_count','local_time','local_date','duration', 'link'] }

        venue_columns = { 'venue': ['name','address_1','city','state','country','lat','lon']

                    }
        group_info = { 'group': 'id' }

  #      response = get_results({"group_id": 229022, "key":settings.api_key, "page":1, "offset":1 })
        response = get_results({"key":settings.api_key, "page":2, "offset":1 })



        print response

        for index, event in enumerate(response['events']):
            row_entry = ()



            for attr in event_columns['events']:
                row_entry += inspect_function_unnested(attr, response, index)

            row_entry += inspect_function('name', response, index, 'venue')
            row_entry += inspect_function('address_1', response, index,'venue')
            row_entry += inspect_function('city', response, index, 'venue')
            row_entry += inspect_function('state', response, index, 'venue')
            row_entry += inspect_function('country', response, index, 'venue')
            row_entry += inspect_function('lat', response, index, 'venue')
            row_entry += inspect_function('lon', response, index, 'venue')

            row_entry += inspect_function('id', response, index, 'group')

            row_entry += (datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S"),)
            row_entry += (datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S"),)

            index = 0
            for item in row_entry:
                index +=1
                print index, '  ',item, '\n'


            data_to_store.append(row_entry)
            print '------'
            print data_to_store
            print '------'

        insert_into_events(data_to_store)


def get_results(params):

#    request = requests.get("http://api.meetup.com/2/events",params=params)
    request = requests.get("http://api.meetup.com/find/upcoming_events",params=params)

    data = request.json()
    return data

def inspect_function_unnested(attr, response, index):
    if attr in response['events'][index]:
        return (response['events'][index][attr],)
    else:
        return (None,)

def inspect_function(attr, response, index, nested_key):
    if nested_key in response['events'][index]:
        if attr in response['events'][index][nested_key]:
            return (response['events'][index][nested_key][attr],)
        else:
            return (None,)
    else:
        return (None,)


if __name__=="__main__":
        main()


## Run this script and send it into a csv:
## python meetup-pages-names-dates.py > meetup_groups.csv