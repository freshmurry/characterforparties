{"filter":false,"title":"schema.rb","tooltip":"/db/schema.rb","undoManager":{"mark":17,"position":17,"stack":[[{"start":{"row":12,"column":44},"end":{"row":12,"column":45},"action":"remove","lines":["5"],"id":2},{"start":{"row":12,"column":44},"end":{"row":12,"column":45},"action":"insert","lines":["9"]},{"start":{"row":12,"column":46},"end":{"row":12,"column":47},"action":"insert","lines":["4"]},{"start":{"row":12,"column":48},"end":{"row":12,"column":52},"action":"remove","lines":["2721"]},{"start":{"row":12,"column":48},"end":{"row":12,"column":51},"action":"insert","lines":["559"]},{"start":{"row":78,"column":48},"end":{"row":80,"column":26},"action":"insert","lines":["","    t.float    \"latitude\"","    t.float    \"longitude\""]}],[{"start":{"row":12,"column":43},"end":{"row":12,"column":51},"action":"remove","lines":["19045559"],"id":3,"ignore":true},{"start":{"row":12,"column":43},"end":{"row":12,"column":51},"action":"insert","lines":["23070344"]},{"start":{"row":44,"column":0},"end":{"row":45,"column":0},"action":"insert","lines":["    t.string   \"access_token\"",""]}],[{"start":{"row":12,"column":44},"end":{"row":12,"column":51},"action":"remove","lines":["3070344"],"id":4,"ignore":true},{"start":{"row":12,"column":44},"end":{"row":12,"column":51},"action":"insert","lines":["4155359"]},{"start":{"row":24,"column":0},"end":{"row":37,"column":0},"action":"insert","lines":["  create_table \"reservations\", force: :cascade do |t|","    t.integer  \"user_id\"","    t.integer  \"venue_id\"","    t.datetime \"start_date\"","    t.datetime \"end_date\"","    t.integer  \"price\"","    t.integer  \"total\"","    t.datetime \"created_at\", null: false","    t.datetime \"updated_at\", null: false","    t.index [\"user_id\"], name: \"index_reservations_on_user_id\"","    t.index [\"venue_id\"], name: \"index_reservations_on_venue_id\"","  end","",""]}],[{"start":{"row":12,"column":42},"end":{"row":12,"column":51},"action":"remove","lines":["824155359"],"id":5,"ignore":true},{"start":{"row":12,"column":42},"end":{"row":12,"column":51},"action":"insert","lines":["902170142"]},{"start":{"row":37,"column":0},"end":{"row":53,"column":0},"action":"insert","lines":["  create_table \"reviews\", force: :cascade do |t|","    t.text     \"comment\"","    t.integer  \"star\",           default: 1","    t.integer  \"venue_id\"","    t.integer  \"reservation_id\"","    t.integer  \"guest_id\"","    t.integer  \"host_id\"","    t.string   \"type\"","    t.datetime \"created_at\",                 null: false","    t.datetime \"updated_at\",                 null: false","    t.index [\"guest_id\"], name: \"index_reviews_on_guest_id\"","    t.index [\"host_id\"], name: \"index_reviews_on_host_id\"","    t.index [\"reservation_id\"], name: \"index_reviews_on_reservation_id\"","    t.index [\"venue_id\"], name: \"index_reviews_on_venue_id\"","  end","",""]}],[{"start":{"row":12,"column":41},"end":{"row":12,"column":50},"action":"remove","lines":["090217014"],"id":6,"ignore":true},{"start":{"row":12,"column":41},"end":{"row":12,"column":50},"action":"insert","lines":["100415320"]},{"start":{"row":74,"column":0},"end":{"row":76,"column":0},"action":"insert","lines":["    t.string   \"pin\"","    t.boolean  \"phone_verified\"",""]}],[{"start":{"row":12,"column":44},"end":{"row":12,"column":51},"action":"remove","lines":["4153202"],"id":7,"ignore":true},{"start":{"row":12,"column":44},"end":{"row":12,"column":51},"action":"insert","lines":["8040316"]},{"start":{"row":76,"column":0},"end":{"row":80,"column":0},"action":"insert","lines":["    t.string   \"confirmation_token\"","    t.datetime \"confirmed_at\"","    t.datetime \"confirmation_sent_at\"","    t.index [\"confirmation_token\"], name: \"index_users_on_confirmation_token\", unique: true",""]}],[{"start":{"row":12,"column":43},"end":{"row":12,"column":51},"action":"remove","lines":["08040316"],"id":8,"ignore":true},{"start":{"row":12,"column":43},"end":{"row":12,"column":51},"action":"insert","lines":["10164235"]},{"start":{"row":113,"column":28},"end":{"row":113,"column":40},"action":"insert","lines":["            "]},{"start":{"row":114,"column":37},"end":{"row":114,"column":43},"action":"insert","lines":["      "]},{"start":{"row":114,"column":43},"end":{"row":114,"column":49},"action":"insert","lines":["      "]},{"start":{"row":117,"column":0},"end":{"row":118,"column":0},"action":"insert","lines":["    t.integer  \"instant\",            default: 1",""]}],[{"start":{"row":12,"column":48},"end":{"row":12,"column":51},"action":"remove","lines":["235"],"id":9,"ignore":true},{"start":{"row":12,"column":48},"end":{"row":12,"column":51},"action":"insert","lines":["348"]},{"start":{"row":31,"column":28},"end":{"row":31,"column":40},"action":"insert","lines":["            "]},{"start":{"row":32,"column":29},"end":{"row":32,"column":40},"action":"remove","lines":["null: false"]},{"start":{"row":32,"column":29},"end":{"row":33,"column":39},"action":"insert","lines":["            null: false","    t.integer  \"status\",     default: 0"]}],[{"start":{"row":12,"column":45},"end":{"row":12,"column":55},"action":"remove","lines":["164348) do"],"id":10,"ignore":true},{"start":{"row":12,"column":45},"end":{"row":22,"column":5},"action":"insert","lines":["220632) do","","  create_table \"calendars\", force: :cascade do |t|","    t.date     \"day\"","    t.integer  \"price\"","    t.integer  \"status\"","    t.integer  \"venue_id\"","    t.datetime \"created_at\", null: false","    t.datetime \"updated_at\", null: false","    t.index [\"venue_id\"], name: \"index_calendars_on_venue_id\"","  end"]}],[{"start":{"row":12,"column":44},"end":{"row":12,"column":51},"action":"remove","lines":["0220632"],"id":11,"ignore":true},{"start":{"row":12,"column":44},"end":{"row":12,"column":51},"action":"insert","lines":["2041653"]},{"start":{"row":90,"column":0},"end":{"row":91,"column":0},"action":"insert","lines":["    t.string   \"stripe_id\"",""]}],[{"start":{"row":12,"column":43},"end":{"row":12,"column":44},"action":"remove","lines":["1"],"id":12,"ignore":true},{"start":{"row":12,"column":45},"end":{"row":12,"column":50},"action":"remove","lines":["41653"]},{"start":{"row":12,"column":45},"end":{"row":12,"column":51},"action":"insert","lines":["175959"]},{"start":{"row":91,"column":0},"end":{"row":92,"column":0},"action":"insert","lines":["    t.string   \"merchant_id\"",""]}],[{"start":{"row":12,"column":44},"end":{"row":12,"column":51},"action":"remove","lines":["0175959"],"id":13,"ignore":true},{"start":{"row":12,"column":44},"end":{"row":12,"column":51},"action":"insert","lines":["4153543"]},{"start":{"row":64,"column":0},"end":{"row":73,"column":0},"action":"insert","lines":["  create_table \"settings\", force: :cascade do |t|","    t.boolean  \"enable_sms\",   default: true","    t.boolean  \"enable_email\", default: true","    t.integer  \"user_id\"","    t.datetime \"created_at\",                  null: false","    t.datetime \"updated_at\",                  null: false","    t.index [\"user_id\"], name: \"index_settings_on_user_id\"","  end","",""]}],[{"start":{"row":12,"column":47},"end":{"row":12,"column":51},"action":"remove","lines":["3543"],"id":14,"ignore":true},{"start":{"row":12,"column":47},"end":{"row":12,"column":51},"action":"insert","lines":["5940"]},{"start":{"row":24,"column":0},"end":{"row":31,"column":0},"action":"insert","lines":["  create_table \"conversations\", force: :cascade do |t|","    t.integer  \"sender_id\"","    t.integer  \"recipient_id\"","    t.datetime \"created_at\",   null: false","    t.datetime \"updated_at\",   null: false","  end","",""]}],[{"start":{"row":12,"column":46},"end":{"row":12,"column":51},"action":"remove","lines":["55940"],"id":15,"ignore":true},{"start":{"row":12,"column":46},"end":{"row":12,"column":51},"action":"insert","lines":["60043"]},{"start":{"row":31,"column":0},"end":{"row":41,"column":0},"action":"insert","lines":["  create_table \"messages\", force: :cascade do |t|","    t.text     \"context\"","    t.integer  \"user_id\"","    t.integer  \"conversation_id\"","    t.datetime \"created_at\",      null: false","    t.datetime \"updated_at\",      null: false","    t.index [\"conversation_id\"], name: \"index_messages_on_conversation_id\"","    t.index [\"user_id\"], name: \"index_messages_on_user_id\"","  end","",""]}],[{"start":{"row":12,"column":45},"end":{"row":12,"column":51},"action":"remove","lines":["160043"],"id":16,"ignore":true},{"start":{"row":12,"column":45},"end":{"row":12,"column":51},"action":"insert","lines":["222531"]},{"start":{"row":41,"column":0},"end":{"row":49,"column":0},"action":"insert","lines":["  create_table \"notifications\", force: :cascade do |t|","    t.string   \"content\"","    t.integer  \"user_id\"","    t.datetime \"created_at\", null: false","    t.datetime \"updated_at\", null: false","    t.index [\"user_id\"], name: \"index_notifications_on_user_id\"","  end","",""]}],[{"start":{"row":168,"column":3},"end":{"row":169,"column":0},"action":"remove","lines":["",""],"id":17}],[{"start":{"row":12,"column":48},"end":{"row":12,"column":50},"action":"remove","lines":["53"],"id":18,"ignore":true},{"start":{"row":12,"column":48},"end":{"row":12,"column":50},"action":"insert","lines":["62"]},{"start":{"row":126,"column":0},"end":{"row":127,"column":0},"action":"insert","lines":["    t.integer  \"unread\",                 default: 0",""]},{"start":{"row":169,"column":3},"end":{"row":170,"column":0},"action":"insert","lines":["",""]}],[{"start":{"row":12,"column":40},"end":{"row":12,"column":51},"action":"remove","lines":["71024222621"],"id":19,"ignore":true},{"start":{"row":12,"column":40},"end":{"row":12,"column":51},"action":"insert","lines":["80109174910"]},{"start":{"row":127,"column":0},"end":{"row":131,"column":0},"action":"insert","lines":["    t.string   \"image_file_name\"","    t.string   \"image_content_type\"","    t.integer  \"image_file_size\"","    t.datetime \"image_updated_at\"",""]}]]},"ace":{"folds":[],"scrolltop":623.5,"scrollleft":0,"selection":{"start":{"row":173,"column":3},"end":{"row":173,"column":3},"isBackwards":false},"options":{"guessTabSize":true,"useWrapMode":false,"wrapToView":true},"firstLineState":{"row":37,"state":"start","mode":"ace/mode/ruby"}},"timestamp":1516486326590,"hash":"3f3f81e791f303adbd829381cb2fdd06b653fcc2"}