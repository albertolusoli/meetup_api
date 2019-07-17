from __future__ import unicode_literals

import sys
# sys.path.append('~/documents/meetup/find_group_ids')
import find_group_ids as select
import psycopg2
from config import Config
import requests
import json
import time
import codecs

import datetime
UTF8Writer = codecs.getwriter('utf8')
sys.stdout = UTF8Writer(sys.stdout)

def insert_into_groups(group_data):
    """ insert multiple vendors into the vendors table  """



    sql = "INSERT INTO groups(group_id, name, city, lat, lon, link, who, members, description, urlname, date_of_creation,category_name, category_id, meta_category_name, meta_category_id, meta_category_category_ids, organizer_id, created_at) VALUES(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"


# ON CONFLICT (group_id) DO UPDATE SET (name, city, lat, lon, link, who, members, description, urlname, date_of_creation,category_name, category_id, meta_category_name, meta_category_id, meta_category_category_ids, organizer_id, updated_at) =( EXCLUDED.name, EXCLUDED.city , EXCLUDED.lat, EXCLUDED.lon, EXCLUDED.link, EXCLUDED.who, EXCLUDED.members, EXCLUDED.description, EXCLUDED.urlname, EXCLUDED.date_of_creation, EXCLUDED.category_name, EXCLUDED.category_id, EXCLUDED.meta_category_name, EXCLUDED.meta_category_id, EXCLUDED.meta_category_category_ids, EXCLUDED.organizer_id, EXCLUDED.updated_at)
    # (550,'group1','entrepreneurship',54,'vancouver','business',6683,'this is a group',49.03,123.06,'http://example.com',[56,32],'yuppies',56,100,)

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
        columns = ['id', 'name',  'city', 'lat', 'lon', 'link','who','members','description', 'urlname', 'created' ]  #10

        cat_columns = { 'category': ['name','id'], #2
                        'meta_category': ['name','id','category_ids'] #3
                    }
        leader = { 'organizer': 'id' } #1

        response = get_results({"country":"CA", "city":"Vancouver", "radius": 1, "key":settings.api_key, "page":3, "offset":1 })

        print response
        # iterate though located data and add to tuple that will act as record
        for grp_index,group in enumerate(response):
            row_entry = ()
            for column in columns:
                try:
                    if column == 'created':
                        print '************************'
                        date = (datetime.datetime.fromtimestamp(response[grp_index][column]/1000).date())
                        print date, '*******'
                        row_entry += (date,)
                    else:
                        row_entry += (response[grp_index][column],)
                except NameError:
                   print 'var not defined'
                   row_entry += (None,)

            for key, values in cat_columns.iteritems():

                for index, attr in enumerate(values):
                    row_entry += inspect_function(values[index], key, grp_index, response)
                 #   row_entry += inspect_function('test', key, grp_index, response)
                    # try:
                    #     row_entry += (response[grp_index][key][values[index]],)
                    # except NameError:
                    #    print 'var not defined'
                    #    row_entry += (None,)

            for key, value in leader.iteritems():
                row_entry += inspect_function(value, key, grp_index, response)

                # try:
                #     row_entry += (response[grp_index][key][value],)
                # except NameError:
                #     print 'var not defined'
                #     row_entry += (None,)

            row_entry += (datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S"),)

            index = 0
            for item in row_entry:
                index +=1
                print index, '  ',item, '\n'


            data_to_store.append(row_entry)

        insert_into_groups(data_to_store)

def get_results(params):

    request = requests.get("http://api.meetup.com/find/groups",params=params)
    data = request.json()
    return data

def inspect_function(attr, key, grp_index, response):
    if attr in response[grp_index]:
        return (response[grp_index][attr],)
    else:
        return (None,)
        print "none"






if __name__=="__main__":
        # main()
        ids = select.select_group_ids()
        print ids


## Run this script and send it into a csv:
## python meetup-pages-names-dates.py > meetup_groups.csv