{"filter":false,"title":"venues_controller.rb","tooltip":"/app/controllers/venues_controller.rb","undoManager":{"mark":10,"position":0,"stack":[[{"start":{"row":69,"column":83},"end":{"row":69,"column":84},"action":"insert","lines":[" "],"id":2}],[{"start":{"row":92,"column":41},"end":{"row":92,"column":42},"action":"insert","lines":["e"],"id":13}],[{"start":{"row":92,"column":40},"end":{"row":92,"column":41},"action":"insert","lines":["u"],"id":13}],[{"start":{"row":92,"column":40},"end":{"row":92,"column":41},"action":"remove","lines":["y"],"id":14}],[{"start":{"row":92,"column":41},"end":{"row":92,"column":42},"action":"remove","lines":["e"],"id":15}],[{"start":{"row":92,"column":41},"end":{"row":92,"column":42},"action":"insert","lines":["e"],"id":16}],[{"start":{"row":92,"column":40},"end":{"row":92,"column":41},"action":"insert","lines":["y"],"id":17}],[{"start":{"row":92,"column":39},"end":{"row":92,"column":40},"action":"insert","lines":["n"],"id":18}],[{"start":{"row":92,"column":38},"end":{"row":92,"column":39},"action":"insert","lines":["e"],"id":19}],[{"start":{"row":92,"column":37},"end":{"row":92,"column":41},"action":"remove","lines":["room"],"id":20},{"start":{"row":92,"column":37},"end":{"row":92,"column":38},"action":"insert","lines":["v"]}],[{"start":{"row":92,"column":6},"end":{"row":92,"column":109},"action":"remove","lines":["check_2 = venue.calendars.where(\"day BETWEEN ? AND ? AND status = ?\", start_date, end_date, 1).limit(1)"],"id":21},{"start":{"row":92,"column":6},"end":{"row":92,"column":129},"action":"insert","lines":["check_unavailble_in_calendar = room.calendars.where(\"day BETWEEN ? AND ? AND status = ?\", start_date, end_date, 1).limit(1)"]}]]},"ace":{"folds":[],"scrolltop":1080,"scrollleft":0,"selection":{"start":{"row":92,"column":109},"end":{"row":92,"column":109},"isBackwards":false},"options":{"guessTabSize":true,"useWrapMode":false,"wrapToView":true},"firstLineState":{"row":76,"state":"start","mode":"ace/mode/ruby"}},"timestamp":1517322245729,"hash":"ee1e7fb688f9afdce4000887120c1d3d2e842647"}