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

def select_group_ids():
    sql = "SELECT event_id, urlname, event_date, created_at, location_id, topickeyword FROM events"
#    sql = "SELECT topic_id FROM topics"
    ids=[]
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
        cur.execute(sql)
     #   print cur.fetchall()
        # commit the changes to the database
    #    ids = cur.fetchall()
        data = cur.fetchall()
        ids =[record[0] for record in data]
        group_urlname= [record[1] for record in data]
        event_date= [record[2] for record in data]

        created_at= [record[3].date() for record in data]
        location_id =[record[4] for record in data]
        keyword= [record[5] for record in data]

        # print ids
        # close communication with the database
        cur.close()
        print 'success'
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()

   # print urlnames
  #  print ids, group_urlname
    return ids, group_urlname, event_date, created_at, location_id, keyword

if __name__=="__main__":
        ids, group_urlname, event_date, created_at, location_id, keyword = select_group_ids()
        print location_id