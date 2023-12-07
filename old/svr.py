from sklearn import svm
import pandas

def predict(input):
    data = pandas.read_csv('Combined_Daily.csv')
    data.dropna(inplace=True)
    data = data.drop(columns=['date'])

    X = data[data.columns[:-1]]
    Y = data['generation_mw']

    clf = svm.SVR(kernel="rbf")
    clf.fit(X, Y)

    inputdata = {}
    i=0

    for x in data.columns[:-1]:
        inputdata[x] = float(input[i])
        i=i+1
    print(inputdata)
    input_data = pandas.DataFrame([inputdata])

    # print("Predicted Power: ", clf.predict(inputdata)[0])
    return str(clf.predict(input_data)[0])
