import requests
import json
from datetime import datetime, timedelta

def get_weather_history(api_key, city, start_date, end_date):
    base_url = "http://api.weatherapi.com/v1/history.json"
    date = start_date
    while date <= end_date:
        params = {
            "key": api_key,
            "q": city,
            "dt": date.strftime("%Y-%m-%d")
        }
        response = requests.get(base_url, params=params)
        data = response.json()
        location = data['location']['name']
        region1= data['location']['region']
        country1=data['location']['country']
        print(f"Weather data for {location},{region1},{country1} on {date.strftime('%Y-%m-%d')}:")
        day_data = data['forecast']['forecastday'][0]['day']
        print(f"Max Temp: {day_data['maxtemp_c']}°C")
        print(f"Min Temp: {day_data['mintemp_c']}°C")
        print(f"Avg Temp: {day_data['avgtemp_c']}°C")
        print(f"Max Wind Speed: {day_data['maxwind_kph']} kph")
        print(f"Total Precipitation: {day_data['totalprecip_in']} in")
        print(f"Avg Visibility: {day_data['avgvis_km']} km")
        print(f"Avg Humidity: {day_data['avghumidity']}")
        print(f"UV Index: {day_data['uv']}\n")
        date += timedelta(days=1)

api_key = "c0504a01e0214430ae3150810230111"  # replace <mykey> with your actual API key
city = "Sheffield"
start_date = datetime(2023, 10, 4)
end_date = datetime(2023, 10, 5 )

get_weather_history(api_key, city, start_date, end_date)
