require './lib/oystercard'

card = Oystercard.new 10
station1 = Station.new 'Bank', 2
station2 = Station.new 'Holland Park', 2
station3 = Station.new 'Victoria', 1
station4 = Station.new 'Clapham Junction', 3

p card

card.touch_in station1
card.touch_out station2

card.touch_in station3
card.touch_out station4

card.top_up 10

p card
