import 'dart:convert';

import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:new_weather_app/helper/helperfunctions.dart';

class Weather {
  String apiKey = "9cc4d396352649cab1e283fea41427fd";
  String cityName;
  String countryCode;
  String weatherType;
  int temp;

  Weather({this.cityName});


  // This function is for getting the weather
  Future<void> getWeather() async {
    try {
      // The below 4 lines are for calling the map in the json file
      Response response = await get("https://api.weatherbit.io/v2.0/current?city=$cityName&key=$apiKey");
      Map data = jsonDecode(response.body);
      List allData = data["data"];
      Map requiredData = allData[0];


      temp = requiredData["temp"];
      countryCode = requiredData["country_code"];
      cityName = requiredData["city_name"];
      weatherType = requiredData["weather"]["description"];
      
      
    } catch(e) {
      print(e.toString());
    }
  }

  factory Weather.fromJson(Map<String, dynamic> jsonData) {
    return Weather(
      cityName: jsonData['cityName'],
    );
  }

  static Map<String, dynamic> toMap(Weather weather) => {
    'cityname' : weather.cityName,
  };

  // Function for encoding the list of weathers //
  String encodeCityList(List<Weather> weathers) => json.encode(
    weathers.map<Map<String, dynamic>>((weather) => Weather.toMap(weather)).toList()
  );

  // Function for decoding the list of weathers //
  Future<List<Weather>> decodeCityList() async {
    String weathers = await HelperFunctions().getCityList();
    return (json.decode(weathers) as List<dynamic>)
      .map<Weather>((item) => Weather.fromJson(item)).toList();
  }

}