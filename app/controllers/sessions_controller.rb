# frozen_string_literal: true

class SessionsController < OpenReadController
  before_action :set_session, only: [:update, :destroy]

  def single_index
    @sessions = current_user.sessions

    render json: @sessons
  end

  def index
    @sessions = Session.all

    render json: @sessions
  end

  def create
    @session = current_user.sessions.build(session_params)

    if @session.save
      render json: @session, status: :created, location: @session
    else
      render json: @session.errors, status: :unprocessable_entity
    end
  end

  def update
    if @session.update(session_params)
      render json: @session
    else
      render json: @session.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @session.destroy
    else
      render json: @session.errors, status: :unprocessable_entity
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_session
    @session = current_user.sessions.find(params[:id])
  end
  private :set_session

  # Only allow a trusted parameter "white list" through.
  def session_params
    params.require(:session).permit(:game_id, :rating, :players, :notes)
  end
  private :session_params
end
