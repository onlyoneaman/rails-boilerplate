class NotFoundController < ApplicationController
  def anything
    render plain: I18n.t('messages.not_found'), :status => :not_found
  end
end
