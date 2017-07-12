require './lib/oystercard'

card = Oystercard.new 5
station_in = 'Picadilly Circus'
station_out = 'Bank'
station_in1 = 'Hammersmith'
station_out1 = 'Central'
p card

card.top_up 10

card.touch_in station_in
p card

card.touch_out station_out
p card
