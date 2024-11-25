import 'package:flutter/material.dart';
import 'package:flutter_package1/components.dart';
import 'package:ows_bigcareer/model/apis/api_response.dart';
import 'package:ows_bigcareer/model/models/model_freelancers.dart';
import 'package:ows_bigcareer/view/freelancer/freelancer/widgets/freelancers_list.dart';
import 'package:ows_bigcareer/view_model/api_view_model.dart';
import 'package:provider/provider.dart';
import 'widgets/freelancer_appbar.dart';
import 'widgets/freelancer_searchBar.dart';
import 'package:ows_bigcareer/view/freelancer/widget/custom_widget_list.dart';
import 'add_freelancer.dart';

class Freelancers extends StatefulWidget {
  const Freelancers({super.key,required this.userMobile});
  final userMobile;
  @override
  _FreelancersState createState() => _FreelancersState();
}

class _FreelancersState extends State<Freelancers> {
  final TextEditingController _inputController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<ApiViewModel>(context, listen: false)
        .fetchDataFreelancer(ModelFreelancers(), 'freelancers_api.php',null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ApiResponseFreelancer apiResponse = Provider.of<ApiViewModel>(context).responseFreelancer;
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(40), child: FreelancerAppBar()),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.indigo,
          onPressed: () {
            navigateTo(context, AddFreelancer(userMobile: widget.userMobile));
          },
          child: const Icon(Icons.add)),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FreelancerSearchBar(
              title: 'Search Freelancers',
              controller: _inputController,
              onSubmitted: (value) {
                Map<String, dynamic> body = {'skill': value};
                if (value.isNotEmpty) {
                  Provider.of<ApiViewModel>(context, listen: false)
                      .setData(null);
                  Provider.of<ApiViewModel>(context, listen: false)
                      .fetchDataFreelancer(ModelFreelancers(), 'search_freelancers_api.php',body);
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
                height: MediaQuery.of(context).size.height * .8,
                child: CustomWidgetDataList(
                  apiResponse: apiResponse,
                  title: 'freelancer',
                  dynamicWidget: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        flex: 8,
                        child: FreelancersListWidget(
                            userMobile:widget.userMobile,
                            (ModelFreelancers freelancer) {
                          Provider.of<ApiViewModel>(context, listen: false)
                              .setData(freelancer);
                        },apiResponse),
                      ),
                      SizedBox(height: 40,)
                    ],
                  ),
                )),
            // SizedBox(
            //     height: MediaQuery.of(context).size.height * .7,
            //     child: getFreelancerWidget(context, apiResponse)),
          ],
        ),
      ),
    );
  }
}
