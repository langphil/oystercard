require './lib/oystercard'

card = Oystercard.new
p card

card.top_up 10
p card.balance

card.touch_in
p card

card.touch_out
p card
p card.balance
