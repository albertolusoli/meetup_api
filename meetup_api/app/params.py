# Individuals Script Runs
Y = True
N = False

topics_run = Y
groups_run = Y
events_and_members_run = Y
events_run = Y
members_run = Y
rsvps_run = Y


# Topics searches by keyword query
# topics = ['innovation']
topics = ['startups','entrepreneurship','innovation']

topics_per_page=20
# topics_offset=0 n/a

# How many topics are returned for group search
topic_order = 'ASC'  #ASC or DESC
topic_limit = 100

groups_order = 'DESC'
groups_limit=1000
groups_per_page=200
groups_offset=0

          #city,state,country, lat, lon, radius(miles)
# cities =[
#           ["Vancouver","BC","CA",49.28,-123.11,10],
#           # ["Calgary","AB","CA",51.05,-114.07,10],
#           # ["Montreal","QC","CA",45.50,-73.57,10],
#           # ["Toronto","ON","CA",43.65,-79.38,10],
#         ]

event_statuses = ["past","upcoming"]
events_per_page=200
events_offset=0

members_per_page=100
members_offset=0

rsvps_per_page=200
rsvps_offset=0







