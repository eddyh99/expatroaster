import 'dart:convert';

import 'package:expatroasters/utils/extensions.dart';
import 'package:expatroasters/utils/functions.dart';
import 'package:expatroasters/utils/globalvar.dart';
import 'package:expatroasters/widgets/backscreens/bottomnav_widget.dart';
import 'package:expatroasters/widgets/backscreens/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SinglepromoView extends StatefulWidget {
  const SinglepromoView({super.key});

  @override
  State<SinglepromoView> createState() {
    return _SinglepromoViewState();
  }
}

class _SinglepromoViewState extends State<SinglepromoView> {
  var localid = Get.arguments[0]["second"];
  var body = "";
  dynamic resultData;
  bool is_loading = true;

  @override
  void initState() {
    super.initState();
    _asyncMethod();
  }

  Future _asyncMethod() async {
    //get user detail
    //printDebug(localid);
    var url = Uri.parse("$urlapi/v1/promotion/getpromo_byid?id=$localid");
    var query = jsonDecode(await expatAPI(url, body))["messages"];
    setState(() {
      resultData = query;
      is_loading = false;
    });
    printDebug(resultData);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.black,
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
                "PROMOTION",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: SafeArea(
                child: SingleChildScrollView(
                    child: Column(
              children: [
                SizedBox(
                    width: 100.w,
                    height: 40.h,
                    child: (is_loading)
                        ? ShimmerWidget(tinggi: 40.h, lebar: 100.w)
                        : DecoratedBox(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(resultData["picture"]),
                                  fit: BoxFit.cover),
                            ),
                          )),
                Padding(
                    padding: EdgeInsets.fromLTRB(5.h, 2.h, 5.h, 0),
                    child: SizedBox(
                        width: 100.w,
                        height: 40.h,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              (resultData == null)
                                  ? ""
                                  : resultData["deskripsi"],
                              style: const TextStyle(
                                  color: Color.fromRGBO(114, 162, 138, 1),
                                  fontSize: 18),
                            ),
                          ],
                        ))),
                SizedBox(
                  width: 40.w,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(114, 162, 138, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          )),
                      onPressed: () async {
                        Get.toNamed("/front-screen/list_outlet");
                      },
                      child: const Text("Shop Now")),
                ),
                SizedBox(
                  height: 5.h,
                )
              ],
            ))),
            bottomNavigationBar: const Expatnav()));
  }
}
