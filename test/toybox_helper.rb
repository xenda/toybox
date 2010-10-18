$:.unshift File.expand_path("../lib", File.dirname(__FILE__))
$:.unshift File.expand_path("../lib/toybox", File.dirname(__FILE__))
$:.unshift File.expand_path(File.dirname(__FILE__))
$:.uniq!

require 'rubygems'
require 'test/unit'
require 'action_controller'
require 'action_view'
require 'action_view/test_case'
require 'active_support'
require 'toybox'
require 'toybox/toybox_helpers'

class ToyboxTest < ActiveSupport::TestCase 
  
  def setup
    
  end
    
  def test_it_should_include_toybox_module
    assert true, ActionController::Base.ancestors.include?(Toybox)
  end
      
  
end
