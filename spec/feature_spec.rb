require './lib/oystercard'

card = Oystercard.new
p card
p card.balance

card.top_up 20
p card.balance

card.touch_in
p card

card.touch_out
p card
