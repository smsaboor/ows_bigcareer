import 'package:flutter/material.dart';
import 'package:flutter_package1/package2/CustomFormField.dart';
import 'package:flutter_package1/package2/date.dart';

class AddCertificate extends StatefulWidget {
  const AddCertificate({Key? key}) : super(key: key);

  @override
  State<AddCertificate> createState() => _AddCertificateState();
}

class _AddCertificateState extends State<AddCertificate> {
  String? digree = 'HighSchool';
  var digreeList = [
    'HighSchool',
    'Intermediate',
    'Graduation',
    'PostGraduation'
  ];
  final TextEditingController _controllerInstitute = TextEditingController();
  final TextEditingController _controllerCertificate = TextEditingController();
  final TextEditingController _controllerCompletedYear =
  TextEditingController();
  final TextEditingController _controllerPercentage = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Certificate'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .1,
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
                      controlller: _controllerCertificate,
                      errorMsg: 'Enter Certificate Name',
                      labelText: 'Certificate Name',
                      validator: (value) {},
                      onChanged: (v) {},
                      icon: Icons.sticky_note_2_outlined,
                      textInputType: TextInputType.name),
                ),
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
                      controlller: _controllerInstitute,
                      errorMsg: 'Enter Institute Name',
                      labelText: 'Institute Name',
                      validator: (value) {},
                      onChanged: (v) {},
                      icon: Icons.school_outlined,
                      textInputType: TextInputType.name),
                ),
              ),
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
                            controlller: _controllerPercentage,
                            errorMsg: 'Enter Percentage',
                            labelText: 'Percent',
                            validator: (value) {},
                            onChanged: (v) {},
                            icon: Icons.percent,
                            textInputType: TextInputType.number),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                      const EdgeInsets.only(left: 5.0, right: 15, bottom: 0),
                      child: SizedBox(
                        height: 45,
                        child: CustomDate(
                          controller: _controllerCompletedYear,
                          initialDate: DateTime(2010),
                          firstDate: DateTime(1970),
                          lastDate: DateTime(2022),
                          validator: (value) {},
                          labelText: 'Completed Year',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 68.0),
                  child: SizedBox(
                      height: 45,
                      width: MediaQuery.of(context).size.width * .9,
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
                            style: TextStyle(fontSize:17,color: Colors.white),
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
      setState(() {
      });
      if (mounted) {
        setState(() {
        });
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
