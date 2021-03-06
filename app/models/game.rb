# frozen_string_literal:true

class Game < ApplicationRecord
  has_many :sessions

  validates :name, presence: true
end
