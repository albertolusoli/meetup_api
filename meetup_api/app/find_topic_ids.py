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


def select_topic_ids(order,limit):
#    sql = "SELECT group_id FROM groups"
    sql = "SELECT topic_id, topickeyword FROM topics ORDER BY group_count %s LIMIT %d" % (order,limit)

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
        cur.execute(sql,)
        # commit the changes to the database
        data = cur.fetchall()
        ids =[int(record[0]) for record in data]
        keyword = [record[1] for record in data]
        # print ids
        # close communication with the database
        cur.close()
        print 'success'
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()
    return ids, keyword

if __name__=="__main__":
        ids, keyword = select_topic_ids(params.topic_order,1000)
        # ids = select_topic_ids('DESC',1)
        print ids, keyword