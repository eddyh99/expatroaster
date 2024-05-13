import 'dart:convert';
// import 'dart:js_util';

import 'package:expatroasters/utils/extensions.dart';
import 'package:expatroasters/utils/functions.dart';
import 'package:expatroasters/utils/globalvar.dart';
import 'package:expatroasters/widgets/backscreens/bottomnav_widget.dart';
import 'package:expatroasters/widgets/backscreens/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PromotionView extends StatefulWidget {
  const PromotionView({super.key});

  @override
  State<PromotionView> createState() {
    return _PromotionViewState();
  }
}

class _PromotionViewState extends State<PromotionView>
    with SingleTickerProviderStateMixin {
  var selectedTabIndex = 1;
  late TabController _tabController;
  String body = '';
  dynamic instoreData, onlineData, promotion;
  bool is_loading = true;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        selectedTabIndex = _tabController.index;
      });
    });
    _asyncMethod();
  }

  Future _asyncMethod() async {
    //get user detail
    // var url = Uri.parse("$urlapi/v1/mobile/promotion/get_allinstore");
    // var query = jsonDecode(await expatAPI(url, body))["messages"];
    // var url2 = Uri.parse("$urlapi/v1/mobile/promotion/get_allonline");
    // var query2 = jsonDecode(await expatAPI(url2, body))["messages"];

    var url3 = Uri.parse("$urlapi/v1/mobile/promotion/get_allpromo");
    var allpromotion = jsonDecode(await expatAPI(url3, body))["messages"];

    setState(() {
      // instoreData = query;
      // onlineData = query2;
      promotion = allpromotion;
      is_loading = false;
      printDebug(promotion);
    });
  }

  // instorewidget(i) {
  //   return SizedBox(
  //       height: 150,
  //       width: 100.w,
  //       child: GestureDetector(
  //           onTap: () async {
  //             Get.toNamed("/front-screen/singlePromo", arguments: [
  //               {"second": instoreData[i]["id"]}
  //             ]);
  //           },
  //           child: ClipRRect(
  //               borderRadius: BorderRadius.circular(5), // Image border
  //               child: DecoratedBox(
  //                   decoration: BoxDecoration(
  //                 color: Colors.black,
  //                 image: DecorationImage(
  //                   image: NetworkImage(instoreData[i]["picture"]),
  //                   fit: BoxFit.cover,
  //                 ),
  //               )))));
  // }

  // onlinewidget(i) {
  //   return SizedBox(
  //     height: 150,
  //     child: GestureDetector(
  //       onTap: () async {
  //         Get.toNamed("/front-screen/singlePromo", arguments: [
  //           {"second": onlineData[i]["id"]}
  //         ]);
  //       },
  //       child: ClipRRect(
  //         borderRadius: BorderRadius.circular(20), // Image border
  //         child: DecoratedBox(
  //           decoration: BoxDecoration(
  //             color: Colors.black,
  //             image: DecorationImage(
  //               image: NetworkImage(onlineData[i]["picture"]),
  //               fit: BoxFit.cover,
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

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
              child: const Text("PROMOTION")),
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: (is_loading)
                ? ShimmerWidget(tinggi: 80.h, lebar: 100.w)
                : ListView.builder(
                    itemCount: (promotion == null) ? 0 : promotion.length,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: EdgeInsets.only(top: 2.h),
                        child: SizedBox(
                          width: 100.w,
                          height: 25.h,
                          child: GestureDetector(
                            onTap: () async {
                              Get.toNamed("/front-screen/singlePromo",
                                  arguments: [
                                    {"second": promotion[i]["id"]}
                                  ]);
                            },
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(4), // Image border
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  image: DecorationImage(
                                    image:
                                        NetworkImage(promotion[i]["picture"]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ),
        bottomNavigationBar: const Expatnav(
          number: 0,
        ),
      ),
    );
  }
}
