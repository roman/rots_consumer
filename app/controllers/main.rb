# The only way to have the Strategies on the controller is like this
# this sucks! :-@
require Merb.root / 'merb' / 'merb-auth' / 'strategies'

class Main < Application

  before :ensure_authenticated, :with => [::OpenIDAuth]

  def index
    render
  end
  
end
