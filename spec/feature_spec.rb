require './lib/oystercard'

card = Oystercard.new 5
station = 'Picadilly Circus'
p card

card.top_up 10

card.touch_in station
p card

card.touch_out
p card
