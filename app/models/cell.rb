class Cell
  include Mongoid::Document
  embedded_in :line
  field :bomb, type: Boolean, default: false

  def is_bomb?
    return bomb
  end
end
