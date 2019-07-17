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

def pull_params():
    sql = "SELECT lat, lon, radius, city, id FROM locations WHERE status = True"
    sql2 = "SELECT keyword FROM topickeywords WHERE status = True"
#    sql = "SELECT topic_id FROM topics"
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
        locations = cur.fetchall()
        # print locations


        cur.execute(sql2)
        keywords= cur.fetchall()
        words = [i[0] for i in keywords]
        print words

        # print keywords
        # ids =[record[0] for record in data]
        # group_urlname= [record[1] for record in data]
        # event_date= [record[2] for record in data]

        # created_at= [record[3].date() for record in data]


        # close communication with the database
        cur.close()
        print 'success'
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()

    print locations
    return locations, words

if __name__=="__main__":
        params = pull_params()
        print params