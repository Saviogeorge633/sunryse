import pandas as pd
import requests
import json
from datetime import datetime, timedelta

def get_weather_history(api_key, city, start_date, end_date):
    base_url = "http://api.weatherapi.com/v1/history.json"
    date = start_date
    weather_data = []
    while date <= end_date:
        params = {
            "key": api_key,
            "q": city,
            "dt": date.strftime("%Y-%m-%d")
        }
        response = requests.get(base_url, params=params)
        data = response.json()
        day_data = data['forecast']['forecastday'][0]['day']
        weather_data.append({
            'date': date.date(),
            'maxtemp_c': day_data['maxtemp_c'],
            'mintemp_c': day_data['mintemp_c'],
            'avgtemp_c': day_data['avgtemp_c'],
            'maxwind_kph': day_data['maxwind_kph'],
            'totalprecip_in': day_data['totalprecip_in'],
            'avgvis_km': day_data['avgvis_km'],
            'avghumidity': day_data['avghumidity'],
            'uv': day_data['uv']
        })
        date += timedelta(days=1)
    return pd.DataFrame(weather_data)

def prodata(input):
    print(input)
    # Load the PV data
    df_pv = pd.read_csv('PV_Live.csv')

    # Convert the 'datetime_gmt' column to datetime format
    df_pv['datetime_gmt'] = pd.to_datetime(df_pv['datetime_gmt'])

    # Set 'datetime_gmt' as the index
    df_pv.set_index('datetime_gmt', inplace=True)

    # Resample the PV data to daily frequency
    df_pv_daily = df_pv.resample('D').agg({
    'generation_mw': 'sum'
    #'lcl_mw': 'sum',
    #'ucl_mw': 'sum',
    #'capacity_mwp': 'max',
    #'installedcapacity_mwp': 'max'
    })

    #Remove the time part from the index and convert it to date
    df_pv_daily.index = df_pv_daily.index.date

    # Rename the index to "date"
    df_pv_daily.index.name = "date"

    # Fetch the weather history data
    api_key = "c0504a01e0214430ae3150810230111"  # replace <mykey> with your actual API key
    city = "Sheffield"
    start_date = datetime(2022, 11, 3)
    end_date = datetime(2023, 10, 31)

    df_weather = get_weather_history(api_key, city, start_date, end_date)
    df_weather.set_index('date', inplace=True)

    # Combine the PV and weather data
    df_combined = pd.concat([df_weather,df_pv_daily], axis=1)

    # Save the combined data to a new CSV file
    df_combined.to_csv('Combined_Daily.csv')

#prodata('1')