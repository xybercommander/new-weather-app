import 'package:flutter/material.dart';
import 'package:new_weather_app/helper/helperfunctions.dart';
import 'package:new_weather_app/services/weatherapi.dart';
import 'package:new_weather_app/views/search.dart';
import 'package:new_weather_app/widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:convert';
import 'package:flutter_swiper/flutter_swiper.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  List<Weather> cityList = [];
  String listOfCities;
  SwiperController swiperController = new SwiperController();

  Map bgImg = {
    "Thunderstorm with light rain" : "thunder.jpg",
    "Thunderstorm with rain" : "thunder.jpg",
    "Thunderstorm with heavy rain" : "thunder.jpg",
    "Thunderstorm with light drizzle" : "rain.jpg",
    "Thunderstorm with drizzle" : "rain.jpg",
    "Thunderstorm with heavy drizzle" : "rain.jpg",
    "Thunderstorm with Hail" : "rain.jpg",
    "Light Drizzle" : "rain.jpg",
    "Drizzle" : "rain.jpg",
    "Heavy Drizzle" : "rain.jpg",
    "Light rain" : "rain.jpg",
    "Moderate Rain" : "rain.jpg",
    "Heavy Rain" : "rain.jpg",
    "Freezing rain" : "rain.jpg",
    "Light showrer rain" : "rain.jpg",
    "Showrer rain" : "rain.jpg",
    "Heavy showrer rain" : "rain.jpg",
    "Light snow" : "snow.jpg",
    "Snow" : "snow.jpg",
    "Heavy snow" : "snow.jpg",
    "Mix snow/rain" : "thunder.jpg",
    "Sleet" : "rain.jpg",
    "Heavy Sleet" : "rain.jpg",
    "Snow shower" : "snow.jpg",
    "Heavy snow shower" : "snow.jpg",
    "Flurries" : "snow.jpg",
    "Mist" : "fog.jpg",
    "Smoke" : "fog.jpg",
    "Haze" : "fog.jpg",
    "Sand/dust" : "thunder.jpg",
    "Fog" : "fog.jpg",
    "Freezing Fog" : "fog.jpg",
    "Clear sky" : "clearsky.jpg",
    "Few clouds" : "clearsky.jpg",
    "Scattered clouds" : "cloud.jpg",
    "Broken clouds" : "cloud.jpg",
    "Overcast clouds" : "cloud.jpg",
    "Unknown Precipitation" : "rain.jpg"
  };

  void removeCard(int index, List cityList) {
    setState(() {
      cityList.remove(cityList[index]);
    });
    List<Weather> tempCityList = [];
    for(int i = 0; i < cityList.length; i++) {
      if(cityList[i] != null) {
        tempCityList.add(cityList[i]);
      }
    }

    setState(() {
      cityList = tempCityList;
    });
    
  }

  void getCityList() async {
    List<Weather> tempCityList = await Weather().decodeCityList();
    setState(() {
      cityList = tempCityList;      
    }); 
  }


  removeNullFromList() {
    if(cityList.length > 0) {
      setState(() {
        for(int i = 0; i < cityList.length; i++) {
          if(cityList[i] == null) {
            cityList.remove(cityList[i]);
          }
        }
      });
    }
  }

  @override
  void initState() {
    // getCityList();
    // removeNullFromList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/bgWallpaper.png"), 
              fit: BoxFit.fill
            )
          ),

          child: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: <Widget>[
                  /*1*/
                  GestureDetector(
                    onTap: () {
                      print(cityList.length);
                      for(int i = 0; i < cityList.length; i++) {
                        print(cityList[i]);
                      }
                    },
                    child: Text(
                      "Xyber Weather",
                      style: TextStyle(fontFamily: "Quicksand", fontSize: 20, fontWeight: FontWeight.w800),
                    ),
                  ),
                  SizedBox(height: 65,),
                  cityList.length == 0 ? SizedBox(height: 100,) : Container(
                    height: MediaQuery.of(context).size.height - 270,
                    width: MediaQuery.of(context).size.width,                    
                    child: Swiper(
                      onTap: (index) {
                        print(index);
                      },
                      scrollDirection: Axis.horizontal,
                      controller: swiperController,
                      itemCount: cityList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 100,
                          width: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(35),
                            child: Container(                        
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/${bgImg["${cityList[index].weatherType}"]}"),
                                  fit: BoxFit.fill
                                ),
                              ),
                              
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [Colors.black.withOpacity(0.5), Colors.black.withOpacity(0.5)])
                                ),
                                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        SizedBox(width: 5,),
                                        Container(
                                          height: 50,
                                          width: 50,
                                          child: IconButton(
                                            icon: Icon(Icons.remove_circle),
                                            onPressed: (){
                                              removeCard(index, cityList);
                                            },
                                            color: Colors.red[500],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text("${cityList[index].cityName}, ${cityList[index].countryCode}",
                                      style: cardTextStyle(Colors.white, 30),
                                    ),
                                    SizedBox(height: 50,),
                                    Text("${cityList[index].temp}°C",
                                      style: cardTextStyle(Colors.white, 30),
                                    ),
                                    Text("--------------------------", style: cardTextStyle(Colors.white, 15),),
                                    Text(cityList[index].weatherType,
                                      style: cardTextStyle(Colors.white, 20),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        );
                      },
                      scale: 0.7,
                      viewportFraction: 0.7,
                      loop: false,
                    ),
                  ),
                  SizedBox(height: 70,)
                ],
              ),
            ),
          ),

        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: Text("Add City"),
        onPressed: () {
          addWeatherToList();
        },
      ),
    );
  }

  void addWeatherToList() async {
    final Weather weather = await Navigator.push(context, PageTransition(child: Search(), type: PageTransitionType.fade));
    cityList.add(weather);
    // listOfCities = weather.encodeCityList(cityList);
    // HelperFunctions().saveCityList(listOfCities);
  }
}
