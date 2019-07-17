import meetup.api

# client = meetup.api.Client('my_special_api_key_value')
client = meetup.api.Client('2a6e3cd671e3826353a571c70733c')



print type(client)
# <class 'meetup.api.Client'>

group_info = client.GetGroup({'urlname': 'Meetup-API-Testing'})

print type(group_info)
# <class 'meetup.api.MeetupObject'>

print  group_info.__dict__.keys()
# dict_keys(['who', 'join_mode', 'link', 'created', 'country', 'name', 'id', 'visibility',
         # 'state', 'urlname', 'city', 'lat', 'timezone', 'members', 'lon', 'description',
         # 'organizer', 'category', 'next_event', 'group_photo'])

print  group_info.id
# 1556336

print group_info.name
# 'Meetup API Testing Sandbox'

print group_info.link
# 'http://www.meetup.com/Meetup-API-Testing/'