import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:virtual_startup/Auth/SignIn.dart';
import 'dart:convert';

import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtual_startup/main.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formkey = GlobalKey<FormState>();

  bool loading = false;

  bool _togglePassword = false;

  bool _togglePassword2 = false;

  String username = '';

  String email = '';

  String password = '';

  String confirmPassword = '';

  int phNo = 0;

  String error = 'Password should atleast be 6 characters long';

  SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initializePrefs();
  }

  initializePrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    void _visibility() {
      setState(() {
        _togglePassword = !_togglePassword;
      });
    }

    void _visibility2() {
      setState(() {
        _togglePassword2 = !_togglePassword2;
      });
    }

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(35),
              child: Text(
                'Welcome..!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Form(
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 50,
                  right: 50,
                ),
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: (val) => username = val,
                      validator: (val) =>
                          val.isEmpty ? "Username cannot be empty" : null,
                      cursorColor: Colors.white,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromRGBO(36, 46, 56, 100),
                        hintText: 'Username',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(255, 255, 255, 100),
                        ),
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      validator: (val) => val.length < 6
                          ? error
                          : val == confirmPassword
                              ? null
                              : "Password mismatch",
                      onChanged: (val) => password = val,
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: !_togglePassword,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromRGBO(36, 46, 56, 100),
                        hintText: 'Password',
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
                        border: InputBorder.none,
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      validator: (val) => val.length < 6
                          ? error
                          : val == password
                              ? null
                              : "Password mismatch",
                      onChanged: (val) => confirmPassword = val,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: !_togglePassword2,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromRGBO(36, 46, 56, 100),
                        hintText: 'Confirm Password',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(255, 255, 255, 100),
                        ),
                        prefixIcon: Icon(
                          Icons.vpn_key,
                          color: Colors.white,
                        ),
                        suffixIcon: IconButton(
                          icon: _togglePassword2 == true
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off),
                          iconSize: 25,
                          color: Colors.white,
                          padding: EdgeInsets.only(right: 15),
                          onPressed: _visibility2,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      validator: (val) =>
                          val.isEmpty ? "E-Mail field cannot be empty" : null,
                      onChanged: (val) => email = val,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromRGBO(36, 46, 56, 100),
                        hintText: 'E-Mail',
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
                      validator: (val) =>
                          val.length != 10 ? "Invalid mobile number" : null,
                      onChanged: (val) => phNo = int.parse(val),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      cursorColor: Colors.white,
                      maxLines: 1,
                      keyboardType: TextInputType.numberWithOptions(),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromRGBO(36, 46, 56, 100),
                        hintText: 'Phone Number',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(255, 255, 255, 100),
                        ),
                        prefixIcon: Icon(
                          Icons.phone,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    FlatButton(
                      onPressed: () async {
                        if (_formkey.currentState.validate()) {
                          final url = '127.0.0.1:5000';
                          final response = await http.post(
                            Uri.http(url, '/signUpCall'),
                            body: jsonEncode(
                              <String, String>{
                                'username': username,
                                'email': email,
                                'password': password,
                                'phNo': phNo.toString(),
                              },
                            ),
                          );
                          if (response != null) {
                            var res =
                                await http.get(Uri.http(url, '/signUpCall'));
                            final decodedVal =
                                json.decode(res.body) as Map<String, dynamic>;
                            if (decodedVal['permitted'] == 1) {
                              prefs.setString('user', username);
                              // Navigator.pushReplacement(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => Home(
                              //       response: decodedVal['response'],
                              //     ),
                              //   ),
                              // );
                              prefs.setString('user', username);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyApp()));
                            } else {
                              Alert(
                                context: context,
                                type: AlertType.error,
                                title: "ALERT",
                                desc: "Account already registered..!",
                                buttons: [
                                  DialogButton(
                                    child: Text(
                                      "COOL",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                    width: 120,
                                  )
                                ],
                              ).show();
                            }
                          }
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Color(0xffFB762F),
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        child: Text(
                          'Proceed',
                          style: TextStyle(fontSize: 25),
                        ),
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
                                'Already have an account ?',
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
                                        builder: (context) => SignIn()),
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
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
