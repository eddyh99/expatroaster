import 'dart:convert';
import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
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
    var url = Uri.parse("$urlapi/v1/outlet/get_allcabang");
    resultData = jsonDecode(await expatAPI(url, body))["messages"];
    //printDebug(resultData);
    for (var isi in resultData) {
      setState(() {
        imglst.add([isi["picture"], isi["nama"], isi["alamat"], isi["id"]]);
        is_loading = false;
      });
    }

    log(imglst.toList().toString());
    // printDebug(imglst[1][0].toString());
    // printDebug(imglst[2][0].toString());
    // printDebug(imglst[3][0].toString());
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
                    "OUTLETS",
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
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  shadowColor:
                                                      Colors.transparent),
                                              onPressed: () async {
                                                Get.toNamed(
                                                    "/front-screen/singleoutlet",
                                                    arguments: [
                                                      {
                                                        "first":
                                                            Get.arguments[0]
                                                                ["first"]
                                                      },
                                                      {"second": imglst[idx][3]}
                                                    ]);
                                              },
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      imglst[idx][1],
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 10),
                                                    ),
                                                    SizedBox(
                                                        width: 100.w,
                                                        child: Text(
                                                          imglst[idx][2],
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 6),
                                                        ))
                                                  ]))))
                                  : Container();
                            }).toList());
                          }))
            ],
          ),
        ));
  }
}
