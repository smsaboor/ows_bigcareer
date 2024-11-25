import 'package:flutter/material.dart';
import 'package:flutter_package1/components.dart';
import 'package:ows_bigcareer/view_model/sharedpreferences_view_model.dart';
import 'package:provider/provider.dart';

class RecentList extends StatefulWidget {
   RecentList({Key? key,required this.controller,required this.onTap}) : super(key: key);
   var controller;
   var onTap;
  @override
  State<RecentList> createState() => _RecentListState();
}

class _RecentListState extends State<RecentList> {
  var sharedPreferencesVM;
  List<String> searchList = [];

  Future<List<String>> getSearchList() async {
    searchList = await sharedPreferencesVM.getRecentSearches();
    await Future.delayed(
        const Duration(seconds:1));
    return searchList.toList();
  }

  @override
  void initState() {
    sharedPreferencesVM = Provider.of<SharedPreferencesVM>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 5),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'Recent searches',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const Spacer(flex: 2),
              IconButton(
                  onPressed: () async{
                    if(searchList.isEmpty) return showToast(msg: 'already cleared');
                      await sharedPreferencesVM.removeRecentSearches();
                    setState(() {
                    });
                    showToast(msg: 'cleared');
                  },
                  icon: const Icon(
                    Icons.delete,
                    size: 16,
                    color: Colors.black45,
                  )),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height*.6,
            child: FutureBuilder<dynamic>(
                future: getSearchList(),
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.connectionState != ConnectionState.done) {
                    return const Center(child: CircularProgressIndicator(),);
                  }
                  if(snapshot.hasData){
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                            onTap:() {
                              widget.controller.text=snapshot.data?[index] ?? "got null";
                              widget.onTap;
                            },
                            title: Text(snapshot.data?[index] ?? "got null"));
                      },
                    );
                  }
                  if(snapshot.hasError){
                    return Text('${snapshot.error}');
                  }
                  return const Center(child: Text('Loading..'));
                }),
          )
        ],
      ),
    );
  }
}
