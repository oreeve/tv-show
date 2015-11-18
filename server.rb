require 'sinatra'
require 'csv'
require 'pry'
require_relative "app/models/television_show"

set :views, File.join(File.dirname(__FILE__), "app/views")

before do
  @shows = []
  CSV.foreach("television-shows.csv", headers: true, header_converters: :symbol) do |row|
    show = row.to_hash
    @shows << show
  end
end

get '/TVShows' do
  erb :index
end

get '/TVShows/new' do
  erb :new
end

post '/TVShows' do
  @boolean = false

  @shows.each {|show| @boolean = true if show.values.include?(params[:title])}

  title = params['title']
  network = params['network']
  starting_year = params['starting_year']
  synopsis = params['synopsis']
  genre = params['genre']

  data = [title, network, starting_year, synopsis, genre]

  if data.any? { |item| item == nil || item == ""}
    @not_filled = true
    erb :new
  elsif @boolean
     erb :error
  else
    CSV.open('television-shows.csv', 'a') do |csv|
      csv << [params[:title],params[:network],params[:starting_year],params[:synopsis],params[:genre]]
    end
    redirect "/TVShows"
  end
end
