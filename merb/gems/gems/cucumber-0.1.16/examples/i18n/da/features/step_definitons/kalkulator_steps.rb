# encoding: utf-8
require 'spec/expectations'
$:.unshift(File.dirname(__FILE__) + '/../../lib')
require 'cucumber/formatters/unicode'
require 'kalkulator'

Before do
  @calc = Kalkulator.new
end

After do
end

Given /at jeg har indtastet (\d+)/ do |n|
  @calc.push n.to_i
end

When 'jeg summerer' do
  @result = @calc.add
end

Then /skal resultatet være (\d*)/ do |result|
  @result.should == result.to_i
end
