import 'geo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
void main() {
  runApp(alldata());
}

class alldata extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Test(),
    );
  }
}

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    // Check if weatherData is available


      if (weatherData != null) {
        double latitude = weatherData!.latitude;
        double lati = double.parse((latitude).toStringAsFixed(4));
        double longitude = weatherData!.longitude;
        double long = double.parse((longitude).toStringAsFixed(4));
        var weatherInfo = weatherData!.weatherInfo;
        double temprature = weatherInfo["main"]["temp"];
        double temp = temprature - 273.15;
        var temper = (temp.toInt());
        String location = weatherInfo["name"];
        var mintemp = weatherInfo["main"]["temp_min"];
        double mintempre = mintemp - 273.15;
        var mint = (mintempre.toInt());
        var maxtemp = weatherInfo["main"]["temp_max"];
        double maxtempre = maxtemp - 273.15;
        var maxt = (maxtempre.toInt());

        var vis = weatherInfo["visibility"];
        var pre = weatherInfo["main"]["pressure"];
        var hum = weatherInfo["main"]["humidity"];
        String desc = weatherInfo["weather"][0]["description"];
        String description = desc.toUpperCase();
        var visibi = vis / 1000;

        var rise = weatherInfo["sys"]["sunrise"];
        var set = weatherInfo["sys"]["sunset"];
        String coun = weatherInfo["sys"]["country"];
        int timestampInMillis = rise; // Example timestamp
        DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
            timestampInMillis);
        String sunrise = DateFormat('hh:mm').format(dateTime);
        int hello = set; // Example timestamp
        DateTime hi = DateTime.fromMillisecondsSinceEpoch(hello);
        String sunset = DateFormat('hh:mm').format(hi);

        var speed = weatherInfo["wind"]["speed"];
        var deg = weatherInfo["wind"]["deg"];


        return Scaffold(

          body: SingleChildScrollView(
            child: Container(
              height: 930,
              width: double.infinity,
             color: Colors.white,
             child:
             Container(

             child:Column(
               children: [
                 Stack(
               children: [
                 SizedBox(height: 0,),
                  Image.asset('assets/background.png',
                    height: 550,
                     width: 450,
                     fit: BoxFit.cover,),
                  Padding(padding: EdgeInsets.fromLTRB(30, 110, 20, 0),
                 child:Container(
                   height: 90,
                   width: double.infinity,
                   child:Center(
                     child: Padding(padding: EdgeInsets.fromLTRB(40, 20, 10, 0),
                     child:Text(
                       '$description',
                       style: TextStyle(
                         fontSize: 29,
                         color: Colors.white,
                         fontWeight: FontWeight.bold,
                       ),
                     ),
                     ),
                   ),
                 ),
                  ),

                 Center(
                   child: Padding(padding: EdgeInsets.fromLTRB(50, 180, 20, 0),
                     child:Container(
                       height: 90,
                       width: double.infinity,
                       child: Center(
                         child: Text(
                           '$temper°C',
                           style: TextStyle(
                             fontSize: 70, // Adjust the font size as needed
                             color: Colors.white, // Text color
                             fontWeight: FontWeight.bold, // Text font weight
                           ),
                         ),
                       ),
                     ),

                   ),
                 ),

                 Center(
                 child:  Padding(padding: EdgeInsets.fromLTRB(50, 275, 20, 0),
                   child: Container(
                     child: Text(
                       ' Visibility     -      $visibi KM',
                       style: TextStyle(
                         fontSize: 23, // Adjust the font size as needed
                         color: Colors.white, // Text color
                         // Text font weight
                       ),
                     ),
                   ),
                 ),
                   // Adjust the left position as needed

                 ),

               Center(
                 child:  Padding(padding: EdgeInsets.fromLTRB(50, 305, 20, 0),
                   child: Container(

                   child: Text(
                     ' Wind Degree     -      $deg °',
                     style: TextStyle(
                       fontSize: 23, // Adjust the font size as needed
                       color: Colors.white, // Text color
                       // Text font weight
                     ),
                   ),
                 ),
                 ),
               ),

               ],
             ),
                Text('$location', style: TextStyle(fontSize: 25,
                     fontWeight: FontWeight.bold,
                     color: Colors.redAccent,),),
                 SizedBox(height: 10,),
                 Text('$coun', style: TextStyle(fontSize: 25,

                     color: Colors.black,),),
                 SizedBox(height: 10,),
                 Container(
                   height: 2,
                   width: 200,
                   color: Colors.red,
                 ),
               SizedBox(height: 20,),
               Padding(padding: EdgeInsets.fromLTRB(30, 3, 3, 4),
                   child: SingleChildScrollView(
              child:   Container(

                   child: Column(
                     children: [
                    SizedBox(height: 5,),
                       Row(
                         children: [

                           Container(
                             child: Text("Huminity",style: TextStyle(fontSize: 20),),
                           ),
                           Padding(padding: EdgeInsets.fromLTRB(65, 0,65, 0),
                             child:  Image.asset('assets/hum.png', height: 30,
                               width: 30,
                               fit: BoxFit.cover,),
                           ),
                           Container(
                               child: Text("   $hum %", style: TextStyle(fontSize: 18),),
                             ),

                         ],
                         mainAxisAlignment: MainAxisAlignment.center,
                       ),
                       SizedBox(height: 5,),
                       Row(
                         children: [
                           Container(
                             child: Text("Pressure",style: TextStyle(fontSize: 20),),
                           ),
                           Padding(padding: EdgeInsets.fromLTRB(45, 0, 45, 0),
                             child:  Image.asset('assets/cloulds.png', height: 30,
                               width: 30,
                               fit: BoxFit.cover,),
                           ),
                           Container(
                               child: Text("   $pre atm", style: TextStyle(fontSize: 18),),
                             ),


                         ],
                         mainAxisAlignment: MainAxisAlignment.center,
                       ),
                       SizedBox(height: 5,),
                       Row(
                         children: [
                           Container(
                             child: Text("Wind Speed",style: TextStyle(fontSize: 20),),
                           ),
                           Padding(padding: EdgeInsets.fromLTRB(35, 0, 35, 0),
                             child:  Image.asset('assets/wind.png', height: 30,
                               width: 30,
                               fit: BoxFit.cover,),
                           ),
                            Container(
                               child: Text("   $speed m/s", style: TextStyle(fontSize: 18),),
                             ),

                         ],
                         mainAxisAlignment: MainAxisAlignment.center,
                       ),
                       SizedBox(height: 30,),
                       Row(
                         children: [
                           Padding(padding: EdgeInsets.fromLTRB(0, 0, 90, 0),
                           child: Image.asset('assets/sunrise.png', height: 30,
                               width: 30,
                               fit: BoxFit.cover,),
                           ),
                           Padding(padding: EdgeInsets.fromLTRB(90, 0, 0, 0),
                             child: Image.asset('assets/sunset.png', height: 30,
                               width: 30,
                               fit: BoxFit.cover,),
                           ),
                         ],
                         mainAxisAlignment: MainAxisAlignment.center,
                       ),

                       Row(
                         children: [
                           Padding(padding: EdgeInsets.fromLTRB(0, 0, 75, 0),
                           child:Container(
                             child: Text("Sunrise",style: TextStyle(fontSize: 19,color: Colors.deepOrange),),
                           )
                           ),
                           Padding(padding: EdgeInsets.fromLTRB(75, 0, 0, 0),
                               child:Container(
                                 child: Text("Sunset",style: TextStyle(fontSize: 19,color: Colors.deepOrange),),
                               )
                           ),
                         ],
                         mainAxisAlignment: MainAxisAlignment.center,
                       ),
                      Row(
                           children: [
                             Padding(padding: EdgeInsets.fromLTRB(0, 0, 45, 0),
                                child: Container(
                                   child: Text("06:20 am",style: TextStyle(fontSize: 25,fontWeight:FontWeight.bold),),
                                 ),
                             ),

                             Padding(padding: EdgeInsets.fromLTRB(45, 0, 0, 0),
                               child: Container(
                                   child: Text("06:48 pm",style: TextStyle(fontSize: 25,fontWeight:FontWeight.bold),),
                                 ),
                             ),

                           ],
                           mainAxisAlignment: MainAxisAlignment.center,
                         ),




                     ],
                   ),
               ),
                 ),
                 ),


    ],
          ),


            ),
            ),




          ),
        );
      } else {
        // Handle the case where weatherData is null
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back,color: Colors.white,),
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => getLocation()));
                },),
            title: Text('Weather Data'),
            backgroundColor: Colors.orange,

            ),

          body: Center(
            child: Text('Weather data is not available.'),
          ),
        );
      }

  }
}


class WeatherData {
  final double latitude;
  final double longitude;
  final Map<String, dynamic> weatherInfo;

  WeatherData(
      {required this.latitude, required this.longitude, required this.weatherInfo});
}