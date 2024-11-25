import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_package1/components.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ows_bigcareer/view_model/sharedpreferences_view_model.dart';
import 'package:provider/provider.dart';
import 'estimate_budget.dart';

class SkillsNeed extends StatefulWidget {
  const SkillsNeed(
      {Key? key,
      required this.title,
        required this.fileList,
      required this.userMobile,
      required this.details,
      required this.imageList})
      : super(key: key);
  final title, details, imageList, userMobile,fileList;

  @override
  State<SkillsNeed> createState() => _SkillsNeedState();
}

class _SkillsNeedState extends State<SkillsNeed> {
  TextEditingController controller = TextEditingController();
  List<File>? avatarImageFile;
  bool avatarImageFileFlag = false;
  var sharedPreferencesVM;
  var snapshotSkills;
  List<String> searchList = [];
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String skillsError = 'please add minimum 1 skill';
  bool skillsErrorFlag = false;

  Future<List<String>> getSearchList() async {
    searchList = await sharedPreferencesVM.getSkillsSearches();
    await Future.delayed(const Duration(seconds: 1));
    return searchList.toList();
  }

  @override
  void initState() {
    sharedPreferencesVM =
        Provider.of<SharedPreferencesVM>(context, listen: false);
    getSearchList();
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
          'Freelancer Skills',
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
                                'What skills are required ?',
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
                                'Tell us what skills are required for this project.',
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 18.0, left: 8),
                        child: Text(
                          'Enter skills required',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                              color: Colors.black),
                        ),
                      ),
                      buildTextFormField(
                          controller, 45, 1, 'e.g. php, html, css, java', 100),
                      skillsErrorFlag
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(left: 15.0, top: 5),
                              child: Text(
                                skillsError,
                                style:
                                    TextStyle(color: Colors.red, fontSize: 12),
                              ),
                            )
                          : Container(),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * .3,
                          child: FutureBuilder<dynamic>(
                              future: getSearchList(),
                              builder: (context, snapshot) {
                                snapshotSkills = snapshot;
                                if (snapshot.hasData &&
                                    snapshot.connectionState ==
                                        ConnectionState.done) {
                                  return GridView.builder(
                                    itemCount: snapshot.data.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            mainAxisSpacing: 10.0,
                                            crossAxisSpacing: 1.0,
                                            childAspectRatio: 4.0,
                                            crossAxisCount: 3),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Row(
                                        children: [
                                          Container(
                                            height: 30,
                                            decoration: const BoxDecoration(
                                                color: Colors.indigo,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .30,
                                            child: Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 6.0),
                                                      child: Text(
                                                        '${(snapshot.data?[index].toString().length ?? 0) > 13 ? '${snapshot.data?[index].toString().substring(0, 10)}...' : snapshot.data?[index].toString() ?? ''}',
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 6.0),
                                                      child: GestureDetector(
                                                          onTap: () async {
                                                            await sharedPreferencesVM
                                                                .removeSkillsSearchesValue(
                                                                    snapshot.data?[
                                                                        index]);
                                                            setState(() {});
                                                          },
                                                          child: const FaIcon(
                                                              FontAwesomeIcons
                                                                  .xmark,
                                                              color:
                                                                  Colors.white,
                                                              size: 16)),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          )
                                        ],
                                      );
                                    },
                                  );
                                  // return ListView.builder(
                                  //   itemCount: snapshot.data!.length,
                                  //   itemBuilder: (context, index) {
                                  //     return Container(color: Colors.indigo,height: 30,child: Text(snapshot.data?[index]));
                                  //     // return ListTile(
                                  //     //     onTap: (){},
                                  //     //     title: Text(snapshot.data?[index] ?? "got null"));
                                  //   },
                                  // );
                                }

                                /// handles others as you did on question
                                else {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                              }),
                        ),
                      ),
                      Center(
                        child: SizedBox(
                            height: 45,
                            width: MediaQuery.of(context).size.width * .8,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            color: Colors.white),
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

  verifyForm() {
    if (searchList.length == 0) {
      setState(() {
        skillsErrorFlag = true;
      });
    } else {
      setState(() {
        skillsErrorFlag = false;
      });
      navigateTo(
          context,
          EstimateBudget(
              userMobile:widget.userMobile,
              fileList:widget.fileList,
              title: widget.title,
              details: widget.details,
              imageList: widget.imageList,
              snapshotSkills: snapshotSkills));
    }
  }

  Widget buildTextFormField(TextEditingController controllerL, double heightL,
      int maxLineL, hint, maxLine) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 0, left: 8.0, right: 20),
      child: SizedBox(
        height: heightL,
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
            validator: (value) {},
            onFieldSubmitted: (v) async {
              if (v.length == 0) {
              } else {
                await sharedPreferencesVM.setSkillsSearches(v);
                skillsErrorFlag = false;
                setState(() {});
              }
            },
            onChanged: (v) {},
            decoration: InputDecoration(
              hintText: hint,
              suffixIcon: IconButton(
                  onPressed: () async {
                    if (controller.text.length == 0) {
                    } else {
                      await sharedPreferencesVM
                          .setSkillsSearches(controller.text);
                      skillsErrorFlag = false;
                      setState(() {});
                    }
                  },
                  icon: const Icon(Icons.add)),
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.indigo)),
            ),
          ),
        ),
      ),
    );
  }
}
