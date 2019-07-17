class First < ActiveRecord::Migration[5.1]  
  def change

    create_table :groups do |t|

      t.integer :group_id, limit: 5, unique: true
      t.text :name
      t.text :urlname
      t.integer :meta_category_id, limit: 5
      t.integer :meta_category_category_ids, default: [], array: true, limit: 5
      t.text :category_name
      t.integer :category_id, limit: 5


      t.text :city
      t.integer :organizer_id, limit: 5

      t.text :organizer_name
      t.date :date_of_creation
      t.text :description
      t.text :link
      t.integer :members
      t.text :who
      t.float :lat
      t.text :meta_category_name
      t.float :lon
      t.datetime :created_at
      t.datetime :updated_at



    end


    add_index :groups,:group_id, unique: true
#    add_index :past_events, :event_id, unique: true


    create_table :groups_history do |t|

      t.integer :group_id, limit: 5, unique: true
      t.text :name
      t.text :urlname
      t.integer :meta_category_id, limit: 5
      t.integer :meta_category_category_ids, default: [], array: true, limit: 5
      t.text :category_name
      t.integer :category_id, limit: 5


      t.text :city
      t.integer :organizer_id, limit: 5

      t.text :organizer_name
      t.date :date_of_creation
      t.text :description
      t.text :link
      t.integer :members
      t.text :who
      t.float :lat
      t.text :meta_category_name
      t.float :lon
      t.datetime :created_at
      t.datetime :updated_at



    end



    create_table :past_events do |t|

      t.text :event_id, unique: true
      t.references :group
      t.text :urlname

      t.text :name
      t.text :description

      t.integer :number_of_participants
   	  t.text :participants_names, default: [], array: true
   	  t.text :member_bios, default: [], array: true

      t.text :venue

      t.text :address
      t.text :link
  	  t.date :event_date

	  t.time :event_time
  	  t.float :venue_lat
  	  t.float :venue_lon
      t.text :venue_address
      t.text :venue_city
      t.text :venue_state
      t.text :venue_country
      t.text :venue_name

      t.datetime :created_at
      t.datetime :updated_at


    end
    add_index :past_events, :event_id, unique: true



    create_table :events do |t|

      t.text :event_id, unique: true
      t.references :group

      t.text :name
      t.text :description

      t.integer :number_of_participants
   	  t.text :participants_names, default: [], array: true
   	  t.text :member_bios, default: [], array: true

      t.text :venue
      t.text :urlname

      t.text :venue_address
      t.text :link
  	  t.date :event_date
      t.text :venue_city
      t.text :venue_state
      t.text :venue_country
	  t.time :event_time
  	  t.float :lat
  	  t.float :lon

      t.text :venue_name

      t.datetime :created_at
      t.datetime :updated_at



    end

    add_index :events, :event_id, unique: true

    create_table :group_members do |t|

      t.integer :member_id, limit: 5
      t.integer :group_id, limit: 5

      t.text :name
      t.text :bio
      t.text :city
      t.text :country
      t.text :gender
      t.date :birthday

      t.text :link
      t.text :meetup_profile_link



      t.datetime :created_at
      t.datetime :updated_at



    end

    create_table :rsvps do |t|

      t.integer :member_id, limit: 5, null: false
   	  t.integer :member_ids, limit: 5, default: [], array: true
      t.integer :group_id, limit: 5
      t.text :group_urlname

      t.text :event_id, null: false
      t.text :link

      t.text :response
     # t.text :meetup_profile_link

      t.date :event_date
      t.datetime :created_at
      t.datetime :updated_at



    end
    execute "ALTER TABLE rsvps ADD UNIQUE (member_id, event_id);"
    execute "ALTER TABLE group_members ADD UNIQUE (member_id, group_id);"


    create_table :topics do |t|

      t.integer :topic_id, limit: 5, unique: true
      t.text :lang

      t.text :name
      t.text :description

      t.integer :member_count
      t.integer :group_count

      t.text :urlkey
  
      t.datetime :created_at
      t.datetime :updated_at


    end
    add_index :topics, :topic_id, unique: true


  end
end
