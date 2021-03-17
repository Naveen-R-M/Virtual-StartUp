import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtual_startup/main.dart';

class Home extends StatefulWidget {
  var response;
  Home({this.response});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SharedPreferences prefs;

  var user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  initializePrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(35),
            child: Text(
              widget.response,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25),
            ),
          ),
          Container(
            width: 100,
            height: 50,
            decoration: BoxDecoration(
              color: Color(0xffFB762F),
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            child: FlatButton(
              onPressed: () {
                prefs.remove('user');
                Navigator.pushReplacement(
                  context,MaterialPageRoute(builder: (context)=>MyApp())
                );
              },
              child: Text('Logout'),
            ),
          )
        ],
      ),
    );
  }
}
