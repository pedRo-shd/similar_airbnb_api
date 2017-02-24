class Api::V1::TalksController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :set_api_v1_talk, only: [:messages]
  before_action :is_talk_participant?, only: [:messages]


  def index
    page = (params[:page])? params[:page] : 1
    @talks = Talk.includes(:messages)
      .joins(:property) # Junta duas tabelas e faz uma query mista, neste caso user + property
      .where(["properties.user_id = ? or talks.user_id = ?", current_api_v1_user.id, current_api_v1_user.id]) # Verifica se o current_user é o dono da propriedade e se o current_user é o que iniciou o talk
      .group("talks.id, messages.created_at, messages.id")
      .order("messages.created_at DESC")
      .paginate(:page => page, :per_page => 8)
  end

  def messages
  end

  def create_message
    begin
    # Pega o talk ou caso ele ainda não exista, cria.
      if params[:id]
        set_api_v1_talk
      elsif params[:property_id]
        @talk = Talk.create(property: Property.find(params[:property_id]), user: current_api_v1_user)
      else
        raise "Without the correct parameters"
      end
      @talk.messages << Message.create(body: params[:body], user: current_api_v1_user)
      render json: {success: true}, status: 200
    rescue Exception => errors
      render json: errors, status: :unprocessable_entity
    end
  end

  def is_talk_participant?
    if @talk.user != current_api_v1_user and @talk.property.user != current_api_v1_user
      render json: {message: 'unauthorized'}, status: 401 and return
    end
  end


  private

  def set api_v1_talk
    @talk = Talk.find(params['id'])
  end

end
