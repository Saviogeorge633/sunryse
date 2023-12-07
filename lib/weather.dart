class Weather {
    final double tempC;
    final double feelslikeC;
    final String condition;
    final double windKph;
    final double pressureIn;
    final int humidity;
    final double uv;
    final String iconUrl;

    Weather({
        required this.tempC,
        required this.feelslikeC,
        required this.condition,
        required this.windKph,
        required this.pressureIn,
        required this.humidity,
        required this.uv,
        required this.iconUrl,
    });

    factory Weather.fromJson(Map<String, dynamic> json) {
        return Weather(
            tempC: json['temp_c'],
            feelslikeC: json['feelslike_c'],
            condition: json['condition']['text'],
            windKph: json['wind_kph'],
            pressureIn: json['pressure_in'],
            humidity: json['humidity'],
            uv: json['uv'],
            iconUrl: json['condition']['icon'],
        );
    }
}