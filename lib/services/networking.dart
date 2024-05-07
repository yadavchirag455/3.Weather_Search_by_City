import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http/http.dart';

class NetworkHelper {
  NetworkHelper(this.url);
  final String url;

  Future getData() async {
    Response responce = await http.get(Uri.parse(url));
    //  'https://api.openweathermap.org/data/2.5/weather?lat=${lattitudee}&lon=${longitudee}&appid=${apiKey}'
    print('+++++++++' + responce.toString());

    if (responce.statusCode == 200) {
      String data = responce.body;
      print(jsonDecode(data).toString());

      return jsonDecode(data);

      print(responce.body);
      var conditionId = jsonDecode(data)['weather'][0]['id'];

      // var longitude = jsonDecode(data)['coord']['lon'];
      //
      // print(
      //     'here  we goo lets seee theeeeeeeeeeeeeeeeeeeeeeee data ${longitude}');
      //

      //
      // print(' Lets see the condition id for the weather ${conditionId}');
      //
      // var cityName = jsonDecode(data)['name'];
      //

      // var tempratureOfCity = jsonDecode(data)['main']['temp'];
      //
      // print(
      //     'soo final we found the temparature oof the city ${tempratureOfCity}');
    } else {
      print(responce.statusCode);
    }
  }
}
