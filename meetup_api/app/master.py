from __future__ import unicode_literals

import psycopg2
from config import Config
import adjustsettings
import find_group_ids as find_group_ids
import find_topic_ids as topics
import find_event_ids as find_event_ids
import api_groups as api_groups
import api_events as api_events
import api_upcoming_events as api_upcoming_events
import api_group_members as api_group_members
import api_rsvp as api_rsvp
import api_script_topics as api_script_topics
import api_rsvp2 as api_rsvp2

import params
import fuckit
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
import settings


def main():

	locations, words = adjustsettings.pull_params()
	if params.topics_run == True:
		print locations, words, 'topic run'

		with fuckit:
			add_topics(words)

	if params.groups_run == True:
		with fuckit:

			groups(locations)

	if params.events_and_members_run == True:

		with fuckit:

			events_and_members()

	if params.rsvps_run == True:

		with fuckit:

			rsvp()

	print '---'
# def cron
# 	schedule.dow.on('SUN').at("00:00").do(job)
def test():
	print '---'


def add_topics(words):
	for word in words:
		api_script_topics.main(word)


def groups(locations):
	topic_ids, keywords=topics.select_topic_ids(params.topic_order, params.topic_limit)
	print topic_ids

	created_time= (datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S"),)
	for location in locations:
		print location, 'start'
		for (topic_id, keyword) in zip(topic_ids, keywords):
			api_groups.main(topic_id, created_time, location, keyword)


def events_and_members():
	today = datetime.date.today()

	DD = datetime.timedelta(days=4)
	compare_date=today-DD
	ids, urlnames, created_at, location_id, topickeyword = find_group_ids.select_group_ids(params.groups_order, params.groups_limit)
	if params.events_run == True:
		for (index, date, location, keyword) in zip(urlnames, created_at, location_id, topickeyword):
			api_events.main(index, "upcoming", location, keyword)

			if date >  compare_date:
				api_events.main(index, "past", location, keyword)


	#		print index, '********** urlname here  *****'
	#		for status in params.event_statuses:
	#			api_events.main(index, status)


	if params.members_run == True:
		for (index, location, keyword) in zip(ids,location_id, topickeyword):
			print index
			api_group_members.main(index, location, keyword)


def rsvp():
	event_ids, group_urlnames, event_date, created_at, location_id, topickeyword=find_event_ids.select_group_ids()
	todayR = datetime.date.today()
	DD = datetime.timedelta(days=1)
	compare_date=todayR-DD
	#print event_ids, group_urlnames, 'event_ids'

	i=0
	for pairs in event_ids:
	#	print group_urlnames[i], event_ids[i],event_date[i],  created_at[i]
	#	print '-----'







		if event_date[i] > todayR or created_at[i] > compare_date:
#			print group_urlnames[i], event_ids[i],event_date[i],  created_at[i]
			#print 'yes'
			with fuckit:
			#	api_rsvp.main(group_urlnames[i], event_ids[i] )
				api_rsvp2.main(group_urlnames[i], event_ids[i], location_id[i], topickeyword[i] )

		i+=1

def heading():
	stars = '*'* 50
 	date = 'CYCLE:'+ str(datetime.datetime.now())
 	date_len = len(date)
	stars2 = int((50-date_len)/2.0)-1
	print stars, '\n'
	print stars2*'*',date,stars2*'*', '\n'
	print stars, '\n'
	return datetime.datetime.now()

def footer(startdate):
	stars = '*'* 50
 	date = 'END OF CYCLE:'+ str(datetime.datetime.now())
 	date_len = len(date)
	stars2 = int((50-date_len)/2.0)-1
	print stars, '\n'
	print stars2*'*',date,stars2*'*', '\n'
	print stars, '\n'
	duration=datetime.datetime.now()-startdate
	print 'total elapsed time:', duration


if __name__=="__main__":
        startdate=heading()
        main()
        footer(startdate)
