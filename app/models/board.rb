Dir.glob('app/validators/board*').each do |v|
  require_relative "../../#{v}"
end

class Board
  include Mongoid::Document

  field :_id, type: String
  field :height, type: Integer
  field :width, type: Integer
  field :bombs_count, type: Integer
  embeds_many :lines

  validates_with BoardValidator
end
