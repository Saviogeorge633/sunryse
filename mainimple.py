from flask import Flask, request, jsonify
from datac import prodata
from svr import predict


app = Flask(__name__)

@app.route('/predict', methods=['POST'])
def process_input():
    data = request.get_json()

    field1 = data.get('maxTemp')
    field2 = data.get('minTemp')
    field3 = data.get('avgTemp')
    field4 = data.get('maxWindSpeed')
    field5 = data.get('totalPrecipitation')
    field6 = data.get('avgVisibility')
    field7 = data.get('avgHumidity')
    field8 = data.get('uv')

    inputlist = [field1, field2, field3, field4, field5, field6, field7, field8]

    result = predict(inputlist)

    return jsonify({'result': result})


#prodata('1')

if __name__ == '__main__':
    app.run(host='172.22.39.28', port=5000)
