require "sinatra"
require "sinatra/reloader"
require "httparty"
def view(template); erb template.to_sym; end

get "/" do
  lat = 42.0574063
  long = -87.6722787

  units = "imperial" 
  weatherkey = "3a00ff0f6b42b1db69b14e91227809d8" 

 url = "https://api.openweathermap.org/data/2.5/onecall?lat=#{lat}&lon=#{long}&units=#{units}&appid=#{weatherkey}"
 @forecast = HTTParty.get(url).parsed_response.to_hash

puts "It is currently #{forecast["current"]["temp"]} degrees and #{forecast["current"]["weather"][0]["description"]}"
puts "Extended forecast:"
day_number = 1
for day in forecast["daily"]
   puts "On day #{day_number}, A high of #{day["temp"]["max"]} and #{day["weather"][0]["description"]}"
   day_number = day_number + 1

newskey = "8af4a07f62b14292a119d44079539a67"
url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=#{newskey}"
@news = HTTParty.get(url).parsed_response.to_hash

for headline in news["articles"]
    puts "Today's top story is #{news["articles"]["source"][0]["headline"]["name"]}"

 view "news"

end

