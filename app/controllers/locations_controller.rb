class LocationsController < ApplicationController
  
  def search
  end
  
  def index
    @third_space_yelp_ids = third_space_yelp_ids
    @location_results = find_locations
    ##Create error when data is NIL to make new entries
  end
  
  def show
    location_id = params[:id]
    @location = find_show_details
    @location_json = @location.to_json
    @reviews = find_show_reviews(location_id)
  end

  def new
  end

  def create
  end
  
  private


  def third_space_yelp_ids
    spaces = ThirdSpacesFacade.new.spaces
    list = []
    spaces.map do |space|
      list << space.yelp_id
    end
    list
  end

  def find_locations
    conn = Faraday.new(url: "http://localhost:3000") do |faraday| 
      faraday.params["name"] = params[:name]
      faraday.params["city"] = params[:city]
    end
    response = conn.get("/api/v1/locations/search_locations")
    data = JSON.parse(response.body, symbolize_names: true)[:data]
    return [] if data.nil? 

    search_results = data.map do |d|
      SearchResult.new(d[:attributes])
    end
  end

  def find_show_details
    location_id = params[:id]
    conn = Faraday.new(url: "http://localhost:3000/")
    response = conn.get("api/v1/locations/#{location_id}")
    # require 'pry'; binding.pry
    json = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]

    DetailedLocation.new(json)
  end

  # def find_show_reviews
  #   location_id = params[:id]
  #   conn = Faraday.new(url: "http://localhost:3000/")
  #   response = conn.get("api/v1/locations/#{location_id}/reviews")
  #   data = JSON.parse(response.body, symbolize_names: true)[:data]

  #   reviews = data.map do |d|
  #     ReviewPoro.new(d[:attributes])
  #   end
  # end

  
end