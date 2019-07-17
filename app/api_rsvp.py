#229022

from __future__ import unicode_literals


import psycopg2
from config import Config
import settings
#from database import postgres
import sys
reload(sys)
sys.setdefaultencoding('utf8')

import requests
import json
import time
import codecs

import datetime
import sys
import simplejson
import params

UTF8Writer = codecs.getwriter('utf8')
sys.stdout = UTF8Writer(sys.stdout)




def insert_into_rsvps(group_data):
    """ insert multiple members into the group_members table  """
    sql = "INSERT INTO rsvps(member_id,event_id, group_urlname, created_at, updated_at, response, location_id, topickeyword) VALUES(%s,%s,%s,%s,%s,%s,%s,%s) ON CONFLICT (member_id, event_id, location_id, topickeyword) DO UPDATE SET (updated_at, response) = (EXCLUDED.updated_at, EXCLUDED.response, EXCLUDED.location_id, EXCLUDED.topickeyword)"


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





def main(urlname, event_id, location_id, topickeyword):

        data_to_store= []

        count = 0
        response = get_results(urlname, event_id,{"key":settings.api_key })


    #    print response
        if response == []:
            print 'empty []'
            return

        if 'errors' in response:
            print 'err with urlname: ', urlname, ' and event_id: ', event_id, '\n'
            return
            # sys.exit()
            print '------'

        for index, rsvp in enumerate(response):
            count += 1
            row_entry = ()

            row_entry += (response[index]['member']['id'],)
            row_entry += (event_id,)
            row_entry += (urlname,)

            row_entry += (datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S"),)
            row_entry += (datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S"),)
            row_entry += (response[index]['response'],)

            row_entry +=(location_id,)
            row_entry +=(topickeyword,)
            
            data_to_store.append(row_entry)
   #         print '---------------Count: %d ------------ \n' % (count)

        insert_into_rsvps(data_to_store)
        print  ' ******* END: RSVPS BATCH: #; Records: 0 - %d ******' % (count), event_id, urlname, '\n',
        # start = (params.rsvps_per_page * (offset-1))
        # if count < params.rsvps_per_page:
        #     more_records = False
            # print '************** END: RSVPS BATCH: # %d ; Records: %d - %d ************ \n' % (offset, start,(start + count))
        # else:
        #     print '************** LOOPING... RSVPS BATCH: # %d ; Records: %d - %d ************ \n' % (offset, start,(params.rsvps_per_page * offset))


def get_results(urlname, event_id, params):

    #V3 API Request
    returned = requests.get("http://api.meetup.com/"+urlname+"/events/"+str(event_id)+"/rsvps?",params=params)

    response = returned.json()
    time.sleep(1)

  #  print response
    if "errors" in response:
        if response["errors"][0]["code"] == 'blocked' or response["errors"][0]["code"] == 'throttled':
            print'rsvp request'
            print 'error: throttled; limit reached at ', datetime.datetime.now() - datetime.timedelta(minutes=480), '\n'
            print 'Recommencing...at ', datetime.datetime.now() - datetime.timedelta(minutes=420)
            time.sleep(1800)
            returned = requests.get("http://api.meetup.com/"+urlname+"/events/"+str(event_id)+"/rsvps?",params=params)
            response = returned.json()
            return response
        else:
            print 'error: RSVP Request *******',event_id, urlname,'\n'
            return ''
    else:

        return response

    # data = request.json()
#    data = simplejson.loads(request)

    # return data

def inspect_function(check, response, grp_index):
    if check in response['results'][grp_index]:
        return (response['results'][grp_index][check],)
    else:
        return (None,)


if __name__=="__main__":
        urlname = 'Advance-Tech-Social'
        event_ids = ['mxdrznyxdbjb']
        for id in event_ids:
            event_id = id
            main(urlname, event_id)
            print '--'

## Run this script and send it into a csv:
## python meetup-pages-names-dates.py > meetup_groups.csv