import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class CreateOrganization extends StatefulWidget {
  @override
  _CreateOrganizationState createState() => _CreateOrganizationState();
}

class _CreateOrganizationState extends State<CreateOrganization> {
  var proofName = 'Upload your File';
  final _controller = TextEditingController();
  var organizationName;
  var ideaSynopsis;

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
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.all(15),
          padding: EdgeInsets.all(15),
          child: Center(
            child: Column(
              children: [
                Text(
                  'Create your Organization',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Form(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 50,
                      right: 50,
                    ),
                    child: Column(
                      children: [
                        TextFormField(
                          onChanged: (val) => organizationName = val,
                          cursorColor: Colors.white,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromRGBO(36, 46, 56, 100),
                            hintText: 'Organization Name',
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(255, 255, 255, 100),
                            ),
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.build,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          onChanged: (val) => ideaSynopsis = val,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          cursorColor: Colors.white,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromRGBO(36, 46, 56, 100),
                            hintText: 'Idea Synopsis',
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(255, 255, 255, 100),
                            ),
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.build,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _controller,
                          readOnly: true,
                          focusNode: FocusNode(),
                          enableInteractiveSelection: false,
                          cursorColor: Colors.white,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Color.fromRGBO(36, 46, 56, 100),
                              hintText: 'Upload your Proof',
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(255, 255, 255, 100),
                              ),
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.picture_as_pdf,
                                color: Colors.white,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () async {
                                  var picked =
                                      await FilePicker.platform.pickFiles();
                                  print(picked);
                                  if (picked != null) {
                                    var base64File =
                                        base64Encode(picked.files.first.bytes);
                                    print(picked.files.first.bytes);
                                    print('base64 Encode:' + base64File);
                                    final url = '127.0.0.1:5000';
                                    // var request = await http.MultipartRequest(
                                    //     'POST', Uri.parse(url));
                                    // request.files.add(
                                    //   await http.MultipartFile.fromPath(
                                    //     'filePath',picked.paths.first
                                    //   )
                                    // );
                                    var result = await http.post(
                                        Uri.http(
                                            url, '/createOrganizationCall'),
                                        body: jsonEncode(<String, String>{
                                          'user': user,
                                          'organizationName': organizationName,
                                          'ideaSynopsis': ideaSynopsis,
                                          'base64File': base64File,
                                        }));
                                    setState(
                                      () {
                                        _controller.text =
                                            picked.files.first.name;
                                        print(_controller.text);
                                        proofName =
                                            picked.files.first.name.toString();
                                      },
                                    );
                                  }
                                },
                                icon: Icon(
                                  Icons.upload_file,
                                  color: Colors.yellow.withOpacity(0.75),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
