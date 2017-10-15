require 'sinatra'

class MyApp < Sinatra::Base
  get '/' do
    "<!DOCTYPE html><html><head></head><body><h1>Mi tercera aplicación de SAAS</h1></body></html>"
  end
end