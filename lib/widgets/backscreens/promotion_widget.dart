import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
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
  final List<dynamic> imglst = [];
  bool is_loading = true;
  @override
  void initState() {
    super.initState();
    _asyncMethod();
  }

  Future _asyncMethod() async {
    //get user detail
    String body = '';
    var url = Uri.parse("$urlapi/v1/mobile/promotion/get_allpromo");
    resultData = jsonDecode(await expatAPI(url, body))['messages'];
    // printDebug(resultData);
    for (var isi in resultData) {
      setState(() {
        imglst.add([isi["picture"], isi["id"]]);
        is_loading = false;
      });
    }
    // printDebug(imglst[0][0].toString());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 26.h,
        width: 100.w,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(30, 30, 30, 1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
                  child: Text(
                    "PROMOTIONS",
                    style: GoogleFonts.inter(color: Colors.white),
                  )),
              SizedBox(
                  height: 20.h,
                  width: 100.w,
                  child: (is_loading)
                      ? Row(
                          children: [
                            ShimmerWidget(tinggi: 20.h, lebar: 49.w),
                            SizedBox(
                              width: 2.w,
                            ),
                            ShimmerWidget(tinggi: 20.h, lebar: 49.w),
                          ],
                        )
                      : CarouselSlider.builder(
                          options: CarouselOptions(
                            autoPlay: true,
                            aspectRatio: 1.0,
                            enlargeCenterPage: true,
                            viewportFraction: 1,
                          ),
                          itemCount: (imglst.length / 3).round(),
                          itemBuilder: (context, index, realIdx) {
                            final int first = index * 3;
                            final int second = first + 1;
                            final int third = second + 1;
                            return Row(
                                children: [first, second, third].map((idx) {
                              return (imglst.asMap().containsKey(idx))
                                  ? Expanded(
                                      flex: 1,
                                      child: GestureDetector(
                                          onTap: () {
                                            Get.toNamed(
                                                "/front-screen/singlePromo",
                                                arguments: [
                                                  {"second": imglst[idx][1]}
                                                ]);
                                          },
                                          child: ListimageView(
                                            image: NetworkImage(imglst[idx][0]),
                                            child: Container(),
                                          )))
                                  : Container();
                            }).toList());
                          }))
            ],
          ),
        ));
  }
}
