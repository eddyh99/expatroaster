import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:expatroasters/utils/extensions.dart';
import 'package:expatroasters/utils/functions.dart';
import 'package:expatroasters/utils/globalvar.dart';
import 'package:expatroasters/widgets/backscreens/shimmer_widget.dart';
import 'package:expatroasters/widgets/frontscreens/listimage_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PromotionView extends StatefulWidget {
  const PromotionView({super.key});

  @override
  State<PromotionView> createState() {
    return _PromotionViewState();
  }
}

class _PromotionViewState extends State<PromotionView> {
  dynamic resultData;
  dynamic lengthdata;
  bool is_loading = true;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _asyncMethod();
  }

  Future _asyncMethod() async {
    String body = '';
    var url = Uri.parse("$urlapi/v1/mobile/promotion/get_allpromo");
    resultData = jsonDecode(await expatAPI(url, body))['messages'];
    lengthdata = resultData.length;
    print(lengthdata);
    setState(() {
      is_loading = false;
    });

    // printDebug(imglst[0][0].toString());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 28.h,
        width: 100.w,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(30, 30, 30, 1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 24.h,
                width: 100.w,
                child: (is_loading)
                    ? const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ShimmerWidget(tinggi: 20, lebar: 90),
                        ],
                      )
                    : Column(children: [
                        (lengthdata == 0)
                            ? Column(children: [
                                SizedBox(
                                    height: 13.h,
                                    child: Image.asset(
                                        "assets/images/empty-product.png")),
                                Text(
                                  "EMPTY PROMOTION",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Color.fromRGBO(
                                        114,
                                        162,
                                        138,
                                        1,
                                      ),
                                      fontFamily: GoogleFonts.lora().fontFamily,
                                      fontWeight: FontWeight.w600),
                                ),
                              ])
                            : Column(
                                children: [
                                  SizedBox(
                                    width: 100.w,
                                    height: 20.h,
                                    child: CarouselSlider(
                                      options: CarouselOptions(
                                        autoPlay: true,
                                        aspectRatio: 1.0,
                                        enlargeCenterPage: true,
                                        viewportFraction: 0.84,
                                        onPageChanged: (index, reason) {
                                          setState(() {
                                            currentIndex = index;
                                          });
                                        },
                                      ),
                                      items: [
                                        for (int i = 0; i < lengthdata; i++)
                                          Row(
                                            children: [
                                              Expanded(
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  child: ListimageView(
                                                    image: NetworkImage(
                                                        resultData[i]
                                                            ['picture']),
                                                    child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              shadowColor: Colors
                                                                  .transparent),
                                                      onPressed: () async {
                                                        Get.toNamed(
                                                          "/front-screen/singlePromo",
                                                          arguments: [
                                                            {
                                                              "second":
                                                                  resultData[i]
                                                                      ['id']
                                                            }
                                                          ],
                                                        );
                                                      },
                                                      child: Text(""),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ),
                                  DotsIndicator(
                                    dotsCount: lengthdata == 0 ? 1 : lengthdata,
                                    position: currentIndex,
                                    decorator: DotsDecorator(
                                      color: Color.fromRGBO(255, 255, 255, 0.2),
                                      activeColor:
                                          Color.fromRGBO(114, 162, 138, 1),
                                      size: Size.fromRadius(3),
                                    ),
                                  ),
                                ],
                              )
                      ]),
              ),
              // (is_loading)
              //     ? Row(
              //         crossAxisAlignment: CrossAxisAlignment.center,
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           ShimmerWidget(tinggi: 2.h, lebar: 95.w),
              //         ],
              //       )
              //     : DotsIndicator(
              //         dotsCount: lengthdata == 0 ? 1 : lengthdata,
              //         position: currentIndex,
              //         decorator: DotsDecorator(
              //           color: Color.fromRGBO(255, 255, 255, 0.2),
              //           activeColor: Color.fromRGBO(114, 162, 138, 1),
              //           size: Size.fromRadius(3),
              //         ),
              //       ),
            ],
          ),
        ));
  }
}
