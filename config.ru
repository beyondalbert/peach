require 'sinatra/base'
require 'sinatra/activerecord'
require './helpers/application_helper.rb'
require './controllers/application_controller.rb'

Dir.glob('./{helpers,controllers,models}/*.rb').each {|file| require file}

map('/peach/users') { run UsersController }
map('/peach/pictures') { run PicturesController }
map('/peach/') { run ApplicationController }
