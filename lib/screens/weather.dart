import 'dart:developer';
import '../services/location.dart';
import '../services/networking.dart';

const apiKey = '37f5eaac8d6bd4b56ed3fef9c3b10986';

class WeatherModel {
  // double? lattitudee;
  // double? longitudee;

  Future<dynamic> getCityWeather(String cityName) async {
    var url =
        'https://api.openweathermap.org/data/2.5/weather?q=${cityName}&appid=${apiKey}&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url);

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    // print(location.long);
    // print(location.lat);

    // lattitudee = location.lat;
    // longitudee = location.long;
    // setState(() {});

    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.lat}&lon=${location.long}&appid=${apiKey}&units=metric');

    // print('Responce code is here ${responce.statusCode}');
    // print('Response Body is here ${responce.body}');

    var weatherData = await networkHelper.getData();
    log('!!!!!!!!!!!!!!!!!!!!!' + weatherData['main']['temp'].toString());
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩️';
    } else if (condition < 400) {
      return '🌧️';
    } else if (condition < 600) {
      return '☔';
    } else if (condition < 700) {
      return '⛄';
    } else if (condition < 800) {
      return '🏳️‍🌈';
    } else if (condition == 800) {
      return ' ☀️';
    } else if (condition <= 800) {
      return '☁️';
    } else {
      return '💀';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
