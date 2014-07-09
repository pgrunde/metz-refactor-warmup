class Game < ActiveRecord::Base
  serialize :last_roll, Array
end
