# This file is specifically for you to define your strategies 
#
# You should declare you strategies directly and/or use 
# Merb::Authentication.activate!(:label_of_strategy)
#
# To load and set the order of strategy processing

#Merb::Slices::config[:"merb-auth-slice-password"][:no_default_strategies] = true

Merb::Authentication.activate!(:default_openid)

class OpenIDCommon < Merb::Authentication::Strategies::Basic::OpenID
  
  # @overwrite
  def required_reg_fields
    ['fullname', 'nickname', 'email']
  end
  
  protected
  
  def transform_reg_fields_to_user_model_fields(sreg)
    [%w(fullname fullname), %w(nickname login), %w(email email)].inject({}) do |result, (sreg_field, user_field)|
      result[user_field] = sreg[sreg_field] if sreg.include?(sreg_field)
      result
    end
  end
  
  
end

class OpenIDAuth < OpenIDCommon
  
  def on_success!(response, sreg_response)
    if (user = find_user_by_identity_url(response.identity_url))
      user
    else
      attributes = transform_reg_fields_to_user_model_fields(sreg_response.data)
      attributes[:identity_url] = response.identity_url
      user = User.new(attributes)
      if user.save
        session[:new_user] = true
        user
      else
        session[:"openid.attributes"] = attributes
        redirect!(Merb::Router.url(:signup))
      end
    end
  end
  
end

class OpenIDAssoc < OpenIDCommon
  
  attr_accessor :user
  
  def initialize(user, request, params)
    super(request, params)
    @user = user
  end
  
  def on_success!(response, sreg_response)
    @user.identity_url = response.identity_url
    @user.attributes = transform_reg_fields_to_user_model_fields(sreg_response.data)
    @user.save
    @user
  end
  
end
