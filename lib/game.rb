class Game
  attr_accessor :human_player, :enemies_in_sight, :players_left

  def initialize(name)
    @human_player = HumanPlayer.new(name)
    @enemies_in_sight = []
    @players_left = 10
  end

  def kill_player(player)
    @enemies_in_sight.delete(player)
  end

  def is_still_ongoing?
    @human_player.life_points > 0 && @enemies_in_sight.any? { |enemy| enemy.life_points > 0 }
  end

  def show_players
    @human_player.show_state
    puts "Il reste #{@enemies_in_sight.count} ennemis en vue."
  end

  def menu
    puts "\nQuelle action veux-tu effectuer ?"
    puts "a - chercher une meilleure arme"
    puts "s - chercher à se soigner"
    puts "attaquer un joueur en vue :"
    @enemies_in_sight.each_with_index do |enemy, index|
      puts "#{index} - #{enemy.name} a #{enemy.life_points} points de vie"
    end
  end

  def menu_choice(choice)
    case choice
    when "a"
      @human_player.search_weapon
    when "s"
      @human_player.search_health_pack
    when /\d+/
      index = choice.to_i
      if index < @enemies_in_sight.length
        @human_player.attacks(@enemies_in_sight[index])
        kill_player(@enemies_in_sight[index]) if @enemies_in_sight[index].life_points <= 0
      end
    end
  end

  def enemies_attack
    @enemies_in_sight.each do |enemy|
      if enemy.life_points > 0
        enemy.attacks(@human_player)
      end
    end
  end

  def end
    puts "La partie est finie"
    if @human_player.life_points > 0
      puts "BRAVO ! TU AS GAGNE !"
    else
      puts "Loser ! Tu as perdu !"
    end
  end

  def new_players_in_sight
    if @enemies_in_sight.length == @players_left
      puts "Tous les joueurs sont déjà en vue"
      return
    end

    dice = rand(1..6)
    case dice
    when 1
      puts "Aucun nouveau joueur n'arrive."
    when 2..4
      new_enemy = Player.new("joueur_#{rand(1000..9999)}")
      @enemies_in_sight << new_enemy
      puts "Un nouvel ennemi arrive : #{new_enemy.name}"
    when 5..6
      2.times do
        new_enemy = Player.new("joueur_#{rand(1000..9999)}")
        @enemies_in_sight << new_enemy
        puts "Un nouvel ennemi arrive : #{new_enemy.name}"
      end
    end
  end
end

