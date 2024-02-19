// import 'dart:convert';
import 'package:expatroasters/utils/extensions.dart';
import 'package:expatroasters/utils/functions.dart';
// import 'package:expatroaster/utils/globalvar.dart';
import 'package:expatroasters/widgets/backscreens/bottomnav_widget.dart';
// import 'package:expatroaster/widgets/backscreens/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllMenu extends StatefulWidget {
  const AllMenu({super.key});

  @override
  State<AllMenu> createState() {
    return _AllMenuState();
  }
}

class _AllMenuState extends State<AllMenu> with SingleTickerProviderStateMixin {
  var localData = Get.arguments[0]["first"];

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
            "MENU",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                onPressed: () => {},
                icon: const Icon(Icons.shopping_cart),
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
          child: DefaultTabController(
            length: 3,
            child: Column(children: [
              SizedBox(
                height: 3.h,
              ),
              Container(
                height: 7.5.h,
                color: Colors.black,
                child: TabBar(
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.all(10),
                  unselectedLabelColor: Colors.white,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color.fromRGBO(73, 116, 95, 1),
                  ),
                  dividerColor: Colors.transparent,
                  tabs: [
                    Tab(
                      child: Container(
                        height: 35.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: const Color.fromRGBO(114, 162, 138, 1),
                          ),
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "DRINKS",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        height: 35.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                              color: Color.fromRGBO(114, 162, 138, 1)),
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "FOOD",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        height: 35.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                              color: Color.fromRGBO(114, 162, 138, 1)),
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "RETAIL",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    // SizedBox(
                    //   height: 1,
                    // ),
                    ListView(
                      scrollDirection: Axis.vertical,
                      children: [
                        SizedBox(
                          height: 3.h,
                        ),
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(25, 25, 25, 1),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 2.h,
                                      right: 5.w,
                                      bottom: 0,
                                      left: 5.w,
                                    ),
                                    child: Title(
                                      color: Colors.white,
                                      child: const Text(
                                        'Coffe Drink',
                                        style: TextStyle(
                                          fontSize: 30,
                                          color: Color.fromRGBO(
                                            114,
                                            162,
                                            138,
                                            1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 0,
                                        right: 5.w,
                                        bottom: 2.h,
                                        left: 5.w),
                                    child: Divider(
                                      color: Color.fromRGBO(55, 55, 55, 1),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 0,
                                      right: 5.w,
                                      bottom: 0,
                                      left: 5.w,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        printDebug('GO TO DETAIL MENU');
                                      },
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/expresso.png',
                                          ),
                                          const Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                child: Text(
                                                  'Expresso',
                                                  style: TextStyle(
                                                      fontSize: 24,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                child: Text(
                                                  'lorem ipsum domet',
                                                  style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        255, 255, 255, 0.7),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                child: Text(
                                                  'Rp. 38.000',
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          114, 162, 138, 1),
                                                      fontSize: 22),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 2.h,
                                        right: 5.w,
                                        bottom: 2.h,
                                        left: 5.w),
                                    child: Divider(
                                      color: Color.fromRGBO(55, 55, 55, 1),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 0,
                                      right: 5.w,
                                      bottom: 0,
                                      left: 5.w,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        printDebug('GO TO DETAIL MENU');
                                      },
                                      child: Row(
                                        children: [
                                          Image.asset(
                                              'assets/images/expresso.png'),
                                          const Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                child: Text(
                                                  'Expresso',
                                                  style: TextStyle(
                                                      fontSize: 24,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                child: Text(
                                                  'lorem ipsum domet',
                                                  style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        255, 255, 255, 0.7),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                child: Text(
                                                  'Rp. 38.000',
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          114, 162, 138, 1),
                                                      fontSize: 22),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 2.h,
                                        right: 5.w,
                                        bottom: 2.h,
                                        left: 5.w),
                                    child: Divider(
                                      color: Color.fromRGBO(55, 55, 55, 1),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 0,
                                      right: 5.w,
                                      bottom: 0,
                                      left: 5.w,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        printDebug('GO TO DETAIL MENU');
                                      },
                                      child: Row(
                                        children: [
                                          Image.asset(
                                              'assets/images/expresso.png'),
                                          const Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                child: Text(
                                                  'Expresso',
                                                  style: TextStyle(
                                                      fontSize: 24,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                child: Text(
                                                  'lorem ipsum domet',
                                                  style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        255, 255, 255, 0.7),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                child: Text(
                                                  'Rp. 38.000',
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          114, 162, 138, 1),
                                                      fontSize: 22),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 2.h,
                                        right: 5.w,
                                        bottom: 2.h,
                                        left: 5.w),
                                    child: Divider(
                                      color: Color.fromRGBO(55, 55, 55, 1),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 0,
                                      right: 5.w,
                                      bottom: 0,
                                      left: 5.w,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        printDebug('GO TO DETAIL MENU');
                                      },
                                      child: Row(
                                        children: [
                                          Image.asset(
                                              'assets/images/expresso.png'),
                                          const Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                child: Text(
                                                  'Expresso',
                                                  style: TextStyle(
                                                      fontSize: 24,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                child: Text(
                                                  'lorem ipsum domet',
                                                  style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        255, 255, 255, 0.7),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                child: Text(
                                                  'Rp. 38.000',
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          114, 162, 138, 1),
                                                      fontSize: 22),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 2.h,
                                        right: 5.w,
                                        bottom: 2.h,
                                        left: 5.w),
                                    child: Divider(
                                      color: Color.fromRGBO(55, 55, 55, 1),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 0,
                                      right: 5.w,
                                      bottom: 0,
                                      left: 5.w,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        printDebug('GO TO DETAIL MENU');
                                      },
                                      child: Row(
                                        children: [
                                          Image.asset(
                                              'assets/images/expresso.png'),
                                          const Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                child: Text(
                                                  'Expresso',
                                                  style: TextStyle(
                                                      fontSize: 24,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                child: Text(
                                                  'lorem ipsum domet',
                                                  style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        255, 255, 255, 0.7),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                child: Text(
                                                  'Rp. 38.000',
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          114, 162, 138, 1),
                                                      fontSize: 22),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 2.h,
                                        right: 5.h,
                                        bottom: 2.h,
                                        left: 5.w),
                                    child: Divider(
                                      color: Color.fromRGBO(55, 55, 55, 1),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Center(
                      child: Text(
                        'ALL MENU DRINK',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const Center(
                      child: Text(
                        'ALL MENU FOOD',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const Center(
                      child: Text(
                        'ALL MENU RETAIL',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              )
            ]),
          ),
        ),
        bottomNavigationBar: Expatnav(data: localData),
      ),
    );
  }
}
