import 'package:flutter/material.dart';
import 'package:flutter_package1/components.dart';
import 'package:ows_bigcareer/model/apis/api_response.dart';
import 'package:ows_bigcareer/model/models/model_display_all_projects.dart';
import 'package:ows_bigcareer/view/freelancer/freelancer/widgets/freelancer_searchBar.dart';
import 'package:ows_bigcareer/view/freelancer/projects/add_new_project.dart';
import 'package:ows_bigcareer/view/freelancer/projects/widget/projects_list_widget.dart';
import 'package:ows_bigcareer/view_model/api_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreenProjects extends StatefulWidget {
  const HomeScreenProjects({super.key, required this.userMobile});

  final userMobile;

  @override
  _HomeScreenProjectsState createState() => _HomeScreenProjectsState();
}

class _HomeScreenProjectsState extends State<HomeScreenProjects> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<ApiViewModel>(context, listen: false)
        .fetchDataProjects(ModelDisplayAllProjects(), 'display_projects_api.php', null);
    // Provider.of<ProjectsViewModel>(context, listen: false).fetchProjectsData2('projects_api.php');
    super.initState();
  }

  Widget getProjectsWidget(
      BuildContext context, ApiResponseProjects apiResponse) {
    List<dynamic>? mediaList = apiResponse.data as List<dynamic>?;
    switch (apiResponse.status) {
      case Status.LOADING:
        return const Center(child: CircularProgressIndicator());
      case Status.COMPLETED:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 8,
              child: ProjectsListWidget(widget.userMobile,mediaList!, (ModelDisplayAllProjects projects) {
                Provider.of<ApiViewModel>(context, listen: false)
                    .setData(projects);
              }),
            ),
          ],
        );
      case Status.ERROR:
        return const Center(
          child: Text('Please try again latter!!!'),
        );
      case Status.INITIAL:
      default:
        return const Center(
          child: Text('Search the Freelancers'),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final _inputController = TextEditingController();
    ApiResponseProjects apiResponse =
        Provider.of<ApiViewModel>(context).responseProjects;
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
          'Projects',
          style: TextStyle(color: Colors.indigo),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.indigo,
          onPressed: () {
            navigateTo(context, AddNewProject(userMobile:widget.userMobile));
          },
          child: const Icon(Icons.add)),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FreelancerSearchBar(
              title: 'Search Projects',
              controller: _inputController,
              onSubmitted: (value) {
                Map<String, dynamic> body = {'skill': value};
                if (value.isNotEmpty) {
                  Provider.of<ApiViewModel>(context, listen: false)
                      .setData(null);
                  Provider.of<ApiViewModel>(context, listen: false)
                      .fetchDataProjects(
                      ModelDisplayAllProjects(), 'search_projects_api.php', body);
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Container(
                height: 35,
                color: Colors.white,
                width: double.infinity,
                child: const Text(
                  'Top results',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height * .7,
                child: getProjectsWidget(context, apiResponse)),
          ],
        ),
      ),
    );
  }
}
