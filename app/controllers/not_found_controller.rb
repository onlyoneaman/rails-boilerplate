class NotFoundController < ApplicationController
  def anything
    render plain: t('messages.not_found'), :status => :not_found
  end
end
