# Metz Refactor Warmup (Apply)

The goal for this warmup is to practice refactoring using Sandi Metz Rules. Use these rules to refactor this class to the best of your ability. Use the specs to ensure functionality is still working, you may need to rewrite them in accordance with your code changes. 

## Sandi Metz Rules

1. Your class can be no longer than 100 lines of code.
2. Your methods can be no longer than five lines of code.
3. You can pass no more than four parameters and you can't just make it one big hash.
4. When a call comes into your Rails controller, you can only instantiate one object to do whatever it is that needs to be done.

## Code to work on

The code you will be refactoring is here: [class](https://github.com/gSchool/metz-refactor-warmup/blob/master/app/models/game.rb), and there is a corresponding [spec](https://github.com/gSchool/metz-refactor-warmup/blob/master/spec/models/games_model_spec.rb).

## Tips

Break one thing at a time. Make a small change and run the specs. Commit often.

***

# Application README

### Hi there! This is a personal project I have been working on. I hope you like it!

### Get this puppy up and running
1. fork, clone, bundle
1. rake db:create db:migrate
1. rails s
1. register and play!

### Live app
* [ten-000.herokuapp.com/](http://ten-000.herokuapp.com/)

### Looking forward to adding:
* Dice are rejected if cannot be scored, flash message is shown? and dice can be used again in next roll
* User can play game with remote players
* User can have multiple games going on, are listed on welcome page

##### Where the hex did those awesome dice come from?
* http://www.unicode.org/charts/PDF/U2600.pdf

##### How the hex did you find those crazy srand numbers?

    it 'finds a certain roll' do
        players = {"player_1" => "Albert", "player_2" => "Eddie"}
        actual_roll = ""
        i = 0
        while actual_roll != [[2, '⚁'],[3, '⚂'],[4, '⚃'],[4, '⚃'],[6, '⚅'],[6, '⚅']]
          srand(i)
          game_turn = Game.new(players)
          game_turn.roll_again([])
          actual_roll = game_turn.last_roll
            p "srand #{i} - #{actual_roll}"
          i+=1
        end
      end
