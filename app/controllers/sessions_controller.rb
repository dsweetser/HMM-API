# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :set_session, only: [:show, :update, :destroy]
  def index
    @sessions = Session.all

    render json: @sessions
  end

  def show
    render json: @session
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_session
    @session = Session.find(params[:id])
  end
  private :set_session

  # Only allow a trusted parameter "white list" through.
  def session_params
    params.require(:session).permit(:player, :game, :rating, :players, :notes)
  end
  private :session_params
end
