require 'active_support' # Railsでモジュールを扱いやすくするために必要な記述

module Notifiable
  extend ActiveSupport::Concern # Railsでモジュールを扱いやすくするために必要な記述
  include Rails.application.routes.url_helpers

  def notification_message
    raise NotImplementedError
  end

  def notification_path
    raise NotImplementedError
  end
end