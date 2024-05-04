import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:expatroasters/utils/extensions.dart';
import 'package:expatroasters/utils/functions.dart';
import 'package:expatroasters/utils/globalvar.dart';
import 'package:expatroasters/widgets/backscreens/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingView extends StatefulWidget {
  const LandingView({super.key});

  @override
  State<LandingView> createState() {
    return _LandingViewState();
  }
}

class _LandingViewState extends State<LandingView> {
  var items = [
    SizedBox(
      width: 100.h,
      height: 100.h,
      child: const DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            image: AssetImage("assets/images/landing.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    ),
    SizedBox(
      width: 100.h,
      height: 100.h,
      child: const DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            image: AssetImage("assets/images/background2.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    ),
    SizedBox(
      width: 100.h,
      height: 100.h,
      child: const DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            image: AssetImage("assets/images/background3.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    ),
  ];

  int currentIndex = 0;

  // Future _asyncMethod() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   var email = prefs.getString("email");
  //   var passwd = prefs.getString("passwd");
  //   var rememberme = prefs.getBool("_rememberme");
  //   if (rememberme == true) {
  //     Map<String, dynamic> mdata;
  //     mdata = {'email': email, 'passwd': passwd};
  //     var url = Uri.parse("$urlapi/auth/signin");
  //     var result = jsonDecode(await expatAPI(url, jsonEncode(mdata)));
  //     printDebug(result);
  //     if (result["code"] == "200") {
  //       Get.toNamed("/front-screen/home", arguments: [
  //         {"first": result["message"]}
  //       ]);
  //     } else {
  //       var psnerror = result["message"];
  //       if (context.mounted) {
  //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //           content: Text(psnerror),
  //           backgroundColor: Colors.deepOrange,
  //         ));
  //         Get.toNamed("/front-screen/signin");
  //       }
  //     }
  //   }
  // }

  @override
  void initState() {
    super.initState();
    // _asyncMethod();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            CarouselSlider(
              items: items,
              options: CarouselOptions(
                height: 100.h,
                viewportFraction: 1.0,
                enlargeCenterPage: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
            ),
            Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Good Coffee All Around",
                  style: GoogleFonts.lora(color: Colors.white, fontSize: 24),
                ),
                SizedBox(
                  height: 2.h,
                ),
                SizedBox(
                  child: ButtonWidget(
                      name: "btnPrimaryLight",
                      text: "Get Started",
                      boxsize: '80',
                      onTap: () {
                        Get.toNamed("/front-screen/getstarted");
                      }),
                ),
                SizedBox(
                  height: 1.h,
                ),
                DotsIndicator(dotsCount: items.length, position: currentIndex),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
