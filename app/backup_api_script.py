from __future__ import unicode_literals

import requests
import json
import time
import codecs
import sys
import datetime
UTF8Writer = codecs.getwriter('utf8')
sys.stdout = UTF8Writer(sys.stdout)

def main():

        cities =[("Vancouver","BC")]

        # get_results({"sign":"true","country":"Canada", "city":city, "state":state, "radius": 1, "key":settings.api_key, "page":per_page, "offset":offset })






        columns = ['id', 'name',  'city', 'lat', 'lon', 'link','who','members','description']


        cat_columns = { 'category': ['name','id'],
                        'meta_category': ['name','id','category_ids']
                        }
        leader = {
                        'organizer': 'id'
                    }
        # columns = [id, name, category_name, category['id'], city, meta_category['name'],
        # organizer['id'], description, lat, lon, link, meta_category['ids'], who, members]
        # Get your key here https://secure.meetup.com/meetup_api/key/
        # for (city, state) in cities:
        #     per_page = 10
        #     results_we_got = per_page
        #     offset = 0
        #     while (results_we_got == per_page):
        #     request.

                # Meetup.com documentation here: http://www.meetup.com/meetup_api/docs/2/groups/
        response=get_results({"country":"CA", "city":"Vancouver", "radius": 1, "key":settings.api_key, "page":1, "offset":1 })
        # response=get_results({"sign":"true","country":"Canada", "city":"Vancouver", "state":"CA", "radius": 10, "key":settings.api_key, "page":1, "offset":0 })

                # response=get_results({"sign":"true","country":"Canada", "city":city, "state":state, "radius": 1, "key":settings.api_key, "page":per_page, "offset":offset })
                # time.sleep(1)
                # offset += 1
        # results_we_got = response["meta"]['count']

        row_entry = ()
        for column in columns:
            try:
               row_entry += (response[0][column],)
            except NameError:
               print 'var not defined'
               row_entry += ('',)

        for key, values in cat_columns.iteritems():
            for index, attr in enumerate(values):
                try:
                    row_entry += (response[0][key][values[index]],)
                except NameError:
                   print 'var not defined'
                   row_entry += (None,)

        for key, value in leader.iteritems():
            try:
                row_entry += (response[0][key][value],)
            except NameError:
                print 'var not defined'
                row_entry += (None,)

        row_entry += (datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S"),)

        print row_entry



# columns = [group_id, name, category_name, category_id, city, meta_category_name,
#  organizer['id'], description, lat, lon, link, meta_category_ids, who, members]

        # for group in response[0]:
        #     print group['name']
            # category = ""
            # if "category" in group:
            #     category = group['category']['name']
            # print "," .join(map(unicode, [city, group['name'].replace(","," "), group['created'], group['city'],group.get('state',""),category,group['members'], group.get('who',"").replace(","," ")]))


            # time.sleep(1)


def get_results(params):

    request = requests.get("http://api.meetup.com/find/groups",params=params)
    data = request.json()
    return data


if __name__=="__main__":
        main()


## Run this script and send it into a csv:
## python meetup-pages-names-dates.py > meetup_groups.csv