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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          centerTitle: true,
          title: const Text(
            "LIST OUTLET",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                onPressed: () => {},
                icon: const Icon(Icons.storefront),
                color: Colors.white,
                iconSize: 6.5.w,
              ),
            ),
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.black,
        body: SafeArea(
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: entries.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 200,
                color: Colors.amber[colorCodes[index]],
                child: Center(child: Text('Entry ${entries[index]}')),
                margin: EdgeInsets.all(1.w),
              );
            },
            // separatorBuilder: (BuildContext context, int index) =>
            //     const Divider(),
          ),
        ),
      ),
    );
  }
}
