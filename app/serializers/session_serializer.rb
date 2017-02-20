# frozen_string_literal:true

class SessionSerializer < ActiveModel::Serializer
  attributes :id, :players, :rating, :notes, :user, :editable
  has_one :game
  def user
    object.user.id
  end

  def editable
    scope == object.user
  end
end
