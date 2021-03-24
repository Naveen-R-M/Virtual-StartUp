import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtual_startup/Employer/createOrganization.dart';
import 'package:virtual_startup/Home/customAppBar.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String apiCalls = '';
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
    final size = MediaQuery.of(context).size;

    return new WillPopScope(
      onWillPop: () async => true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomAppBar(),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Create Your Organization',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 60,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        '  Hire Applicants..',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Colors.grey.shade700,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                width: 500,
                                height: 500,
                                child: Lottie.asset(
                                    'Anime/mobile-technology.json'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      user != null
                          ? SafeArea(
                              child: Expanded(
                                child: Container(
                                  margin: EdgeInsets.all(20),
                                  padding: EdgeInsets.all(20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            decoration: BoxDecoration(
                                                gradient:
                                                    LinearGradient(colors: [
                                                  Colors.purple,
                                                  Colors.deepOrangeAccent,
                                                ]),
                                                color: Colors.deepOrangeAccent
                                                    .withOpacity(0.70),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            padding: EdgeInsets.all(60),
                                            margin: EdgeInsets.all(40),
                                            child: Center(
                                              child: Text(
                                                'Join an Organization',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 25),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () => Navigator.of(context)
                                              .push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      CreateOrganization())),
                                          child: Container(
                                            margin: EdgeInsets.all(40),
                                            decoration: BoxDecoration(
                                                gradient:
                                                    LinearGradient(colors: [
                                                  Colors.deepOrangeAccent,
                                                  Colors.purple,
                                                ]),
                                                color: Colors.orange
                                                    .withOpacity(0.70),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            padding: EdgeInsets.all(60),
                                            child: Center(
                                              child: Text(
                                                'Create an Organization',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 25),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
