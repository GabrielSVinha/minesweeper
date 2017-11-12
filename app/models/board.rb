Dir.glob('app/validators/board*').each do |v|
  require_relative "../../#{v}"
end

class Board
  include Mongoid::Document

  field :id, type: String
  field :height, type: Integer
  field :width, type: Integer
  field :bombs_count, type: Integer
  field :playing, type: Boolean, default: true
  embeds_many :lines

  validates_with BoardValidator

  def still_playing?
    playing
  end
end
