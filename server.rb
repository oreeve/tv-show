require 'sinatra'
require 'csv'
require 'pry'
require_relative "app/models/television_show"

set :views, File.join(File.dirname(__FILE__), "app/views")

get '/TVShows' do
  @shows = []
  CSV.foreach("television-shows.csv", headers: true, header_converters: :symbol) do |row|
    show = row.to_hash
    @shows << show
  end
  erb :index
end

get '/TVShows/new' do
  erb :new
end

post '/TVShows' do
  # CSV.foreach("television-shows.csv", headers: true, header_converters: :symbol) do |row|
      CSV.open('television-shows.csv', 'a+') do |csv|
        csv << [params[:title],params[:network],params[:starting_year],params[:synopsis],params[:genre]]
      end
  #     erb :index
  redirect "/TVShows"
  # end
end
