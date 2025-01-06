import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:expatroasters/utils/extensions.dart';
import 'package:expatroasters/widgets/backscreens/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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

  @override
  void initState() {
    super.initState();
    // _asyncMethod();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
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
                        Get.toNamed("/front-screen/list_outlet");
                      }),
                ),
                SizedBox(
                  height: 1.h,
                ),
                DotsIndicator(
                  dotsCount: items.length,
                  position: currentIndex,
                  decorator: DotsDecorator(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    activeColor: Color.fromRGBO(114, 162, 138, 1),
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
