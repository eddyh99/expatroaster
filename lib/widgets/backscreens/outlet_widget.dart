import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:expatroasters/utils/extensions.dart';
import 'package:expatroasters/utils/functions.dart';
import 'package:expatroasters/utils/globalvar.dart';
import 'package:expatroasters/widgets/backscreens/shimmer_widget.dart';
import 'package:expatroasters/widgets/frontscreens/listimage_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        height: 27.h,
        width: 100.w,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(30, 30, 30, 1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 21.h,
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
                          aspectRatio: 1.0,
                          enlargeCenterPage: true,
                          viewportFraction: 0.8,
                        ),
                        // itemCount: resultData == null ? 0 : resultData.length,
                        // itemBuilder: (BuildContext context, index){},
                        items: [
                          for (int i = 0; i < lengthdata; i++)
                            Row(
                              children: [
                                Expanded(
                                  child: ListimageView(
                                    image:
                                        NetworkImage(resultData[i]['picture']),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
                                          shadowColor: Colors.transparent),
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
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            ),
                                          ),
                                          SizedBox(height: 1.h),
                                          SizedBox(
                                            width: 100.w,
                                            child: Text(
                                              resultData[i]['alamat'],
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            ),
                                          ),
                                          SizedBox(height: 1.h),
                                        ],
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
            ],
          ),
        ));
  }
}


    // for (int i = 0; i < resultData.length; i++)
    //                           Image.network(resultData[i]['picture']),