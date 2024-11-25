import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart' as cc;
import 'package:flutter_package1/components.dart';
import 'package:ows_bigcareer/model/apis/api_response.dart';
import 'package:ows_bigcareer/model/models/model_jobs_final.dart';
import 'package:ows_bigcareer/model/models/model_jobs_homepage.dart';
import 'package:ows_bigcareer/view/gov_job/apply_for_job.dart';
import 'package:ows_bigcareer/view_model/api_view_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_package1/loading/loading1.dart';

final List<String> imgList = [
  'https://png.pngtree.com/thumb_back/fh260/back_our/20190620/ourmid/pngtree-recruitment-background-banner-image_159061.jpg',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

class CarouselSliderJobPost extends StatefulWidget {
  const CarouselSliderJobPost({Key? key}) : super(key: key);
  @override
  State<CarouselSliderJobPost> createState() => _CarouselSliderJobPostState();
}

class _CarouselSliderJobPostState extends State<CarouselSliderJobPost> {
  final cc.CarouselController  _controller = cc.CarouselController();
  int _current = 0;
  bool dataLoad = true;
  static final List<String> imgList2 = [];
  static List<ModelJobsHomePage2>? fetchedJobs;
  List<Widget>? imageSliders;
  late final buildContext;
  int i = 0;

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<ApiViewModel>(context, listen: false).fetchDataHomePageLatestJobs(ModelJobsFinal(), 'latest_job_post_api.php', null);
    super.initState();
  }

  Widget getCarouselSliderWidget(
      BuildContext context, ApiResponseLatestJobHomePage apiResponse) {
    List<dynamic>? mediaList = apiResponse.data as List<dynamic>?;
    List<Widget>? mediaList2 = [Container(),Container()];
    // fetchedJobs=mediaList as List<ModelJobsHomePage2>;
    // if(apiResponse.status==Status.COMPLETED){
    //   getImageSlider(mediaList);
    // }
    switch (apiResponse.status) {
      case Status.LOADING:
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 18.0),
              child: Center(
                child: LoadingWidget.rectangular(
                  height: 20,
                  width: MediaQuery.of(context).size.width * .26,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .3,
              width: double.infinity,
              child: Card(
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LoadingWidget.rectangular(
                        height: 150,
                        width: MediaQuery.of(context).size.width * .08,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      LoadingWidget.rectangular(
                        height: 150,
                        width: MediaQuery.of(context).size.width * .60,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      LoadingWidget.rectangular(
                        height: 150,
                        width: MediaQuery.of(context).size.width * .08,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      case Status.COMPLETED:
        return Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 18.0),
              child: Center(
                child: Text(
                  'Latest Job Posts',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .3,
              width: double.infinity,
              child: Column(children: [
                Expanded(
                  child: cc.CarouselSlider(
                    items: [
                      Container(
                        margin: const EdgeInsets.all(5.0),
                        child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                            child: Stack(
                              children: <Widget>[
                                Image.network(mediaList![0].companyLogo!,
                                    fit: BoxFit.cover, width: 300),
                                Positioned(
                                    bottom: 10.0,
                                    left: 70.0,
                                    right: 70.0,
                                    top: 120,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        navigateTo(
                                            context,
                                            ApplyForJob(
                                              title: 'Apply For',
                                              data: mediaList![0],
                                            ));
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.redAccent),
                                      child: const Text(
                                        'Apply Now',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                    )),
                              ],
                            )),
                      ),
                      Container(
                        margin: const EdgeInsets.all(5.0),
                        child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                            child: Stack(
                              children: <Widget>[
                                Image.network(mediaList![1].companyLogo!,
                                    fit: BoxFit.cover, width: 300),
                                Positioned(
                                    bottom: 10.0,
                                    left: 70.0,
                                    right: 70.0,
                                    top: 120,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        navigateTo(
                                            context,
                                            ApplyForJob(
                                              title: 'Apply For',
                                              data: mediaList![1],
                                            ));
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.redAccent),
                                      child: const Text(
                                        'Apply Now',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                    )),
                              ],
                            )),
                      )
                    ],
                    // items: getImageSlider(mediaList),
                    carouselController: _controller,
                    options: cc.CarouselOptions(
                        autoPlay: true,
                        enlargeCenterPage: false,
                        aspectRatio: 2.3,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        }),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: mediaList2!.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => _controller.animateToPage(entry.key),
                      child: Container(
                        width: 12.0,
                        height: 12.0,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black)
                                .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                      ),
                    );
                  }).toList(),
                ),
              ]),
            ),
          ],
        );
      case Status.ERROR:
        return const Center(
          child: Text('Error in loading data'),
        );
      case Status.INITIAL:
      default:
      return   SizedBox(
        height: MediaQuery.of(context).size.height * .3,
        width: double.infinity,
        child: Card(
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoadingWidget.rectangular(
                  height: 150,
                  width: MediaQuery.of(context).size.width * .08,
                ),
                SizedBox(
                  width: 20,
                ),
                LoadingWidget.rectangular(
                  height: 150,
                  width: MediaQuery.of(context).size.width * .60,
                ),
                SizedBox(
                  width: 20,
                ),
                LoadingWidget.rectangular(
                  height: 150,
                  width: MediaQuery.of(context).size.width * .08,
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  List<Widget> getImageSlider(context,fetchedJobs) {
    print('sab----------fetchedJobs${fetchedJobs.length}');
    if (i == 0) {
      i = 1;
      imageSliders = fetchedJobs!
          .map<Widget>((item) => Container(
        margin: const EdgeInsets.all(5.0),
        child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            child: Stack(
              children: <Widget>[
                Image.network(item.companyLogo!,
                    fit: BoxFit.cover, width: 300),
                Positioned(
                    bottom: 10.0,
                    left: 70.0,
                    right: 70.0,
                    top: 120,
                    child: ElevatedButton(
                      onPressed: () {
                        navigateTo(
                            buildContext,
                            ApplyForJob(
                              title: 'Apply For',
                              data: item,
                            ));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent),
                      child: const Text(
                        'Apply Now',
                        style: TextStyle(
                            color: Colors.white, fontSize: 12),
                      ),
                    )),
              ],
            )),
      ))
          .toList();
      return fetchedJobs!
          .map<Widget>((item) => Container(
        margin: const EdgeInsets.all(5.0),
        child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            child: Stack(
              children: <Widget>[
                Image.network(item.companyLogo!,
                    fit: BoxFit.cover, width: 300),
                Positioned(
                    bottom: 10.0,
                    left: 70.0,
                    right: 70.0,
                    top: 120,
                    child: ElevatedButton(
                      onPressed: () {
                        navigateTo(
                            context,
                            ApplyForJob(
                              title: 'Apply For',
                              data: item,
                            ));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent),
                      child: const Text(
                        'Apply Now',
                        style: TextStyle(
                            color: Colors.white, fontSize: 12),
                      ),
                    )),
              ],
            )),
      ))
          .toList();
    } else {
      return imageSliders!;
    }
  }

  @override
  Widget build(BuildContext context) {
    ApiResponseLatestJobHomePage apiResponse = Provider.of<ApiViewModel>(context).responseLatestJobHomePage;
    return Column(
      children: [
        getCarouselSliderWidget(context, apiResponse),
      ],
    );
  }
}
