import 'package:shared_preferences/shared_preferences.dart';
import 'package:new_weather_app/services/weatherapi.dart';

class HelperFunctions {
  static String listKey = "LISTKEY";

  // SAVE FUNCTION
  
  Future<void> saveCityList(String listOfCities) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(listKey, listOfCities);
  }

  // GET FUNCTION
  Future<String> getCityList() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(listKey);
  }
}