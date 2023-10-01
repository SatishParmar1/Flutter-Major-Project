import 'package:flutter/material.dart';

import 'package:hello_satish/geo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:hello_satish/signup.dart';


class Second extends StatefulWidget {
  @override
  State<Second> createState() => _SecondState();
}

class _SecondState extends State<Second> {
  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  void login() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>getLocation()),
      );
  }
  void signuptop() {
  }

  @override

  void initState() {
    super.initState();
    Firebase.initializeApp();

  }
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();




  @override
  Widget build(BuildContext context) {
       return Scaffold(

      body:
       SingleChildScrollView(


        child: Column(
          children: [
            Padding(padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
              child: Container(
                height: 70,
                width: 300,

                child: const Text("Welcome,", style: TextStyle(fontSize: 70,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,),),
              ),
            ),
            Padding(padding:const  EdgeInsets.fromLTRB(10, 10, 0, 0),
              child: Container(
                height: 50,
                width: 300,

                child: const Text("Back", style: TextStyle(fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,),),
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding:const EdgeInsets.fromLTRB(15, 15,15,0),
              child: Center(
                child: Container(
                  height: 370, // Reduced height
                  width: 400,
                  margin:const EdgeInsets.fromLTRB(0, 40, 0, 0),
                  decoration: const BoxDecoration(

                    color: Colors.orange,

                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    children: [

                      SizedBox(height: 20),
                      Padding(padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child:  TextField(
                          controller: _email,
                          cursorColor: Colors.white,
                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                              hintText: ("Enter your Email") ,
                              hintStyle: TextStyle(fontSize:20),
                              hoverColor: Colors.black,
                              suffixIcon: Icon(Icons.person),
                              suffixIconColor: Colors.black,
                              contentPadding: EdgeInsets.fromLTRB(10, 13, 10, 0)
                          ),
                        ),
                      ),

                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child:  TextField(
                          controller: _password,
                          cursorColor: Colors.white,

                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                              hintText: ("Enter your Password") ,
                              hintStyle: TextStyle(fontSize:20),
                              hoverColor: Colors.black,
                              suffixIcon: Icon(Icons.lock_open),
                              suffixIconColor: Colors.black,
                              contentPadding: EdgeInsets.fromLTRB(10, 13, 10, 0)

                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                  Row(
                                  children: [
                                    Container(
                                        height: 50,
                                        width: 120,
                                        decoration: const BoxDecoration(
                                          color:Colors.white,
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                        ),
                                        child:   ElevatedButton(style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white
                                        ),onPressed: (){Navigator.push(context,MaterialPageRoute(builder: (context) => signup()));
                                        }, child:
                                        const  Text("Signup",style: TextStyle(fontSize: 27,color: Colors.black),),
                                        ),

                                      ),


Padding(padding: EdgeInsets.only(left: 30)),
                                    Container(
                                      height: 50,
                                      width: 120,

                                      decoration: BoxDecoration(
                                        color:Colors.white,

                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                      ),
                                      child:   ElevatedButton(style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white
                                      ),onPressed: (){
                                        FirebaseAuth.instance.signInWithEmailAndPassword(
                                            email: _email.text, password: _password.text).
                                        then((value){
                                          Navigator.push(context,MaterialPageRoute(builder: (context) => getLocation()));
                                        }).onError((error, stackTrace){print(error);
                                        });
                                      },
                                        child: const Text("Log in",style: TextStyle(fontSize: 27,color: Colors.black),),
                                      ),

                                    ),




                                  ],
                                   mainAxisAlignment: MainAxisAlignment.center,
                                ),




                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Text(" -- Login with --", style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),),
                      ),

                      Row(
                        children: [
                          Image.asset(
                              'assets/google.png', height: 100, width: 50,),

                          Padding(
                            padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                            child: Image.asset(
                              'assets/facebook.png', height: 100, width: 50,),
                          ),
                          Image.asset(
                              'assets/micro.png', height: 100, width: 50,),

                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      )

                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}
