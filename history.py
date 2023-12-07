import requests
import json

def get_weather_history(api_key, city, date):
    base_url = "http://api.weatherapi.com/v1/history.json"
    params = {
        "key": api_key,
        "q": city,
        "dt": date
    }
    response = requests.get(base_url, params=params)
    data = response.json()
    return data

api_key = "c0504a01e0214430ae3150810230111"  # replace <mykey> with your actual API key
city = "Sheffield"
date = "2023-10-01"

weather_data = get_weather_history(api_key, city, date)
print(json.dumps(weather_data, indent=4))
