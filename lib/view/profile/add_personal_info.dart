import 'package:flutter/material.dart';
import 'package:flutter_package1/package2/CustomFormField.dart';
import 'package:flutter_package1/package2/date.dart';
import 'package:flutter_package1/package2/select_dialog.dart';
import 'package:ows_bigcareer/view/app_widgets/avtar_image_assets.dart';

class AddPersonalInfo extends StatefulWidget {
  const AddPersonalInfo({Key? key}) : super(key: key);

  @override
  State<AddPersonalInfo> createState() => _AddPersonalInfoState();
}

class _AddPersonalInfoState extends State<AddPersonalInfo> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerMobile = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerDateOfBirth = TextEditingController();
  final TextEditingController _controllerFullAddress = TextEditingController();
  final TextEditingController _controllerCity = TextEditingController();
  final TextEditingController _controllerState = TextEditingController();
  final TextEditingController _controllerPin = TextEditingController();
  String? gender = 'Male';
  var genderList = ['Male', 'Female', 'Others'];
  double height = 45;

  var stateInitial = "Andhra Pradesh";
  var stateList = [
    "Andhra Pradesh",
    "Arunachal Pradesh",
    "Assam",
    "Bihar",
    "Chhattisgarh",
    "Goa",
    "Gujarat",
    "Haryana",
    "Himachal Pradesh",
    "Jammu and Kashmir",
    "Jharkhand",
    "Karnataka",
    "Kerala",
    "Madhya Pradesh",
    "Maharashtra",
    "Manipur",
    "Meghalaya",
    "Mizoram",
    "Nagaland",
    "Odisha",
    "Punjab",
    "Rajasthan",
    "Sikkim",
    "Tamil Nadu",
    "Telangana",
    "Tripura",
    "Uttarakhand",
    "Uttar Pradesh",
    "West Bengal",
    "Andaman and Nicobar Islands",
    "Chandigarh",
    "Dadra and Nagar Haveli",
    "Daman and Diu",
    "Delhi",
    "Lakshadweep",
    "Puducherry"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .05,
            ),
            const AvatarImageAssets(
              'assets/user.png',
              radius: 80,
              height: 90,
              width: 90,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 30.0, right: 30, bottom: 10, top: 20),
              child: SizedBox(
                height: height,
                child: CustomFormField(
                    maxLines: 1,
                    maxLimit: 30,
                    maxLimitError: '30',
                    readOnly: false,
                    controlller: _controllerName,
                    errorMsg: 'Enter Your Name',
                    labelText: 'Name',
                    validator: (value) {},
                    onChanged: (v) {},
                    icon: Icons.person,
                    textInputType: TextInputType.name),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 30.0,
                right: 30,
                bottom: 10,
              ),
              child: SizedBox(
                height: height,
                child: CustomFormField(
                    maxLines: 1,
                    maxLimit: 10,
                    maxLimitError: '10',
                    readOnly: false,
                    controlller: _controllerMobile,
                    errorMsg: 'Enter Your Mobile',
                    labelText: 'Mobile',
                    validator: (value) {},
                    onChanged: (v) {},
                    icon: Icons.phone_android,
                    textInputType: TextInputType.phone),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30, bottom: 10),
              child: SizedBox(
                height: height,
                child: CustomFormField(
                    maxLines: 1,
                    maxLimit: 50,
                    maxLimitError: '50',
                    readOnly: false,
                    controlller: _controllerEmail,
                    errorMsg: 'Enter Your Email',
                    labelText: 'Email',
                    validator: (value) {},
                    onChanged: (v) {},
                    icon: Icons.email_outlined,
                    textInputType: TextInputType.emailAddress),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30, bottom: 10),
              child: SizedBox(
                height: height,
                child: CustomDate(
                    controller: _controllerDateOfBirth,
                    initialDate: DateTime(2000),
                    firstDate: DateTime(1960),
                    lastDate: DateTime(2010),
                    validator: (value) {},
                    labelText: 'Date of Birth (YYYY-MM-DD)'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30, bottom: 10),
              child: Stack(
                children: [
                  SizedBox(
                    height:52,
                    child: Column(
                      children: [
                        const SizedBox(height: 5,),
                        GenderDialog(
                            onChanged: (gen) {
                              if (mounted) {
                                setState(() {
                                  gender = gen;
                                });
                              }
                            },
                            initialValue: gender,
                            height: height),
                      ],
                    ),
                  ),
                  Positioned(
                      top: 0,
                      left: 15,
                      child: Container(
                        width: 50,
                        height: 12,
                        color: Colors.white,
                        child: const Text(
                          '  Gender ',
                          style: TextStyle(fontSize: 11, color: Colors.black87,fontWeight: FontWeight.w300),
                        ),
                      ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30, bottom: 10),
              child: Stack(
                children: [
                  SizedBox(
                    height:52,
                    child: Column(
                      children: [
                        const SizedBox(height: 5,),
                        stateWidget(),
                      ],
                    ),
                  ),
                  Positioned(
                      top: 0,
                      left: 15,
                      child: Container(
                        width: 50,
                        height: 12,
                        color: Colors.white,
                        child: const Text(
                          '  State ',
                          style: TextStyle(fontSize: 11, color: Colors.black87,fontWeight: FontWeight.w300),
                        ),
                      ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30, bottom: 10),
              child: CustomFormField(
                  maxLines: 1,
                  controlller: _controllerCity,
                  errorMsg: 'Enter Your City',
                  labelText: 'City',
                  validator: (value) {},
                  onChanged: (value) {},
                  readOnly: false,
                  maxLimit: 30,
                  maxLimitError: '30',
                  icon: Icons.location_city,
                  textInputType: TextInputType.text),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30, bottom: 10),
              child: CustomFormField(
                  maxLines: 1,
                  controlller: _controllerPin,
                  errorMsg: 'Enter Your Pin',
                  validator: (value) {},
                  onChanged: (value) {},
                  readOnly: false,
                  labelText: 'Pin',
                  maxLimit: 8,
                  maxLimitError: '8',
                  icon: Icons.pin,
                  textInputType: TextInputType.number),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30, bottom: 10),
              child: Theme(
                data: ThemeData(
                  primaryColor: Colors.redAccent,
                  primaryColorDark: Colors.red,
                ),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  maxLines: 2,
                  controller: _controllerFullAddress,
                  decoration: const InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal)),
                      labelText: 'Local Address',
                      prefixText: ' ',
                      // suffixIcon: Icon(
                      //   Icons.note,
                      //   color: Colors.red,
                      // ),
                      suffixStyle: TextStyle(color: Colors.green)),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 38.0),
                child: SizedBox(
                    height: 45,
                    width: MediaQuery.of(context).size.width * .9,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            backgroundColor: Colors.indigo),
                        onPressed: () {
                          // _verifyUser(context);
                        },
                        child: const Text(
                          'Submit',
                          style: TextStyle(fontSize:17,color: Colors.white),
                        ))),
              ),
            ),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }

  stateWidget() {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.redAccent,
        primaryColorDark: Colors.red,
      ),
      child: Container(
        margin: const EdgeInsets.all(1.0),
        padding: const EdgeInsets.only(left: 5.0),
        decoration: myBoxDecoration(),
        height: height,
        //
        width: MediaQuery.of(context).size.width,
        //          <// --- BoxDecoration here
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: DropdownButton(
              // Initial Value
              menuMaxHeight: MediaQuery.of(context).size.height,
              value: stateInitial,
              dropdownColor: Colors.white,
              focusColor: Colors.blue,
              isExpanded: true,
              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),
              // Array list of items
              items: stateList.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (user) {
                setState(() {
                  stateInitial = user.toString();
                });
              }),
        ),
      ),
    );
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
