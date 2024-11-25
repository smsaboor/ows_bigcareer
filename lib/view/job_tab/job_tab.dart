import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_package1/components.dart';
import 'package:ows_bigcareer/core/jobs.dart';
import 'package:ows_bigcareer/view/bottom_tabs/bottom_nav_bar.dart';
import 'package:ows_bigcareer/view/job_tab/widgets/banner_government_jobs.dart';
import 'package:ows_bigcareer/view/job_tab/widgets/carousel_slider_job_post.dart';
import 'widgets/job_list_homepage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class JobsTab extends StatefulWidget {
  const JobsTab({Key? key,required this.userMobile}) : super(key: key);
  final userMobile;
  @override
  State<JobsTab> createState() => _JobsTabState();
}

class _JobsTabState extends State<JobsTab> {
  late final Future<List<Jobs>> jobs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    navigateAndFinsh(context, BigCareerBottomNavBar());
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if (mounted) {
      setState(() {});
    }
    _refreshController.loadComplete();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white38,
      body:  SafeArea(
        child: SmartRefresher(
            enablePullDown: true,
            enablePullUp: false,
            header: const WaterDropMaterialHeader(
                color: Colors.white, backgroundColor: Colors.blue),
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            controller: _refreshController,
            child: getBody(widget.userMobile)),
      ),
    );
  }
}

Widget getBody(String mobile){
  return SingleChildScrollView(
    child: Column(
      children: [
        BannerGovernmentJobs(userMobile:mobile),
        const CarouselSliderJobPost(),
        JobsListHomePage(userMobile:mobile)
      ],
    ),
  );
}

