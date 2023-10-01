
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hello_satish/Newpage.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Home(),
         );
}

class Home extends StatelessWidget {
   Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Leve(),
    );
  }

}
