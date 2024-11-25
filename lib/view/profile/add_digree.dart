import 'package:flutter/material.dart';
import 'package:flutter_package1/package2/CustomFormField.dart';
import 'package:flutter_package1/package2/date.dart';

class AddEducation extends StatefulWidget {
  const AddEducation(
      {Key? key, required this.title, required this.controller1, required this.controller2,
      required this.controller3, required this.controller4
      })
      : super(key: key);
  final title, controller1, controller2, controller3, controller4;

  @override
  State<AddEducation> createState() => _AddEducationState();
}

class _AddEducationState extends State<AddEducation> {
  String? digree = 'HighSchool';
  var digreeList = [
    'HighSchool',
    'Intermediate',
    'Graduation',
    'PostGraduation'
  ];

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * .1,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15, bottom: 10, top: 0),
                child: SizedBox(
                  height: 45,
                  child: CustomFormField(
                      maxLines: 1,
                      maxLimit: 30,
                      maxLimitError: '30',
                      readOnly: false,
                      controlller: widget.controller1,
                      errorMsg: 'Enter Institute Name',
                      labelText: 'Institute Name',
                      validator: (value) {
                        if(widget.controller1==""){
                          return 'Enter Institute Name';
                        }
                      },
                      onChanged: (v) {},
                      icon: Icons.school_outlined,
                      textInputType: TextInputType.name),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(
              //       left: 15.0, right: 15, bottom: 20, top: 10),
              //   child: Theme(
              //     data: ThemeData(
              //       primaryColor: Colors.redAccent,
              //       primaryColorDark: Colors.red,
              //     ),
              //     child: Container(
              //       margin: const EdgeInsets.all(1.0),
              //       padding: const EdgeInsets.only(left: 5.0),
              //       decoration: myBoxDecoration(),
              //       height: 45,
              //       width: MediaQuery.of(context).size.width,
              //       child: Padding(
              //         padding: const EdgeInsets.only(left: 8.0),
              //         child: DropdownButton<String>(
              //             menuMaxHeight: MediaQuery.of(context).size.height,
              //             value: digree,
              //             dropdownColor: Colors.white,
              //             focusColor: Colors.blue,
              //             isExpanded: true,
              //             icon: const Icon(Icons.keyboard_arrow_down),
              //             items: digreeList.map((String items) {
              //               return DropdownMenuItem<String>(
              //                 value: items,
              //                 child: Text(items),
              //               );
              //             }).toList(),
              //             // After selecting the desired option,it will
              //             // change button value to selected value
              //             onChanged: (dig) {
              //               if (mounted) {
              //                 setState(() {
              //                   digree = dig;
              //                 });
              //               }
              //             }),
              //       ),
              //     ),
              //   ),
              // ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 5, bottom: 0, top: 0),
                      child: SizedBox(
                        height: 45,
                        child: CustomFormField(
                            maxLines: 1,
                            maxLimit: 2,
                            maxLimitError: '2',
                            readOnly: false,
                            controlller: widget.controller2,
                            errorMsg: 'Enter Total Marks',
                            labelText: 'Total',
                            validator: (value) {
                              if(widget.controller2==""){
                                return 'Enter Total Marks';
                              }
                            },
                            onChanged: (v) {},
                            icon: Icons.numbers,
                            textInputType: TextInputType.number),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 5, bottom: 0, top: 0),
                      child: SizedBox(
                        height: 45,
                        child: CustomFormField(
                            maxLines: 1,
                            maxLimit: 2,
                            maxLimitError: '2',
                            readOnly: false,
                            controlller: widget.controller3,
                            errorMsg: 'Enter Percentage',
                            labelText: 'Percent',
                            validator: (value) {
                              if(widget.controller3==""){
                                return 'Enter Percentage';
                              }
                            },
                            onChanged: (v) {},
                            icon: Icons.percent,
                            textInputType: TextInputType.number),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15,),
              Padding(
                padding:
                const EdgeInsets.only(left: 15.0, right: 15, bottom: 0),
                child: SizedBox(
                  height: 45,
                  child: CustomDate(
                    controller: widget.controller4,
                    initialDate: DateTime(2010),
                    firstDate: DateTime(1970),
                    lastDate: DateTime(2022),
                    validator: (value) {
                      if(widget.controller4==""){
                        return 'Enter Year';
                      }
                    },
                    labelText: 'Completed Year',
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 68.0),
                  child: SizedBox(
                      height: 45,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * .9,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              backgroundColor: Colors.indigo),
                          onPressed: () {
                            _verifyUser(context);
                          },
                          child: const Text(
                            'Submit',
                            style: TextStyle(fontSize: 17, color: Colors.white),
                          ))),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _verifyUser(BuildContext context) async {
    setState(() {});
    if (formkey.currentState!.validate()) {
      setState(() {});
      if (mounted) {
        setState(() {});
      }
    }
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(width: 1.0, color: Colors.black26),
      borderRadius: const BorderRadius.all(
          Radius.circular(5.0) //                 <--- border radius here
      ),
    );
  }
}
