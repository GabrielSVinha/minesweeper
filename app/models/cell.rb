class Cell
  include Mongoid::Document
  embedded_in :line
  field :bomb, type: Boolean, default: false
  field :close_bombs, type: Integer, default: 0
  field :flag, type: Boolean, default: false
  field :discovered, type: Boolean, default: false

  def is_bomb?
    return bomb
  end
end
