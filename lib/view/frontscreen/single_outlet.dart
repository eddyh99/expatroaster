import 'dart:convert';

import 'package:expatroasters/utils/extensions.dart';
import 'package:expatroasters/utils/functions.dart';
import 'package:expatroasters/utils/globalvar.dart';
import 'package:expatroasters/widgets/backscreens/bottomnav_widget.dart';
import 'package:expatroasters/widgets/backscreens/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SingleoutletView extends StatefulWidget {
  const SingleoutletView({super.key});

  @override
  State<SingleoutletView> createState() {
    return _SingleoutletViewState();
  }
}

class _SingleoutletViewState extends State<SingleoutletView> {
  var localid = Get.arguments[0]["second"];
  var body = "";
  dynamic resultData;
  bool is_loading = true;

  @override
  void initState() {
    super.initState();
    //printDebug(localid);
    _asyncMethod();
  }

  Future _asyncMethod() async {
    //get user detail
    var url = Uri.parse("$urlapi/v1/outlet/getcabang_byid?id=$localid");
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
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: SingleChildScrollView(
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
                                  image: NetworkImage(
                                      (resultData["picture"]?.isEmpty ?? true)
                                          ? const AssetImage(
                                              "assets/images/about.png")
                                          : resultData["picture"]),
                                  fit: BoxFit.cover),
                            ),
                          )),
                Padding(
                    padding: EdgeInsets.fromLTRB(5.h, 2.h, 5.h, 0),
                    child: SizedBox(
                        width: 100.w,
                        height: 45.h,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              (resultData == null) ? "" : resultData["nama"],
                              style: const TextStyle(
                                  color: Color.fromRGBO(114, 162, 138, 1),
                                  fontSize: 18),
                            ),
                            Padding(
                                padding: EdgeInsets.only(top: 1.h),
                                child: SizedBox(
                                    width: 100.w,
                                    height: 15.h,
                                    child: DecoratedBox(
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            top: BorderSide(
                                              //
                                              color: Colors.white,
                                              width: 1.0,
                                            ),
                                            bottom: BorderSide(
                                              //
                                              color: Colors.white,
                                              width: 1.0,
                                            ),
                                          ),
                                        ),
                                        child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 1.h),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text("Address",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  SizedBox(
                                                    height: 1.h,
                                                  ),
                                                  (is_loading)
                                                      ? const ShimmerWidget(
                                                          tinggi: 15,
                                                          lebar: 100)
                                                      : Text(
                                                          resultData["alamat"],
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 12),
                                                        )
                                                ]))))),
                            Padding(
                                padding: EdgeInsets.only(top: 1.h),
                                child: SizedBox(
                                    width: 100.w,
                                    height: 10.h,
                                    child: DecoratedBox(
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              //
                                              color: Colors.white,
                                              width: 1.0,
                                            ),
                                          ),
                                        ),
                                        child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 1.h),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text("OPENING HOURS",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  SizedBox(
                                                    height: 1.h,
                                                  ),
                                                  (is_loading)
                                                      ? const ShimmerWidget(
                                                          tinggi: 15,
                                                          lebar: 100)
                                                      : Text(
                                                          resultData["opening"],
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 12),
                                                        )
                                                ]))))),
                            SizedBox(
                              height: 2.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("CONTACT",
                                        style: TextStyle(
                                          color: Colors.white,
                                        )),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    (is_loading)
                                        ? const ShimmerWidget(
                                            tinggi: 15, lebar: 100)
                                        : Text(
                                            resultData["kontak"],
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromRGBO(
                                            78, 78, 97, 0.2),
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                      onPressed: () async {
                                        Get.toNamed("/front-screen/allmenu");
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                              'assets/images/icon-menu.png'),
                                          SizedBox(
                                            width: 1.w,
                                          ),
                                          Text(
                                            'Menu'.toUpperCase(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ))),
                SizedBox(
                  height: 5.h,
                )
              ],
            )),
            bottomNavigationBar: const Expatnav()));
  }
}
