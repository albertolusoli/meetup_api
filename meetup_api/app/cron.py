import schedule
import time
import master as master

def job():
    print("I'm working...")
schedule.every(10).seconds.do(master.test)

#schedule.every(2).seconds.do(job)
#schedule.every().hour.do(job)
#schedule.every().day.at("10:30").do(job)
schedule.every().thursday.at("22:28").do(master.groups)

schedule.every().friday.at("00:00").do(master.groups)
schedule.every().saturday.at("00:00").do(master.events_and_members)
schedule.every().sunday.at("00:00").do(master.rsvp)



while 1:
    schedule.run_pending()
    time.sleep(1)