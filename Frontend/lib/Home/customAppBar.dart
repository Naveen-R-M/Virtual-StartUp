import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtual_startup/Auth/SignIn.dart';
import 'package:virtual_startup/Auth/SignUp.dart';
import 'package:http/http.dart' as http;
import 'package:virtual_startup/main.dart';

class CustomAppBar extends StatefulWidget {
  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  SharedPreferences prefs;
  var user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializePrefs();
  }

  initializePrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      user = prefs.get('user');
    });
    print('user : ${user}');
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => true,
      child: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(35),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 0),
                  blurRadius: 2,
                  color: Colors.purple.withOpacity(0.2))
            ]),
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    SizedBox(
                      width: 25,
                    ),
                    Image(
                      width: 115,
                      height: 25,
                      image: AssetImage('VirtualStartUp.png'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Text(
                        'Home',
                        style: TextStyle(
                            fontSize: 17, color: Colors.grey.shade700),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Text(
                        'About Us',
                        style: TextStyle(
                            fontSize: 17, color: Colors.grey.shade700),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Text(
                        'Contact Us',
                        style: TextStyle(
                            fontSize: 17, color: Colors.grey.shade700),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    user == null
                        ? Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xffFB762F),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                              child: RaisedButton(
                                color: Colors.white,
                                onPressed: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SignUp(),
                                    ),
                                  );
                                },
                                child: Expanded(
                                  child: Container(
                                    width: 120,
                                    height: 45,
                                    child: Center(
                                      child: Text('Sign Up'),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Expanded(
                            child: Text(
                              user,
                              style: TextStyle(
                                  fontSize: 17, color: Colors.grey.shade700),
                            ),
                          ),
                    SizedBox(
                      width: 15,
                    ),
                    user == null
                        ? Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xffFB762F),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                              child: RaisedButton(
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignIn()));
                                },
                                child: Container(
                                  width: 120,
                                  height: 45,
                                  child: Center(
                                    child: Text('Sign In'),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xffA663E1).withOpacity(0.90),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                              child: FlatButton(
                                onPressed: () {
                                  prefs.remove('user');
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MyApp()));
                                },
                                child: Container(
                                  width: 120,
                                  height: 45,
                                  child: Center(
                                    child: Text(
                                      'Logout',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
