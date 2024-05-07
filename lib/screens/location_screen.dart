import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:testing_trail_weather/screens/weather.dart';

import 'ask_city.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});
  final dynamic locationWeather;

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();

  dynamic weatherData;

  void fetchWeatherData() async {
    dynamic data = await WeatherModel().getLocationWeather();
    log('Vakalat ${data}');

    weatherData = data;
    setState(() {});
    updateUi(widget.locationWeather);

    log('Vakalat2 ${weatherData['main']['temp']}');
  }

  String? cityName;
  int? conditionId;
  String? weatherIcons;
  String? weatherMessage;

  int? tempratureOfCity;

  void updateUi(dynamic weatherData) {
    log('Vakalat3 ${weatherData}');

    setState(() {
      if (weatherData == null) {
        tempratureOfCity = 0;
        weatherIcons = 'Error';
        weatherMessage = 'Unable to get weather data';
        cityName = '';
        return;
      } else {
        double temp = weatherData['main']['temp'];
        tempratureOfCity = temp.toInt();
        var condition = weatherData['weather'][0]['id'];
        weatherIcons = weather.getWeatherIcon(condition);
        weatherMessage = weather.getMessage(tempratureOfCity!);
        // weatherMessage = weather.getMessage();
        cityName = weatherData['name'];
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // fetchWeatherData();
    updateUi(widget.locationWeather);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xffFD7E77), Colors.white], // Gradient colors
        ),
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: Text(
                '${weatherMessage} ,you are in ${cityName}',
                style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    color: Colors.white),
              ),
            ),
            Center(
              child: Text(
                '${weatherIcons}',
                style: TextStyle(
                    color: Color(0xffFD7E77),
                    fontWeight: FontWeight.bold,
                    fontSize: 90),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
              child: Text(
                'Temperature in ${cityName}  is ${tempratureOfCity}',
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 30),
              ),
            ),
            Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                child: Text(
                  'Here is Temp of City ${tempratureOfCity}',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffFD7E77)),
                )),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
              child: Text(
                'All the Results are for  ${cityName}',
                style: TextStyle(
                    color: Color(0xffFD7E77),
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
            ),

            Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () async {
                          var typeName = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AskCity()));

                          if (typeName != null) {
                            print(typeName);
                            var weatherData =
                                await weather.getCityWeather(typeName);
                            updateUi(weatherData);
                          }
                        },
                        icon: Icon(Icons.account_balance)),
                    Text('Other City if yes Click on Icon')
                  ],
                ))

            // Text('Here is Temp of City ${tempratureOfCity}'),
            // Text('you are in ${cityName}'),
            // // Text('Condition of the city is ${conditionId}'),
            // Text(weatherIcons!),
            // Text('${weatherMessage} in ${cityName}'),
          ]),
    ));
  }
}
