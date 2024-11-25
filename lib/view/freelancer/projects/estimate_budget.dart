
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_package1/components.dart';
import 'submit_projects.dart';
class EstimateBudget extends StatefulWidget {
  const EstimateBudget(
      {Key? key,
        required this.title,
        required this.fileList,
        required this.userMobile,
        required this.snapshotSkills,
        required this.details,
        required this.imageList})
      : super(key: key);
  final title, details, imageList,snapshotSkills,userMobile,fileList;

  @override
  State<EstimateBudget> createState() => _EstimateBudgetState();
}

class _EstimateBudgetState extends State<EstimateBudget> {
  TextEditingController controller = TextEditingController();

  double height=40;
  String? currency = 'INR';
  var currencyList = ['INR', 'Dollar', 'Dinar','Riyal'];

  String? paymentMode = 'Hourly';
  var paymentModeList = ['Hourly', 'Monthly', 'Fixed Price'];

  List<String> searchList = [];

  GlobalKey<FormState> formKey=GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Project Budget',
          style: TextStyle(color: Colors.indigo),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black,
                  child: Stack(
                    children: [
                      Container(
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fitHeight,
                                image: AssetImage("assets/img_3.png"))),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                        ),
                      ),
                      Positioned(
                        top: 25,
                        left: 20,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'What is your estimate budget ?',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 50,
                              width: MediaQuery.of(context).size.width * .9,
                              child: const Text(
                                'Select your currency and amount.',
                                maxLines: 2,
                                style:
                                TextStyle(fontSize: 15, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0,right: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 18.0, left: 8,bottom: 5),
                        child: Text(
                          'Select payment mode',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                              color: Colors.black),
                        ),
                      ),
                      paymentModeWidget(),
                      const Padding(
                        padding: EdgeInsets.only(top: 18.0, left: 8,bottom: 5),
                        child: Text(
                          'Select currency',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                              color: Colors.black),
                        ),
                      ),
                      currencyWidget(),
                      const Padding(
                        padding: EdgeInsets.only(top: 18.0, left: 8),
                        child: Text(
                          'Enter Your Amount',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                              color: Colors.black),
                        ),
                      ),
                      buildTextFormField(
                          controller, 45, 1, 'e.g. php, html, css, java', 100),
                      SizedBox(height: MediaQuery.of(context).size.height * .15,),
                      Center(
                        child: SizedBox(
                            height: 45,
                            width: MediaQuery.of(context).size.width * .8,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        side:
                                        const BorderSide(color: Colors.white),
                                        borderRadius: BorderRadius.circular(5)),
                                    backgroundColor: Colors.pink),
                                onPressed: () {
                                  verifyForm();
                                },
                                child: const Center(
                                  child: Text(
                                    'Next',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 21),
                                  ),
                                ))),
                      ),
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

  verifyForm(){
    if(formKey.currentState!.validate()){
      navigateTo(context, SubmitProjects(
        userMobile:widget.userMobile,
        title: widget.title,
        details: widget.details,
        imageList: widget.imageList,
        snapshotSkills: widget.snapshotSkills,
        paymentMode: paymentMode,
        currency: currency,
        amount: controller.text,
          fileList:widget.fileList
      ));
    }
  }
  Widget buildTextFormField(TextEditingController controllerL, double heightL,
      int maxLineL, hint, maxLine) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 0, left: 4.0, right: 3),
      child: SizedBox(
        height: height,
        child: Theme(
          data: ThemeData(
              primaryColor: Colors.redAccent,
              primaryColorDark: Colors.red,
              primarySwatch: Colors.indigo),
          child: TextFormField(
            textInputAction: TextInputAction.next,
            // maxLines: maxLineL,
            controller: controllerL,
            // maxLength: maxLine,
            validator: (value) {
              if(value!.isEmpty){
                setState(() {
                  height=65;
                });
                return 'Enter Amount';
              }else{
                setState(() {
                  height=45;
                });
              }
              return null;
            },
            onFieldSubmitted: (v)async{
            },
            onChanged: (v) {},
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.indigo)),
            ),
          ),
        ),
      ),
    );
  }

  currencyWidget() {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.redAccent,
        primaryColorDark: Colors.red,
      ),
      child: Container(
        margin: const EdgeInsets.all(1.0),
        padding: const EdgeInsets.only(left: 5.0),
        decoration: myBoxDecoration(),
        height: 40,
        //
        width: MediaQuery.of(context).size.width,
        //          <// --- BoxDecoration here
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: DropdownButton(
            // Initial Value
              menuMaxHeight: MediaQuery.of(context).size.height,
              value: currency,
              dropdownColor: Colors.white,
              focusColor: Colors.blue,
              isExpanded: true,
              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),
              // Array list of items
              items: currencyList.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (curr) {
                setState(() {
                  currency = curr.toString();
                });
              }),
        ),
      ),
    );
  }
  paymentModeWidget() {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.redAccent,
        primaryColorDark: Colors.red,
      ),
      child: Container(
        margin: const EdgeInsets.all(1.0),
        padding: const EdgeInsets.only(left: 5.0),
        decoration: myBoxDecoration(),
        height: 40,
        //
        width: MediaQuery.of(context).size.width,
        //          <// --- BoxDecoration here
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: DropdownButton(
            // Initial Value
              menuMaxHeight: MediaQuery.of(context).size.height,
              value: paymentMode,
              dropdownColor: Colors.white,
              focusColor: Colors.blue,
              isExpanded: true,
              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),
              // Array list of items
              items: paymentModeList.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (mode) {
                setState(() {
                  paymentMode = mode.toString();
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
