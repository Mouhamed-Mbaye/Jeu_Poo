require 'bundler'
Bundler.require
require_relative 'lib/game'
require_relative 'lib/player'
#binding.pry

player1 = Player.new("Josiane")
player2 = Player.new("José")

puts "Voici l'état de chaque joueur :"
player1.show_state
player2.show_state

puts "Passons à la phase d'attaque :"
while player1.life_points > 0 && player2.life_points > 0
  player1.attacks(player2)
  break if player2.life_points <= 0
  player2.attacks(player1)
  puts "Voici l'état de chaque joueur :"
  player1.show_state
  player2.show_state
end

