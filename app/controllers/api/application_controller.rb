module Api
  class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :null_session

    before_action :doorkeeper_authorize!, :create_log


    def current_user
      User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
    end

    def create_log
      Rails.logger.debug "=================== CLASS_NAME; #{self.class.name}"

      ::Log.create(login: current_user.present? ? current_user.login : '',
                  method: request.method,
                  controller: request.path_parameters,
                  parameters: params.inspect
      )
    end

    def process_exception(exception)

      ErrorTrack.create(message: exception.message,
                        trace: exception.backtrace[0,10].join("\n"),
                        parameter: params.inspect)

      logger.warn "#{self.class.name}.create : #{exception.class.name}"

      message = exception.class.name.match('ActiveRecord::RecordInvalid') ?
          exception.record.errors.to_json : exception.message

      render json: {
          success: false,
          message: message
      }
    end
  end

end
