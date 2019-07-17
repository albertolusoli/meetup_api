from __future__ import unicode_literals

import sys
# sys.path.append('~/documents/meetup/find_group_ids')

import psycopg2
from config import Config
import requests
import json
import time
import codecs

import datetime
UTF8Writer = codecs.getwriter('utf8')
sys.stdout = UTF8Writer(sys.stdout)