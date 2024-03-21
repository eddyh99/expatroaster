import 'dart:convert';

import 'package:expatroasters/utils/functions.dart';
import 'package:expatroasters/utils/globalvar.dart';
import 'package:flutter/material.dart';
import 'package:expatroasters/utils/extensions.dart';
// import 'package:get/get.dart';

class ListOutlet extends StatefulWidget {
  const ListOutlet({super.key});

  @override
  State<ListOutlet> createState() => _ListOutletState();
}

class _ListOutletState extends State<ListOutlet> {
  final List<String> entries = <String>['A', 'B', 'C', 'D', 'E', 'F'];
  final List<int> colorCodes = <int>[600, 500, 100, 600, 500, 400];
  String body = '';

  @override
  void initState() {
    super.initState();
    _asyncMethod();
  }

  Future _asyncMethod() async {
    //get user detail
    var url = Uri.parse("$urlapi/v1/promotion/get_allinstore");
    var query = jsonDecode(await expatAPI(url, body))["messages"];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.black,
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: const Text("OUTLET")),
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            elevation: 0,
          ),
          body: SafeArea(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: entries.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 200,
                  color: Colors.amber[colorCodes[index]],
                  margin: EdgeInsets.all(1.w),
                  child: Center(child: Text('Entry ${entries[index]}')),
                );
              },
              // separatorBuilder: (BuildContext context, int index) =>
              //     const Divider(),
            ),
          ),
        ));
  }
}
