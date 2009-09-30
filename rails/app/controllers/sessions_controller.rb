require "pp"

class SessionsController < ApplicationController
  
  def create
    authenticate_with_open_id(params[:identity_url], 
      :required => %w(email fullname)) do |result, identity_url, sreg|
      case result.status
      when :missing
        failed_login "Sorry, the OpenID server couldn't be found"

      when :invalid
        failed_login "Sorry, but this does not appear to be a valid OpenID"

      when :canceled
        failed_login "OpenID verification was canceled"

      when :failed
        failed_login "Sorry, the OpenID verification failed"
                  
      when :successful
        if user = User.find_by_identity_url(identity_url)
          session[:user_id] = user.id
          user.update_attributes(registration_attrs(sreg))
          redirect_to users_path
        else
          flash[:error] = "The user was not found, create a new one."
          flash[:user_attributes] = registration_attrs(sreg)
          redirect_to new_user_path
        end

      end
    end
    Rails.logger.debug("\x1B[32m")
    Rails.logger.debug(PP.pp(session, ""))
    Rails.logger.debug("\x1B[0m")
  end
  
  def new
  end
  
  protected
  
  def failed_login(message)
    flash[:error] = message
    redirect_to(new_session_path)
  end
  
  def registration_attrs(sreg)
    model_to_registration_mapping.inject({}) do |attrs, (model_attr, sreg_attr)|
      attrs[model_attr] = sreg[sreg_attr] if sreg.include?(sreg_attr)
      attrs
    end
  end
  
  def model_to_registration_mapping
    [%w(name fullname), %w(email email)]
  end
  
end
