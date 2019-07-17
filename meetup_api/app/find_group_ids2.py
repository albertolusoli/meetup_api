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

def select_group_ids(limit):
    sql = "SELECT group_id, urlname, created_at FROM groups ORDER BY members DESC"
    # ids=[]
    conn = None
    try:
        # read database configuration
        params = Config()
        # connect to the PostgreSQL database
        conn = psycopg2.connect(settings.database_credentials)
        # create a new cursor
        cur = conn.cursor()
        # execute the INSERT statement
        cur.execute(sql)

        data = cur.fetchall()
        ids =[int(record[0]) for record in data]
        urlnames= [record[1] for record in data]
        created_at= [record[2].date() for record in data]

      #  created_at=created_at.date()

        # print ids
        # close communication with the database
        cur.close()
        print 'success'
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()
    # return ids, urlnames

    return ids, urlnames, created_at


if __name__=="__main__":
        #ids, urlnames, created_at = select_group_ids(params.groups_order,params.groups_limit)
        # print ids, urlnames, created_at

