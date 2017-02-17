# frozen_string_literal:true

class SessionSerializer < ActiveModel::Serializer
  attributes :id, :players, :rating
  has_one :game
  has_one :user
end
