
import psycopg2
from config import Config
import settings
import datetime

#hostname = '192.168.10.36'
params = {
    'host' : 'localhost',
    'database' : 'meetup_data',
    'username' : 'postgres',
    'password' : ''
}

x=datetime.datetime.fromtimestamp(1305844394000/1000).date()


# def insert_into_vendors(group_data):
def insert_into_groups(group_data):

    print datetime.datetime.fromtimestamp(1305844394000/1000).strftime('%c')
    print datetime.datetime.fromtimestamp(1305844394000/1000)

    print datetime.datetime.fromtimestamp(1305844394000/1000).time()

  #  print date.date.fromtimestamp(1305844394000/1000).strftime('%c')

#1305844394000.datetime()
    """ insert multiple vendors into the vendors table  """
    sql = "INSERT INTO groups( date_of_creation) VALUES(%s)"
    conn = None
    try:
        # read database configuration
        params = Config()
        # connect to the PostgreSQL database
  #      conn = psycopg2.connect('dbname=meetup_data user=PeterHunt host=localhost')
    #    conn = psycopg2.connect('dbname=meetup_data user=postgres host=localhost')

        conn = psycopg2.connect(par)

     #   conn = psycopg2.connect(**params)
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



if __name__ == '__main__':
    # insert one vendor
 #   insert_vendor("3M Co.")
    # insert multiple vendors
    insert_into_groups([
   #     (x,),
        (x,)
        ])
    # insert_into_vendors([
    #     ('AKM Semiconductor Inc.',),
    #     ('Asahi Glass Co Ltd.',),
    #     ('Daikin Industries Ltd.',),
    #     ('Dynacast International Inc.',),
    #     ('Foster Electric Co. Ltd.',),
    #     ('Murata Manufacturing Co. Ltd.',)
    # ])