import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:new_weather_app/services/weatherapi.dart';
import 'package:new_weather_app/views/mainPage.dart';
import 'package:new_weather_app/widgets.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  TextEditingController mycontroller = new TextEditingController();
  Weather obj = new Weather();
  bool isLoading = false;

  searchButtonFunction(String cityName) async {  
    setState(() {
      isLoading = true;
    });
    Weather weather = Weather(cityName: cityName);
    await weather.getWeather();
    obj = weather;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading == true ?
      Container(child: Center(child: CircularProgressIndicator())) :
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bgWallpaper.png"),
            fit: BoxFit.fill
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(0.3),
                Colors.black.withOpacity(0.3)
              ]
            )
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5,sigmaY: 5),


            child: SafeArea(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      child: backButton(context),
                    ),
                    SizedBox(height: 50,),
                    Container(
                      height: 90,
                      width: MediaQuery.of(context).size.width - 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        color: Colors.black.withOpacity(0.3)
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        alignment: Alignment.center,
                        child: textFieldForSearch(mycontroller)
                      ),
                    ),
                    SizedBox(height: 50,),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.30),
                            Colors.black.withOpacity(0.30),
                          ]
                        ),
                        borderRadius: BorderRadius.circular(35)
                      ),
                      height: 60,
                      width: 60,
                      child: RawMaterialButton(
                        shape: CircleBorder(),
                        onPressed: () async {
                          await searchButtonFunction(mycontroller.text);
                          Navigator.pop(context, obj);
                        },                                            
                        child: Icon(Icons.search, color: Colors.white60),                                  
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ),
    );
  }
}
