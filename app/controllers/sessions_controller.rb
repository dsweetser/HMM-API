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

  def create
    @session = Session.new(session_params)

    if @session.save
      render json: @session, status: :created, location: @session
    else
      render json: @session.errors, status: :unprocessable_entity
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_session
    @session = Session.find(params[:id])
  end
  private :set_session

  # Only allow a trusted parameter "white list" through.
  def session_params
    params.require(:session).permit(:user_id,
                                    :game_id, :rating, :players, :notes)
  end
  private :session_params
end
