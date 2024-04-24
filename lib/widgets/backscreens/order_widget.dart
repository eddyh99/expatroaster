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

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  State<OrderView> createState() {
    return _OutletViewState();
  }
}

class _OutletViewState extends State<OrderView> {
  dynamic resultData;
  final List<dynamic> imglst = [];
  bool is_loading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 27.h,
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
                    "ORDER NOW",
                    style: GoogleFonts.inter(color: Colors.white),
                  )),
              SizedBox(
                height: 20.h,
                width: 100.w,
                child: (is_loading)
                    ? Row(
                        children: [
                          ShimmerWidget(tinggi: 20.h, lebar: 32.w),
                          SizedBox(
                            width: 2.w,
                          ),
                          ShimmerWidget(tinggi: 20.h, lebar: 32.w),
                          SizedBox(
                            width: 2.w,
                          ),
                          ShimmerWidget(tinggi: 20.h, lebar: 32.w),
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
                                    child: ListimageView(
                                      image: NetworkImage(imglst[idx][0]),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.transparent,
                                            shadowColor: Colors.transparent),
                                        onPressed: () async {
                                          Get.toNamed(
                                            "/front-screen/list_outlet",
                                            arguments: [
                                              {"second": imglst[idx][2]}
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
                                                imglst[idx][1],
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16),
                                              ),
                                            ),
                                            SizedBox(height: 1.h),
                                            // SizedBox(
                                            //   width: 100.w,
                                            //   child: Text(
                                            //     imglst[idx][2],
                                            //     style: const TextStyle(
                                            //         color: Colors.white,
                                            //         fontSize: 6),
                                            //   ),
                                            // )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                : Container();
                          }).toList());
                        },
                      ),
              ),
              SizedBox(
                height: 1.h,
              ),
            ],
          ),
        ));
  }
}
