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
reload(sys)
sys.setdefaultencoding('utf8')
import datetime
UTF8Writer = codecs.getwriter('utf8')
sys.stdout = UTF8Writer(sys.stdout)




def insert_into_group_members(group_data):
    """ insert multiple members into the group_members table  """
    sql = "INSERT INTO group_members(group_id, member_id, name, bio, city, country, meetup_profile_link, created_at, updated_at, location_id, topickeyword) VALUES(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s) ON CONFLICT (member_id, group_id) DO UPDATE SET (name, bio, city, country, meetup_profile_link, updated_at, location_id, topickeyword) =(EXCLUDED.name, EXCLUDED.bio, EXCLUDED.city, EXCLUDED.country, EXCLUDED.meetup_profile_link, EXCLUDED.updated_at, EXCLUDED.location_id, EXCLUDED.topickeyword)"



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


def main(group_id, location_id, topickeyword):

        # cities =[("Vancouver","BC")]
        group_id=str(group_id)

        data_to_store= []
        # predefined data columns to extract
        columns = ['id', 'name','bio', 'city', 'country','link' ]

        offset = params.members_offset

        per_page=params.members_per_page

        more_records = True
        while (more_records):
            count = 0
            response = get_results({"group_id": group_id, "key":settings.api_key, "page":per_page, "offset":offset })
            offset += 1

            if response == []:
                print 'empty []'
                return

            # iterate though located data and add to tuple that will act as record
            for grp_index,group in enumerate(response['results']):
                count += 1
                row_entry = (group_id,)


                for col in columns:
                    row_entry += inspect_function(col, response, grp_index)

                row_entry += (datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S"),)
                row_entry += (datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S"),)

                row_entry +=(location_id,)
                row_entry +=(topickeyword,)
                data_to_store.append(row_entry)
              #  print count


            insert_into_group_members(data_to_store)
            start = (params.members_per_page * (offset-1))
            if count < params.members_per_page:
                more_records = False
                print '************** END: MEMBERS BATCH: # %d ; Records: %d - %d ************' % (offset, start,(start + count)),group_id,'\n'
            else:
                print '************** LOOPING... MEMBERS BATCH: # %d ; Records: %d - %d ************ \n' % (offset, start,(params.members_per_page * offset))


def get_results(params):

    # request = requests.get("http://api.meetup.com/2/members?fields=birthday",params=params)
    #V2 API Request
    time.sleep(1)

    returned = requests.get("http://api.meetup.com/2/members?",params=params)

    response = returned.json()


    if 'code' in response:
        while ("code" in response):

            if response['code'] == 'throttled' or response['code'] == 'blocked':
                if response['code'] == 'throttled' or response['code'] == 'blocked':
                    print 'MEMBERS Request'
                    print 'error: throttled; limit reached at ', datetime.datetime.now() - datetime.timedelta(minutes=480), '\n'
                    
                    if throttle_count >= 4:
                        print 'Recommencing...at ', datetime.datetime.now() - datetime.timedelta(minutes=450)  #420
                        time.sleep(1800)
                    else:
                        print 'Recommencing...at ', datetime.datetime.now() - datetime.timedelta(minutes=479)  #420
                        time.sleep(30)

                    returned = requests.get("http://api.meetup.com/2/members?",params=params)
                    response = returned.json()
                    if "code" in response:
                        pass
                    else:
                        return response

            else:
                print 'error: MEMBERS REQUEST -------- \n'
                return ''
        return response
    else:
        return response


    # if "errors" in response:
    #     while ("errors" in response):
    #         if response["errors"][0]["code"] == 'blocked' or response["errors"][0]["code"] == 'throttled':
    #             throttle_count += 1
    #             print'GROUPS request'
    #             print 'error: throttled; throttle count = %d; limit reached at ' % (throttle_count), datetime.datetime.now() - datetime.timedelta(minutes=480), '\n'
    #             if throttle_count >= 4:
    #                 print 'Recommencing...at ', datetime.datetime.now() - datetime.timedelta(minutes=450)  #420
    #                 time.sleep(1800)
    #             else:
    #                 print 'Recommencing...at ', datetime.datetime.now() - datetime.timedelta(minutes=479)  #420
    #                 time.sleep(30)
    #             returned = requests.get("http://api.meetup.com/find/groups",params=params)
    #             response = returned.json()
    #             if "errors" in response:
    #                 pass
    #             else:
    #                 return response
    #         else:
    #             print 'error: GROUP REQUEST -------- \n'
    #             return ''
    #     return response
    # else:

    #     return response




def inspect_function(check, response, grp_index):
    if check in response['results'][grp_index]:
        return (response['results'][grp_index][check],)
    else:
        return (None,)


if __name__=="__main__":
  #      main(1620982)
        main(26640733, 4, 'startup')


## Run this script and send it into a csv:
## python meetup-pages-names-dates.py > meetup_groups.csv