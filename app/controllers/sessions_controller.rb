# frozen_string_literal: true

class SessionsController < ApplicationController
  def index
    @sessions = Session.all

    render json: @sessions
  end
end
