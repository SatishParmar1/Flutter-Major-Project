import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'data.dart';

WeatherData? weatherData;
class getLocation extends StatefulWidget {
  const getLocation({super.key});

  @override
  State<getLocation> createState() => _getLocationState();
}
@override
class _getLocationState extends State<getLocation> {

  double lat = 0.0;
  double lon = 0.0;
  bool isLoading = false;

  TextEditingController city = TextEditingController();
  TextEditingController contry = TextEditingController();
  String? _city;
  String? _contry;

  void getloc() async {
    setState(() {
      isLoading = true; // Show loading indicator
      LoadingIndicatorDialog().show(context);
    });


      _city = city.text;
      _contry = contry.text;

      final locResponse = await http.get(Uri.parse(
          'https://api.openweathermap.org/geo/1.0/direct?q=$_city,$_contry,IN&limit=1&appid=9d108e56ea8b0656212f4fc172619eac'));

      if (locResponse.statusCode == 200) {
        var locData = jsonDecode(locResponse.body);
        print(locData);

        double lat = locData[0]['lat'];
        double lon = locData[0]['lon'];

        final weatherResponse = await http.get(Uri.parse(
            'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=9d108e56ea8b0656212f4fc172619eac'));

        if (weatherResponse.statusCode == 200) {
          var weatherInfo = jsonDecode(weatherResponse.body);
          print(weatherInfo);

          WeatherData newWeatherData = WeatherData(
            latitude: lat,
            longitude: lon,
            weatherInfo: weatherInfo,
          );

          setState(() {
            weatherData = newWeatherData;
            isLoading = false;
          });
        } else {
          print('Failed to fetch weather data: ${weatherResponse.statusCode}');
          setState(() {
            isLoading = false;
          });
        }
      } else {
        print('Failed to fetch location data: ${locResponse.statusCode}');
        setState(() {
          isLoading = false;
        });
      }

    LoadingIndicatorDialog().dismiss();
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => alldata()));

  }


    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Weather Data")),
          backgroundColor: Colors.orange,
          leading: null,
          automaticallyImplyLeading: false,
        ),
        body:
        SingleChildScrollView(
            child:

            Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child:

              DecoratedBox(
                  decoration: BoxDecoration(
              color: Colors.white
                  ),

                  child: Center(
                    child: Container(
                      height: 780,
                      width: 500,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                        child: Column(

                          children: [
                            SizedBox(height: 50,),
                            Image.asset('assets/orange.gif', height: 250,
                              width: 300,
                              fit: BoxFit.cover,),
                            Padding(padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                             child: TextField(
                              controller: city,
                              cursorColor: Colors.orange,
                              style: TextStyle(fontSize: 20, letterSpacing: 1),

                              decoration: InputDecoration(
                                  hintText: ("City Name"),
                                  suffixIcon: Icon(Icons.location_city_rounded, color: Colors.orange,),

                                  hintStyle: TextStyle(
                                      fontSize: 23,
                                      overflow: TextOverflow.fade),
                                  hoverColor: Colors.black,
                                  contentPadding: EdgeInsets.fromLTRB(
                                      10, 13, 10, 0)

                              ),
                            ),
                            ),
                            SizedBox(height: 20,),
                        Padding(padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                           child: TextField(
                              controller: contry,
                              cursorColor: Colors.orange,
                              style: TextStyle(fontSize: 20, letterSpacing: 2),
                              decoration: InputDecoration(
                                  hintText: ("State Name"),
                                  hintStyle: TextStyle(fontSize: 23),
                                  hoverColor: Colors.black,
                                  suffixIcon: Icon(Icons.share_location_sharp, color: Colors.orange,),
                                  contentPadding: EdgeInsets.fromLTRB(
                                      10, 13, 10, 0)

                              ),
                            ),
                        ),
                            SizedBox(height: 40,),
                            Container(
                              height: 50,
                              width: 150,
                              decoration: const BoxDecoration(
                                color:Colors.white,

                                borderRadius: BorderRadius.all(Radius.circular(50)),
                              ),
                              child:  ElevatedButton(style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                              ), onPressed: () {
                                getloc();
                              },
                                  child: Text("Location", style: TextStyle(
                                      height: 1, fontSize:30),
                                    textAlign: TextAlign.right,)),
                            ),


                          ],
                        )
                    ),
                  )
              ),

            )
        ),
      );
    }
  }


class LoadingIndicatorDialog {
  static final LoadingIndicatorDialog _singleton = LoadingIndicatorDialog._internal();
  late BuildContext _context;
  bool isDisplayed = false;

  factory LoadingIndicatorDialog() {
    return _singleton;
  }

  LoadingIndicatorDialog._internal();

  show(BuildContext context, {String text = 'Loading...'}) {
    if(isDisplayed) {
      return;
    }
    showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          _context = context;
          isDisplayed = true;
          return WillPopScope(
            onWillPop: () async => false,
            child: SimpleDialog(
              backgroundColor: Colors.white,
              children: [
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
                        child: CircularProgressIndicator(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(text),
                      )
                    ],
                  ),
                )
              ] ,
            ),
          );
        }
    );
  }

  dismiss() {
    if(isDisplayed) {
      Navigator.of(_context).pop();
      isDisplayed = false;
    }
  }
}


