import 'package:flutter/material.dart';
import 'package:flutter_package1/components.dart';
import 'package:ows_bigcareer/view_model/sharedpreferences_view_model.dart';
import 'package:provider/provider.dart';

class AppBarSearch extends StatefulWidget {
  const AppBarSearch(
      {Key? key, required this.onLocationChanged,required this.viewFilter,required this.searchKeyword, required this.searchLocation})
      : super(key: key);
  final String searchKeyword;
  final String searchLocation;
  final bool viewFilter;
  final onLocationChanged;

  @override
  State<AppBarSearch> createState() => _AppBarSearchState();
}

class _AppBarSearchState extends State<AppBarSearch> {
  var sharedPreferencesVM;

  @override
  void initState() {
    sharedPreferencesVM =
        Provider.of<SharedPreferencesVM>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Text(
          'Cancel',
          style: TextStyle(color: Colors.black, fontSize: 14),
        ),
      ),
      actions: [
        widget.viewFilter?Container():GestureDetector(
          onTap: () async{
            if (widget.searchKeyword.isEmpty) {
              // navigateTo(context, SearchExample());
              showToast(msg: 'Please enter a Keyword');
            } else {
              widget.onLocationChanged();
              await sharedPreferencesVM.setRecentSearches(widget.searchKeyword);
            }
          },
          child: const Padding(
            padding: EdgeInsets.only(top: 12.0, bottom: 12, right: 15),
            child: Text(
              'Search',
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          ),
        )
      ],
    );
  }
}
