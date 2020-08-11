import 'package:flutter/material.dart';
import 'package:new_weather_app/services/weatherapi.dart';


// This function is for the beck button in the search page

Widget backButton(context) {
  return GestureDetector(
    onTap: () {
      Navigator.pop(context);
    },
    child: Container(
      height: 40,
      width: 50,
      child: Icon(Icons.arrow_back_ios),
    ),
  );
}


// This function is for the text field in the search field

Widget textFieldForSearch(TextEditingController mycontroller) {
  return TextField(
    decoration: InputDecoration(
      border: InputBorder.none,
      hintText: "Search by City Name",                                      
      hintStyle: TextStyle(
        color: Colors.white70,
        fontFamily: "Quicksand",
        fontWeight: FontWeight.w500,
        fontSize: 22
      )
    ),
    cursorColor: Colors.orange[100],                                  
    style: TextStyle(
      color: Colors.white,
      fontFamily: "Quicksand",
      fontSize: 22
    ),
    controller: mycontroller,
    onSubmitted: (String str) {},
  );
}

// This function os for the text style that will be in each card

TextStyle cardTextStyle(Color color, double size) {
  return TextStyle(
    fontFamily: "Quicksand",
    fontWeight: FontWeight.bold,
    color: color,
    fontSize: size
  );
}
