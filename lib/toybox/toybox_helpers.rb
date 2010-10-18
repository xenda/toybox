module Toybox
  
  module ToyboxHelpers

    def link_to_box(name, options = {}, html_options = nil)
      if options[:url]
        options[:url][:dialog_token] = "Hey"
      link_to_function(name, "jQuery.facebox(function(){ #{remote_function(options)} })", html_options || options.delete(:html))
    end

  end
  
end