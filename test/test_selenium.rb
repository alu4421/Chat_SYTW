# -*- coding: utf-8 -*-
require_relative '../chat.rb'
require 'test/unit'
require 'minitest/autorun'
require 'rack/test'
require 'selenium-webdriver'
require 'rubygems'

include Rack::Test::Methods

def app
   Sinatra::Application
end

describe "Chatina Test Selenium" do

	#Al Arrancar
	before :all do
	  @navegador = Selenium::WebDriver.for :firefox
	  @url = 'http://chatina.herokuapp.com/'
	  @navegador.get(@site)
	  @navegador.manage().window().maximize()
	  @navegador.manage.timeouts.implicit_wait = 10
   end
	#Al Salir
   after :all do
	  @navegador.quit
   end

   it "Pagina Principal S" do
	  assert_equal(@url, @navegador.current_url)
   end

end