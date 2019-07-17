import datetime

# a= {}

# # if hasattr(a, '__len__'):
def insert_into_group_members(group_data):
    """ insert multiple members into the group_members table  """
    sql = "INSERT INTO group_members(group_id, member_id, name, bio, city, country, gender, birthday, meetup_profile_link, created_at, updated_at) VALUES(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s) ON CONFLICT (member_id, group_id) DO UPDATE SET (name, bio, city, country, gender, birthday, meetup_profile_link, updated_at) =(EXCLUDED.name, EXCLUDED.bio, EXCLUDED.city, EXCLUDED.country, EXCLUDED.gender, EXCLUDED.birthday, EXCLUDED.meetup_profile_link, EXCLUDED.updated_at)"



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

#v1
response_b= {
  "details": "Credentials have be throttled more than the allowed times in one hour",
  "problem": "Client throttled",
  "code": "throttled"
}

#v3
response_a= {
  "errors":[{
    "code": "throttled",
    "message": "Credentials have been throttled more than the allowed times in one hour"
  }]
}



# #V3
# if response_a['errors'][0]['code'] == 'throttled':
#   print 'v3'
# #V1 or V2
# if response_b['code'] == 'throttled':
#   print 'v1'


# print datetime.datetime.now()

if response_a["errors"][0]["code"] == 'blocked' or response_a["errors"][0]["code"] == 'throttled':
  print 'yes'


print datetime.datetime.now() - datetime.timedelta(minutes=480)
print datetime.datetime.now() - datetime.timedelta(minutes=420)