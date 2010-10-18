if ENV['RAILS_ROOT']
  environment = File.expand_path('vendor/gems/environment', ENV['RAILS_ROOT'])
  require environment if File.exist?("#{environment}.rb")
end

$:.unshift File.expand_path('../../lib', __FILE__)

require 'rubygems'
require 'test/unit'
require 'action_view'
require 'action_controller'
require 'active_model'
# require 'prototype_helper'
require 'toybox'
require 'toybox/toybox_helpers'


class Bunny < Struct.new(:Bunny, :id)
end

class Author
  extend ActiveModel::Naming

  attr_reader :id
  def save; @id = 1 end
  def new_record?; @id.nil? end
  def name
    @id.nil? ? 'new author' : "author ##{@id}"
  end
end

class Article
  extend ActiveModel::Naming

  attr_reader :id
  attr_reader :author_id
  def save; @id = 1; @author_id = 1 end
  def new_record?; @id.nil? end
  def name
    @id.nil? ? 'new article' : "article ##{@id}"
  end
end

class Author::Nested < Author; end

class ToyboxHelpersHelperTest < ActionView::TestCase
  
  attr_accessor :formats, :output_buffer, :template_format

  def _evaluate_assigns_and_ivars() end

  def reset_formats(format)
    @format = format
  end

  def setup
    @record = @author = Author.new
    @article = Article.new
    super
    @template = self
    @controller = Class.new do
      def url_for(options)
        if options.is_a?(String)
          options
        else
          url =  "http://www.example.com/"
          url << options[:action].to_s if options and options[:action]
          url << "?a=#{options[:a]}" if options && options[:a]
          url << "&b=#{options[:b]}" if options && options[:a] && options[:b]
          url
        end
      end
    end.new
    
  end
  
  include Toybox::ToyboxHelpers
  

  def test_it_should_include_dialog_token_when_linked
    assert_equal "", set_link
  end
  

  protected
  
  def set_link
    link_to_box("Login Here", "http://domain.com")
  end

  
    def request_forgery_protection_token
      nil
    end

    def protect_against_forgery?
      false
    end

    def create_generator
      block = Proc.new { |*args| yield *args if block_given? }
      JavaScriptGenerator.new self, &block
    end

    def author_path(record)
      "/authors/#{record.id}"
    end

    def authors_path
      "/authors"
    end

    def author_articles_path(author)
      "/authors/#{author.id}/articles"
    end

    def author_article_path(author, article)
      "/authors/#{author.id}/articles/#{article.id}"
    end
end