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

class OutletView extends StatefulWidget {
  const OutletView({super.key});

  @override
  State<OutletView> createState() {
    return _OutletViewState();
  }
}

class _OutletViewState extends State<OutletView> {
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
    //get user detail
    String body = '';
    var url = Uri.parse("$urlapi/v1/outlet/get_allcabang");
    resultData = jsonDecode(await expatAPI(url, body))["messages"];
    lengthdata = resultData.length;
    setState(() {
      is_loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 33.h,
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
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ShimmerWidget(tinggi: 20.h, lebar: 95.w),
                        ],
                      )
                    : CarouselSlider(
                        options: CarouselOptions(
                          autoPlay: true,
                          aspectRatio: 1,
                          enlargeCenterPage: true,
                          viewportFraction: 0.84,
                          onPageChanged: (index, reason) {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                        ),
                        // itemCount: resultData == null ? 0 : resultData.length,
                        // itemBuilder: (BuildContext context, index){},
                        items: [
                          for (int i = 0; i < lengthdata; i++)
                            Row(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: ListimageView(
                                      image: NetworkImage(
                                          resultData[i]['picture']),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(0),
                                          ),
                                          backgroundColor:
                                              Color.fromARGB(55, 0, 0, 0),
                                          shadowColor: const Color.fromARGB(
                                              182, 0, 0, 0),
                                        ),
                                        onPressed: () async {
                                          Get.toNamed(
                                            "/front-screen/singleoutlet",
                                            arguments: [
                                              {"second": resultData[i]['id']}
                                            ],
                                          );
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            SizedBox(
                                              width: 100.w,
                                              child: Text(
                                                resultData[i]['nama'],
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        114, 162, 138, 1),
                                                    fontSize: 12,
                                                    fontFamily:
                                                        GoogleFonts.inter()
                                                            .fontFamily,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                            SizedBox(height: 0.3.h),
                                            SizedBox(
                                              width: 100.w,
                                              child: Text(
                                                resultData[i]['alamat'],
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 8),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            SizedBox(height: 1.h),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
              ),
              SizedBox(
                height: 1.h,
              ),
              (is_loading)
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ShimmerWidget(tinggi: 2.h, lebar: 95.w),
                      ],
                    )
                  : DotsIndicator(
                      dotsCount: lengthdata,
                      position: currentIndex,
                      decorator: DotsDecorator(
                        color: Color.fromRGBO(255, 255, 255, 0.2),
                        activeColor: Color.fromRGBO(114, 162, 138, 1),
                        size: Size.fromRadius(3),
                      ),
                    ),
              // SizedBox(
              //   height: 1.h,
              // ),
            ],
          ),
        ));
  }
}


    // for (int i = 0; i < resultData.length; i++)
    //                           Image.network(resultData[i]['picture']),