import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_package1/package2/CustomFormField.dart';
import 'package:ows_bigcareer/model/apis/urls.dart';

class WriteToUs extends StatefulWidget {
  const WriteToUs({Key? key, required this.currentUserMobile})
      : super(key: key);
  final currentUserMobile;

  @override
  State<WriteToUs> createState() => _WriteToUsState();
}

class _WriteToUsState extends State<WriteToUs> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  final TextEditingController _controllerTitle = TextEditingController();
  final TextEditingController _controllerDetails = TextEditingController();
  bool flagButton = false;
  double heightField = 45;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Write To Us'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formState,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  child: Column(
                    children: [
                      const SizedBox(height: 10,),
                      Container(
                        height: MediaQuery.of(context).size.height*.2,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/img_10.png'),
                                fit: BoxFit.fitHeight)),
                      ),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 18.0, bottom: 10),
                          child: Text(
                            'Enter Title',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15, bottom: 0, top: 0),
                        child: SizedBox(
                          height: heightField,
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            maxLines: 1,
                            readOnly: false,
                            controller: _controllerTitle,
                            validator: (v) {
                              if (_controllerTitle.text.isEmpty) {
                                return "Enter Title";
                              }
                            },
                            keyboardType: TextInputType.text,
                            onChanged: (v) {},
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.teal)),
                                labelText: '',
                                labelStyle: TextStyle(fontSize: 12),
                                prefixText: ' ',
                                suffixStyle: TextStyle(color: Colors.green)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 18.0, bottom: 10),
                          child: Text(
                            'Enter Details',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15, bottom: 0, top: 0),
                        child: SizedBox(
                          height: 105,
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            maxLines: 6,
                            readOnly: false,
                            controller: _controllerDetails,
                            validator: (v) {
                              if (_controllerDetails.text.isEmpty) {
                                return "Enter Details";
                              }
                            },
                            keyboardType: TextInputType.text,
                            onChanged: (v) {},
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.teal)),
                                labelText: '',
                                labelStyle: TextStyle(fontSize: 12),
                                prefixText: ' ',
                                suffixStyle: TextStyle(color: Colors.green)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                      SizedBox(
                        height: 40,
                        width: 300,
                        child: ElevatedButton(
                            onPressed: () {
                              _applyForJob(context);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.indigo),
                            child: flagButton
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                : const Text(
                                    'Submit',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  )),
                      ),
                      const SizedBox(
                        height: 80,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Future<dynamic> addComplaint(dynamic model) async {
    var APIURL = '${API_BASE_URL}feedback_api.php';
    http.Response response = await http
        .post(Uri.parse(APIURL), body: model)
        .then((value) => value)
        .catchError((error) => print("addComplaint Failed: $error"));
    var data = jsonDecode(response.body);
    return data;
  }

  _applyForJob(BuildContext context) async {
    setState(() {
      heightField = 65;
    });
    if (_formState.currentState!.validate()) {
      setState(() {
        flagButton = true;
      });
      var data = await addComplaint({
        "user_id": widget.currentUserMobile,
        "title": _controllerTitle.text,
        "description": _controllerDetails.text
      });
      if (data[0]['response'] == "1") {
        snackBar(
            context: context,
            data: 'complaint registered',
            color: Colors.green);
        setState(() {
          flagButton = false;
        });
        Navigator.pop(context);
      } else {
        snackBar(
            context: context,
            data: 'sorry complaint not registered',
            color: Colors.red);
        setState(() {
          flagButton = false;
        });
      }
    }
  }

  snackBar(
      {required BuildContext context,
      required String data,
      required Color color}) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
          content: Padding(
              padding: const EdgeInsets.only(left: 10.0), child: Text(data)),
          backgroundColor: color,
          behavior: SnackBarBehavior.fixed));
  }
}
