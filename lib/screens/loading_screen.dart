import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:testing_trail_weather/screens/location_screen.dart';

import '../services/location.dart';
import 'weather.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Location location = Location();
  void getLocationData() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    WeatherModel weatherModel = WeatherModel();

    weatherData = await weatherModel.getLocationWeather();
    log('-----------------' + weatherData['main']['temp'].toString());

    await location.getCurrentLocation(); // Fetching current location
    setState(() {});

    /*Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LocationScreen(
                  LocationWeather: weatherData,
                )));*/
  }

  // @override
  // void initState() {
  //   print('inti State Activated or called ');
  //
  //   super.initState();
  // }

  // @override
  // void deactivate() {
  //   print('Deactivate methode is called ');
  //
  //   super.deactivate();
  // }
  // WeatherModel weather = WeatherModel();
  // WeatherModel weatherModel = WeatherModel();
  dynamic weatherData;
  @override
  void initState() {
    super.initState();
    getLocationData();
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => LocationScreen()));

    // fetchWeatherData();
  }

  // void fetchWeatherData() async {
  //   dynamic data = await weatherModel.getLocationWeather();
  //   setState(() {
  //     weatherData = data;
  //
  //     log('Vakalat5 ${data}');
  //
  //     setState(() {});
  //
  //     log('Vakalat4 ${weatherData}');
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: Center(
        child: Container(
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Hey Buddy,Are you Ready for Weather',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
              TextButton(
                  onPressed: () {
                    log('before navigate :: ${weatherData['main']['temp']}');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LocationScreen(
                                  locationWeather: weatherData,
                                )));
                  },
                  child: Text(
                    'Click me for Weather',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 50),
                child: Text(
                    'Your Actual Location is ,, Lattitude ${location.lat},Longitude ${location.long}'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
