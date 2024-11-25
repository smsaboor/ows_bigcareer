import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_package1/components.dart';
import 'package:ows_bigcareer/view/bottom_tabs/bottom_nav_bar.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:ows_bigcareer/view/freelancer/projects/project_service.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class SubmitProjects extends StatefulWidget {
  const SubmitProjects(
      {Key? key,
      required this.title,
      required this.fileList,
      required this.userMobile,
      required this.paymentMode,
      required this.currency,
      required this.amount,
      required this.snapshotSkills,
      required this.details,
      required this.imageList})
      : super(key: key);
  final title,
      details,
      imageList,
      snapshotSkills,
      paymentMode,
      currency,
      amount,
      userMobile,
      fileList;

  @override
  State<SubmitProjects> createState() => _SubmitProjectsState();
}

class _SubmitProjectsState extends State<SubmitProjects> {
  bool uploadingData = false;
  String skills = '';
  List<String>? uploadImagesPath = [];
  bool flagListImageFromMobile = false;
  double percent = 0.0;
  double? _height;
  double? _width;
  int imageLength = 0;
  List<bool> flagImageList = [false, false, false];
  String? skillsAll = '';

  final GlobalKey<FormState> _formKey= GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.imageList.length != 0) {
      flagListImageFromMobile = true;
    }
    for (int i = 0; i < widget.snapshotSkills.data.length; i++) {
      skillsAll = skillsAll! + '${widget.snapshotSkills.data?[i].toString()}, ';
    }
    Timer? timer;
    timer = Timer.periodic(const Duration(milliseconds: 1000), (_) {
      setState(() {
        percent += 20;
        if (percent >= 100) {
          timer!.cancel();
          // percent=0;
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
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
            'Post a Project',
            style: TextStyle(color: Colors.indigo),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .05,
                ),
                Center(
                  child: SizedBox(
                    height: 600,
                    width: MediaQuery.of(context).size.width * .9,
                    child: Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      color: Colors.white,
                      elevation: 2,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 250,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Row(
                                    children: [
                                      Container(
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                bottomLeft: Radius.circular(0),
                                                bottomRight: Radius.circular(20),
                                              ),
                                              color: Colors.indigo),
                                          height: 32,
                                          width: 150,
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '${widget.amount} ${widget.currency} / ${widget.paymentMode}',
                                                  style: const TextStyle(
                                                      fontSize: 11,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 18.0, top: 10),
                                    child: Column(
                                      children: [
                                        Text(
                                          '${widget.title}',
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 0, right: 10, left: 18),
                                    child: Text(
                                      '${widget.details}',
                                      maxLines: 3,
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.black),
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(
                                      left: 18.0, top: 3.0, right: 0),
                                  child: Text(
                                    'Skills',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.redAccent),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 18.0, right: 8),
                                  child: SizedBox(
                                    height: 110,
                                    width: MediaQuery.of(context).size.width * .7,
                                    child: GridView.builder(
                                        itemCount:
                                            widget.snapshotSkills.data.length,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                mainAxisSpacing: 0.0,
                                                crossAxisSpacing: 2.0,
                                                childAspectRatio: 2.5,
                                                crossAxisCount: 3),
                                        itemBuilder:
                                            (BuildContext context, index) {
                                          return Row(
                                            children: [
                                              Container(
                                                height: 25,
                                                decoration: const BoxDecoration(
                                                    color: Colors.indigo,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(20))),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .2,
                                                child: Center(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(3.0),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 6.0),
                                                      child: Text(
                                                        '${(widget.snapshotSkills.data?[index].toString().length ?? 0) > 13 ? '${widget.snapshotSkills.data?[index].toString().substring(0, 10)}...' : widget.snapshotSkills.data?[index].toString() ?? ''}',
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.w400),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              )
                                            ],
                                          );
                                        }),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          flagListImageFromMobile
                              ? Padding(
                                  padding: const EdgeInsets.only(left: 18.0),
                                  child: SizedBox(
                                    height: 120,
                                    width: double.infinity,
                                    child: ListView.builder(
                                        itemCount: widget.imageList!.length,
                                        shrinkWrap: true,
                                        physics: const ScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                right: 12.0),
                                            child: Column(
                                              children: [
                                                Text('Image ${index + 1}'),
                                                SizedBox(
                                                    height: 100,
                                                    width: 100,
                                                    child: Image.file(widget
                                                        .imageList![index])),
                                              ],
                                            ),
                                          );
                                        }),
                                  ),
                                )
                              : Container(),
                          const SizedBox(
                            height: 20,
                          ),
                          flagImageList![0] == false
                              ? Container()
                              : Container(
                                  margin:
                                      const EdgeInsets.only(left: 30, right: 30),
                                  alignment: Alignment.center,
                                  child: Row(
                                    children: [
                                      const Text('Upload Image1: '),
                                      Expanded(
                                        child: LinearPercentIndicator(
                                          //leaner progress bar
                                          animation: true,
                                          animationDuration: 1000,
                                          lineHeight: 15.0,
                                          percent: percent / 100,
                                          center: Text(
                                            percent.toString() + "%",
                                            style: const TextStyle(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black),
                                          ),
                                          linearStrokeCap:
                                              LinearStrokeCap.roundAll,
                                          progressColor: Colors.blue[400],
                                          backgroundColor: Colors.grey[300],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          const SizedBox(
                            height: 10,
                          ),
                          flagImageList![1] == false
                              ? Container()
                              : Container(
                                  margin:
                                      const EdgeInsets.only(left: 30, right: 30),
                                  alignment: Alignment.center,
                                  child: Row(
                                    children: [
                                      const Text('Upload Image 2: '),
                                      Expanded(
                                        child: LinearPercentIndicator(
                                          //leaner progress bar
                                          animation: true,
                                          animationDuration: 1000,
                                          lineHeight: 15.0,
                                          percent: percent / 100,
                                          center: Text(
                                            percent.toString() + "%",
                                            style: const TextStyle(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black),
                                          ),
                                          linearStrokeCap:
                                              LinearStrokeCap.roundAll,
                                          progressColor: Colors.blue[400],
                                          backgroundColor: Colors.grey[300],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          const SizedBox(
                            height: 10,
                          ),
                          flagImageList![2] == false
                              ? Container()
                              : Container(
                                  margin:
                                      const EdgeInsets.only(left: 30, right: 30),
                                  alignment: Alignment.center,
                                  child: Row(
                                    children: [
                                      const Text('Upload Image 3: '),
                                      Expanded(
                                        child: LinearPercentIndicator(
                                          //leaner progress bar
                                          animation: true,
                                          animationDuration: 1000,
                                          lineHeight: 15.0,
                                          percent: percent / 100,
                                          center: Text(
                                            percent.toString() + "%",
                                            style: const TextStyle(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black),
                                          ),
                                          linearStrokeCap:
                                              LinearStrokeCap.roundAll,
                                          progressColor: Colors.blue[400],
                                          backgroundColor: Colors.grey[300],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          const SizedBox(
                            height: 60,
                          ),
                          SizedBox(
                              height: 40,
                              width: MediaQuery.of(context).size.width * .6,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                              color: Colors.white),
                                          borderRadius: BorderRadius.circular(5)),
                                      backgroundColor: Colors.pink),
                                  onPressed: () {
                                    uploadData();
                                  },
                                  child: uploadingData
                                      ? const Center(
                                          child: SizedBox(
                                              height: 10,
                                              width: 10,
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                              )),
                                        )
                                      : const Center(
                                          child: Text(
                                            'POST',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                          ),
                                        ))),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    children: const [
                      Text(
                        'Note: ',
                        style: TextStyle(fontSize: 12, color: Colors.redAccent),
                      ),
                      Text(
                        'Please check all details of project before post.',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  uploadData() async {
    setState(() {
      uploadImagesPath!.clear();
      uploadingData=true;
    });
    if (widget.fileList != null) {
      for (var image in widget.fileList!) {
        print('called------------');
        Dio.FormData formData = Dio.FormData.fromMap({
          "user_id": widget.userMobile,
          "image": await Dio.MultipartFile.fromFile(image.path,
              filename: image.path.split('/').last)
        });
        String result = await DioServices.uploadImage(formData);
        print('-result--------------$result');
        if (result.contains('error')) {
          showToast(msg: result);
        } else {
          setState(() {
            uploadImagesPath!.add(result);
            flagImageList[imageLength] = true;
            imageLength = imageLength + 1;
          });
        }
        setState(() {});
      }
    } else {
      showToast(msg: 'please try again no image selected');
    }

    print('uploadImagesPath------------${uploadImagesPath!.length}');
    if (uploadImagesPath!.length != 0) {
      Dio.FormData formData = Dio.FormData.fromMap({
        "user_id": widget.userMobile,
        "title": widget.title,
        "description": widget.details,
        "skills": skillsAll,
        "paymentMode": widget.paymentMode,
        "currency": widget.currency,
        "amount": widget.amount,
        "image1": uploadImagesPath![0].toString() ?? '',
        "image2": uploadImagesPath![1].isEmpty?'':uploadImagesPath![1].toString() ?? '',
        "image3": uploadImagesPath![2].isEmpty?'':uploadImagesPath![2].toString() ?? ''
      });
      String result = await DioServices.postData(formData);
      print('-result2--------------$result');
      setState(() {
        uploadingData=false;
      });
      if (result.contains('error')) {
        Timer(const Duration(seconds: 2), () {
          showToast(msg: result);
        });
      } else {
        Timer(const Duration(seconds: 2), () {
          showToast(msg: 'project uploaded successfully');
          navigateAndFinsh(context, BigCareerBottomNavBar());
        });
      }
      setState(() {});
    } else {
      showToast(msg: 'please try again no image loaded');
      setState(() {
        uploadingData=false;
      });
    }
    // navigateAndFinsh(context, BigCareerBottomNavBar());
  }
}
