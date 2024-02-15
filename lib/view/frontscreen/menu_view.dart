import 'dart:convert';

import 'package:expatroaster/utils/extensions.dart';
import 'package:expatroaster/utils/functions.dart';
import 'package:expatroaster/utils/globalvar.dart';
import 'package:expatroaster/widgets/backscreens/bottomnav_widget.dart';
import 'package:expatroaster/widgets/backscreens/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuView extends StatefulWidget {
  const MenuView({Key? key}) : super(key: key);

  @override
  State<MenuView> createState() {
    return _PromotionViewState();
  }
}

class _PromotionViewState extends State<MenuView>
    with SingleTickerProviderStateMixin {
  var localData = Get.arguments[0]["first"];
  var selectedTabIndex = 1;
  late TabController _tabController;
  String body = '';
  dynamic instoreData, onlineData;
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
    printDebug("Promotion - $localData");
  }

  Future _asyncMethod() async {
    //get user detail
    var url = Uri.parse("$urlapi/v1/promotion/get_allinstore");
    var query = jsonDecode(await expatAPI(url, body))["message"];
    var url2 = Uri.parse("$urlapi/v1/promotion/get_allonline");
    var query2 = jsonDecode(await expatAPI(url2, body))["messages"];
    setState(() {
      instoreData = query;
      onlineData = query2;
      is_loading = false;
    });
    printDebug(onlineData.length.toString());
    printDebug(instoreData[0]["id"]);
  }

  instorewidget(i) {
    return SizedBox(
        height: 150,
        width: 100.w,
        child: GestureDetector(
            onTap: () async {
              Get.toNamed("/front-screen/singlePromo", arguments: [
                {"first": Get.arguments[0]["first"]},
                {"second": instoreData[i]["id"]}
              ]);
            },
            child: ClipRRect(
                borderRadius: BorderRadius.circular(5), // Image border
                child: DecoratedBox(
                    decoration: BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                    image: NetworkImage(instoreData[i]["picture"]),
                    fit: BoxFit.cover,
                  ),
                )))));
  }

  onlinewidget(i) {
    return SizedBox(
        height: 150,
        child: GestureDetector(
            onTap: () async {
              Get.toNamed("/front-screen/singlePromo", arguments: [
                {"first": Get.arguments[0]["first"]},
                {"second": onlineData[i]["id"]}
              ]);
            },
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20), // Image border
                child: DecoratedBox(
                    decoration: BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                    image: NetworkImage(onlineData[i]["picture"]),
                    fit: BoxFit.cover,
                  ),
                )))));
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
                  child: const Text("PROMOTION")),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Column(
                        children: [
                          // give the tab bar a height [can change hheight to preferred height]
                          SizedBox(
                              height: 45,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(14, 14, 18, 1),
                                  borderRadius: BorderRadius.circular(
                                    10.0,
                                  ),
                                ),
                                child: TabBar(
                                  controller: _tabController,
                                  // give the indicator a decoration (color and border radius)
                                  indicator: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      25.0,
                                    ),
                                    color: const Color.fromRGBO(78, 78, 97, 1),
                                  ),
                                  labelColor: Colors.white,
                                  unselectedLabelColor: Colors.white,
                                  tabs: const [
                                    // first tab [you can add an icon using the icon property]
                                    Tab(
                                      text: 'ONLINE',
                                    ),

                                    // second tab [you can add an icon using the icon property]
                                    Tab(
                                      text: 'IN-STORE',
                                    ),
                                  ],
                                ),
                              )),
                          SizedBox(
                            height: 2.h,
                          ),

                          SizedBox(
                              height: 65.h,
                              width: 100.w,
                              child: TabBarView(
                                controller: _tabController,
                                children: [
                                  // first tab bar view widget
                                  (is_loading)
                                      ? ShimmerWidget(tinggi: 30, lebar: 100.w)
                                      : ListView.builder(
                                          itemCount: (onlineData == null)
                                              ? 0
                                              : onlineData.length,
                                          itemBuilder: (context, i) {
                                            return Padding(
                                                padding:
                                                    EdgeInsets.only(top: 2.h),
                                                child: onlinewidget(i));
                                          },
                                        ),
                                  (is_loading)
                                      ? ShimmerWidget(tinggi: 30, lebar: 100.w)
                                      : ListView.builder(
                                          itemCount: (instoreData == null)
                                              ? 0
                                              : instoreData.length,
                                          itemBuilder: (context, i) {
                                            return Padding(
                                                padding:
                                                    EdgeInsets.only(top: 2.h),
                                                child: instorewidget(i));
                                          },
                                        ),
                                ],
                              )),
                          // tab bar view here
                        ],
                      ))),
            ),
            bottomNavigationBar: Expatnav(data: localData)));
  }
}
