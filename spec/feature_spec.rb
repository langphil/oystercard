require './lib/oystercard'

card = Oystercard.new 5
p card

card.touch_in
p card

card.touch_out
p card
