require 'bundler'
Bundler.require
require_relative 'lib/game'
require_relative 'lib/player'

puts "-------------------------------------------------"
puts "|Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |"
puts "|Le but du jeu est d'être le dernier survivant !|"
puts "-------------------------------------------------"

print "Quel est ton prénom ? "
user_name = gets.chomp
user = HumanPlayer.new(user_name)

enemies = [Player.new("Josiane"), Player.new("José")]

while user.life_points > 0 && (enemies[0].life_points > 0 || enemies[1].life_points > 0)
  puts "\nVoici ton état :"
  user.show_state

  puts "\nQuelle action veux-tu effectuer ?"
  puts "a - chercher une meilleure arme"
  puts "s - chercher à se soigner"
  puts "attaquer un joueur en vue :"
  enemies.each_with_index do |enemy, index|
    puts "#{index} - #{enemy.name} a #{enemy.life_points} points de vie"
  end

  choice = gets.chomp
  case choice
  when "a"
    user.search_weapon
  when "s"
    user.search_health_pack
  when "0"
    user.attacks(enemies[0])
  when "1"
    user.attacks(enemies[1])
  end

  puts "\nLes autres joueurs t'attaquent !"
  enemies.each do |enemy|
    if enemy.life_points > 0
      enemy.attacks(user)
    end
  end
end

puts "La partie est finie"
if user.life_points > 0
  puts "BRAVO ! TU AS GAGNE !"
else
  puts "Loser ! Tu as perdu !"
end

