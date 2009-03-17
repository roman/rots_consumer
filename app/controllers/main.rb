# The only way to have the Strategies on the controller is like this
# this sucks! :-@
require Merb.root / 'merb' / 'merb-auth' / 'strategies'

class Main < Application

  before :ensure_authenticated, :with => [::OpenIDAuth],
                                :exclude => [:signup]

  def index
    @user = session.user
    if session[:new_user]
      session.delete(:new_user)
      render :template => 'main/new_user'
    else
      render
    end
  end
  
  def signup
    if request.get?
      @user = User.new(session.include?(:"openid.attributes") ? session.delete(:"openid.attributes") : {})
      render
    elsif request.post?
      @user = User.new(params[:user])
      if @user.save
        render :template => 'main/index'
      else
        render
      end
    end
  end
  
end
