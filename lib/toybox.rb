require 'toybox/toybox_helpers'

module Toybox
  
  def self.included(base)
    ActionController::Base.helper ToyboxHelpers
  end

  def render_to_box( options = {} )
     l = options.delete(:layout) { false }

     if options[:action]
       s = render_to_string(:action => options[:action], :layout => l)
     elsif options[:template]
       s = render_to_string(:template => options[:template], :layout => l)
     elsif !options[:partial] && !options[:html]
       s = render_to_string(:layout => l)
     end

     render :update do |page|
       if options[:action]
         page << "jQuery.facebox(#{s.to_json})"
       elsif options[:template]
         page << "jQuery.facebox(#{s.to_json})"
       elsif options[:partial]
         page << "jQuery.facebox(#{(render :partial => options[:partial]).to_json})"
       elsif options[:html]
         page << "jQuery.facebox(#{options[:html].to_json})"
       else
         page << "jQuery.facebox(#{s.to_json})"
       end

       if options[:msg]
         page << "jQuery('#facebox .content').prepend('<div class=\"message\">#{options[:msg]}</div>')"
       end

       yield(page) if block_given?

     end
   end

   # close an existed facebox, you can pass a block to update some messages
   def close_box
     render :update do |page|
       page << "jQuery.facebox.close();"
       yield(page) if block_given?
     end
   end

   # redirect_to other_path (i.e. reload page)
   def redirect_out_of_box(url)
     render :update do |page|
       page.redirect_to url
     end
   end

   # redirect to another facebox page
   def redirect_to_box(url)
     render :update do |page|
       page << "$.getScript('#{url}')"
     end
   end
  
end

ActionController::Base.send :include, Toybox