import pandas as pd

# Load the data
df = pd.read_csv('PV_Live.csv')

# Convert the 'datetime_gmt' column to datetime format
df['datetime_gmt'] = pd.to_datetime(df['datetime_gmt'])

# Set 'datetime_gmt' as the index
df.set_index('datetime_gmt', inplace=True)

# Resample the data to daily frequency
df_daily = df.resample('D').agg({
    'generation_mw': 'sum',
    'lcl_mw': 'sum',
    'ucl_mw': 'sum',
    'capacity_mwp': 'max',
    'installedcapacity_mwp': 'max'
})

# Save the processed data to a new CSV file
df_daily.to_csv('PV_Live_Daily.csv')