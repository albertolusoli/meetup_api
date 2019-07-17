from __future__ import unicode_literals


import psycopg2
from config import Config

import requests
import json
import time
import codecs
import sys
import datetime
UTF8Writer = codecs.getwriter('utf8')
sys.stdout = UTF8Writer(sys.stdout)
par = 'dbname=meetup_data user=postgres host=localhost'

def select_group_ids():
    sql = "SELECT group_id FROM groups"

    conn = None
    try:
        # read database configuration
        params = Config()
        # connect to the PostgreSQL database
        conn = psycopg2.connect(par)
        # conn = psycopg2.connect(params)

 #       conn = psycopg2.connect(**params)
        # create a new cursor
        cur = conn.cursor()
        # execute the INSERT statement
        cur.execute(sql)
        # commit the changes to the database
        ids = cur.fetchall()

        # print ids
        # close communication with the database
        cur.close()
        print 'success'
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()

    return ids

if __name__=="__main__":
        ids = select_group_ids()
#         print ids