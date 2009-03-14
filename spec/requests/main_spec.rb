require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe "/main" do
  before(:each) do
    @response = request("/main")
  end
end