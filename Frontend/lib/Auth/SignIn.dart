import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtual_startup/Auth/SignUp.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:virtual_startup/main.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formkey = GlobalKey<FormState>();

  SharedPreferences prefs;

  bool loading = false;

  bool _togglePassword = false;
  String email = '';
  String password = '';
  String _buttonText = 'Sign In';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializePrefs();
  }

  initializePrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  void _visibility() {
    setState(() {
      _togglePassword = !_togglePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 35, right: 35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Sign in to your account',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (val) =>
                                val.isEmpty ? "Enter a valid Email" : null,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (val) => email = val,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                            maxLines: 1,
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color.fromRGBO(36, 46, 56, 100),
                              hintText: ' E-Mail',
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(255, 255, 255, 100),
                              ),
                              prefixIcon: Icon(
                                Icons.mail,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          TextFormField(
                            validator: (val) => val.length < 6
                                ? "Password should be atleast 6 characters long"
                                : null,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: !_togglePassword,
                            onChanged: (val) => password = val,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color.fromRGBO(36, 46, 56, 100),
                              hintText: ' Password',
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(255, 255, 255, 100),
                              ),
                              prefixIcon: Icon(
                                Icons.vpn_key,
                                color: Colors.white,
                              ),
                              suffixIcon: IconButton(
                                icon: _togglePassword == true
                                    ? Icon(Icons.visibility)
                                    : Icon(Icons.visibility_off),
                                iconSize: 25,
                                color: Colors.white,
                                padding: EdgeInsets.only(right: 15),
                                onPressed: _visibility,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Center(
                      child: Container(
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0xffFB762F),
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        child: FlatButton(
                            onPressed: () async {
                              if (_formkey.currentState.validate()) {
                                final url = '127.0.0.1:5000';
                                final response = await http.post(
                                  Uri.http(url, '/signInCall'),
                                  body: jsonEncode(
                                    <String, String>{
                                      'email': email,
                                      'password': password
                                    },
                                  ),
                                );
                                if (response != null) {
                                  var result = await http
                                      .get(Uri.http(url, '/signInCall'));
                                  var decodeVal = json.decode(result.body)
                                      as Map<String, dynamic>;
                                  if (decodeVal['permitted'] == 1) {
                                    prefs.setString(
                                        'user', decodeVal['username']);
                                  }
                                  print('object :' + decodeVal['permitted'].toString());
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => MyApp()));
                                } else {
                                  Alert(
                                    context: context,
                                    type: AlertType.error,
                                    title: "ALERT",
                                    desc: "Invalid SignIn credentials..!",
                                    buttons: [
                                      DialogButton(
                                        child: Text(
                                          "Back to Login",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                        onPressed: () => Navigator.pop(context),
                                        width: 120,
                                      )
                                    ],
                                  ).show();
                                }
                              }
                            },
                            child: Align(
                              child: Text(
                                _buttonText,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: 10, bottom: 10, right: 20, left: 20),
                      child: Center(
                        child: Divider(
                          thickness: 3.5,
                          color: Color(0xff242E38),
                        ),
                      ),
                    ),
                    Center(
                      child: SafeArea(
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have an account ?',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => SignUp()),
                                  );
                                },
                                child: Text(
                                  ' click here',
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.grey.shade400,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
