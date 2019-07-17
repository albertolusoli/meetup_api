 /find/topic_categories


from __future__ import unicode_literals

import requests
import json
import time
import codecs
import sys
UTF8Writer = codecs.getwriter('utf8')
sys.stdout = UTF8Writer(sys.stdout)

def main():

        cities =[("Vancouver","BC")]
        api_key= "2a6e3cd671e3826353a571c70733c"
        # get_results({"sign":"true","country":"Canada", "city":city, "state":state, "radius": 1, "key":api_key, "page":per_page, "offset":offset })


        # Get your key here https://secure.meetup.com/meetup_api/key/
        # for (city, state) in cities:
            per_page = 10
            results_we_got = per_page
            offset = 0
            while (results_we_got == per_page):
                # Meetup.com documentation here: http://www.meetup.com/meetup_api/docs/2/groups/
                response=get_results({"lon":‎-123.12073750000002,"lat":49.2827291,"radius": 1, "key":api_key, "page":per_page, "offset":offset })
                time.sleep(1)
                offset += 1
                # results_we_got = response["meta"]['count']
                for group in response['results']:
                    category = ""
                    if "category" in group:
                        category = group['category']['name']
                    print "," .join(map(unicode, [city, group['name'].replace(","," "), group['created'], group['city'],group.get('state',""),category,group['members'], group.get('who',"").replace(","," ")]))

            time.sleep(1)


def get_results(params):

    request = requests.get("http://api.meetup.com/2/groups",params=params)
    data = request.json()
    return data


if __name__=="__main__":
        main()


## Run this script and send it into a csv:
## python meetup-pages-names-dates.py > meetup_groups.csv