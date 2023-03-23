class PingController < ApplicationController
  def ping
    render json: 'ava_pong', :status => :ok
  end
end
