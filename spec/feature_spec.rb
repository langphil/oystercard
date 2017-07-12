require './lib/oystercard'

card = Oystercard.new 5
station_one = Station.new 'Kenginston Olympia', 2
station_two = Station.new 'Shepherds Bush', 2
station_three = Station.new 'Victoria', 1
station_four = Station.new 'Clapham Junction', 2
p card

card.touch_in station_one
card.touch_out station_two

card.touch_in station_three
card.touch_out station_four

p card
