import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateOrganization extends StatefulWidget {
  @override
  _CreateOrganizationState createState() => _CreateOrganizationState();
}

class _CreateOrganizationState extends State<CreateOrganization> {
  var proofName = 'Upload your File';
  final _controller = TextEditingController();
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
                                  print(picked.files.length);
                                  if (picked != null) {
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
