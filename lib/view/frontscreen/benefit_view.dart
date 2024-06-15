import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:expatroasters/utils/extensions.dart';
import 'package:expatroasters/utils/functions.dart';
import 'package:expatroasters/utils/globalvar.dart';
import 'package:expatroasters/widgets/backscreens/bottomnav_widget.dart';
import 'package:expatroasters/widgets/backscreens/promotion_widget.dart';
import 'package:expatroasters/widgets/backscreens/shimmer_widget.dart';
import 'package:flutter/material.dart';

class BenefitView extends StatefulWidget {
  const BenefitView({super.key});

  @override
  State<BenefitView> createState() {
    return _BenefitViewState();
  }
}

class _BenefitViewState extends State<BenefitView> {
  bool isLoading = true;
  dynamic result;
  final List<dynamic> benefits = [];

  Future _benefit() async {
    //get user detail
    String body = '';
    var url = Uri.parse("$urlapi/v1/settings/get_setting");
    result = jsonDecode(await expatAPI(url, body))["messages"];
    setState(() {
      for (var dt in result) {
        if (dt['content'] == 'Bronze' ||
            dt['content'] == 'Silver' ||
            dt['content'] == 'Gold' ||
            dt['content'] == 'Platinum') {
          benefits.add([
            dt["id"],
            dt["content"],
            dt["value"],
          ]);
        }
      }
      isLoading = false;
    });
    print(benefits[0]);
  }

  final items = [
    //1st Image of Slider
    SizedBox(
        width: 100.w,
        height: 100.h,
        child: const DecoratedBox(
            decoration: BoxDecoration(
          color: Colors.transparent,
          image: DecorationImage(
            image: AssetImage("assets/images/bronze.png"),
            fit: BoxFit.contain,
          ),
        ))),
    SizedBox(
        width: 100.w,
        height: 100.h,
        child: const DecoratedBox(
            decoration: BoxDecoration(
          color: Colors.transparent,
          image: DecorationImage(
            image: AssetImage("assets/images/silver.png"),
            fit: BoxFit.contain,
          ),
        ))),

    SizedBox(
        width: 100.w,
        height: 100.h,
        child: const DecoratedBox(
            decoration: BoxDecoration(
          color: Colors.transparent,
          image: DecorationImage(
            image: AssetImage("assets/images/gold.png"),
            fit: BoxFit.contain,
          ),
        ))),
    SizedBox(
        width: 100.w,
        height: 100.h,
        child: const DecoratedBox(
            decoration: BoxDecoration(
          color: Colors.transparent,
          image: DecorationImage(
            image: AssetImage("assets/images/platinum.png"),
            fit: BoxFit.contain,
          ),
        ))),
  ];

  benefit(index) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if (index == 0) ...[
        Text(benefits[0][2], style: TextStyle(color: Colors.white))
      ] else if (index == 1) ...[
        Text(benefits[1][2], style: TextStyle(color: Colors.white))
      ] else if (index == 2) ...[
        Text(benefits[2][2], style: TextStyle(color: Colors.white))
      ] else if (index == 3) ...[
        Text(benefits[3][2], style: TextStyle(color: Colors.white))
      ]
    ]);
  }

  @override
  void initState() {
    super.initState();
    _benefit();
  }

  int currentIndex = 0;
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
          title: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: const Text(
                "BENEFIT",
                style: TextStyle(color: Colors.white),
              )),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: 100.w,
                  child: Column(
                    children: [
                      CarouselSlider(
                        items: items,
                        options: CarouselOptions(
                          enlargeCenterPage: true,
                          autoPlay: false,
                          aspectRatio: 16 / 9,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          onPageChanged: (index, reason) {
                            setState(() {
                              currentIndex = index;
                              printDebug(currentIndex);
                            });
                          },
                          viewportFraction: 0.8,
                        ),
                      ),
                      DotsIndicator(
                          dotsCount: items.length, position: currentIndex),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50.h,
                  width: 100.w,
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                      child: (isLoading)
                          ? Column(
                              children: [
                                ShimmerWidget(tinggi: 16.h, lebar: 90.w),
                                SizedBox(
                                  height: 2.h,
                                )
                              ],
                            )
                          : benefit(currentIndex)),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 2.h),
                    child: const PromotionView()),
                SizedBox(height: 5.h)
              ],
            ),
          ),
        ),
        bottomNavigationBar: const Expatnav(
          number: 3,
        ),
      ),
    );
  }
}
