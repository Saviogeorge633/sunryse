from sklearn.ensemble import RandomForestRegressor
import pandas as pd

def predict(input):
    # Load the data
    data = pd.read_csv('Combined_Daily.csv')
    data.dropna(inplace=True)
    data = data.drop(columns=['date'])

    X = data.drop(columns=['generation_mw'])
    Y = data['generation_mw']

   
    regressor = RandomForestRegressor(n_estimators=100, random_state=42)

    # Train the model
    regressor.fit(X, Y)

    inputdata = {}
    i=0

    for x in data.columns[:-1]:
        inputdata[x] = float(input[i])
        i=i+1
    print(inputdata)
    input_data = pd.DataFrame([inputdata])

    return str(regressor.predict(input_data)[0])