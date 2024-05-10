import 'dart:convert';
import 'package:expatroasters/utils/extensions.dart';
import 'package:expatroasters/utils/functions.dart';
import 'package:expatroasters/utils/globalvar.dart';
import 'package:expatroasters/utils/utils.dart';
import 'package:expatroasters/widgets/backscreens/bottomnav_widget.dart';
import 'package:expatroasters/widgets/backscreens/outlet_widget.dart';
import 'package:expatroasters/widgets/backscreens/promotion_widget.dart';
import 'package:expatroasters/widgets/backscreens/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() {
    return _HomeViewState();
  }
}

class _HomeViewState extends State<HomeView> {
  dynamic resultData;
  String body = '';
  bool isLoading = true;
  String memberid = '';
  String nama = '';
  String membership = '';
  // String start = '0';

  RangeValues valuesBottom = RangeValues(0, 0);

  Future<dynamic> getPrefer() async {
    var data = await readPrefStr("logged");
    nama = data['nama'];
    printDebug(data);
  }

  Future getProfile() async {
    var url = Uri.parse("$urlapi/v1/mobile/member/get_userdetail");
    var query = jsonDecode(await expatAPI(url, body))["messages"];
    print('query $query');
    print('resultData $resultData');
    if (query != null) {
      setState(() {
        resultData = query;
        membership = resultData['membership'];
        // printDebug(valuesBottom);
        valuesBottom = RangeValues(
          0,
          (resultData['poin'] == null) ? 0 : double.parse(resultData['poin']),
        );
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getProfile();
    getPrefer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 5.h,
                      child: Image.asset("assets/images/logo.png"),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(114, 162, 138, 1),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                      onPressed: () async {
                        Get.toNamed("/front-screen/allpromo", arguments: [
                          {"first": ""}
                        ]);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/icon_discount.png'),
                          SizedBox(
                            width: 2.w,
                          ),
                          const Text("Promo")
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 3.h),
                Stack(
                  children: [
                    SizedBox(
                        height: 25.h,
                        width: 100.w,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(114, 162, 138, 1),
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        )),
                    SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 2.h),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  (isLoading)
                                      ? ShimmerWidget(tinggi: 2.h, lebar: 20.w)
                                      : Row(
                                          children: [
                                            const Text(
                                              "Hi, ",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            Text(
                                              nama,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w800),
                                            )
                                          ],
                                        ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 100.w,
                            height: 28.h,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(30, 30, 30, 1),
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 2.h, horizontal: 2.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              (isLoading)
                                                  ? Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        ShimmerWidget(
                                                            tinggi: 7.h,
                                                            lebar: 18.w),
                                                      ],
                                                    )
                                                  : Column(
                                                      children: [
                                                        const Text(
                                                          "Balance",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        RichText(
                                                          text: TextSpan(
                                                              children: [
                                                                WidgetSpan(
                                                                  child: Transform
                                                                      .translate(
                                                                    offset:
                                                                        const Offset(
                                                                            2,
                                                                            -6),
                                                                    child:
                                                                        const Text(
                                                                      'Rp',
                                                                      //superscript is usually smaller in size
                                                                      textScaleFactor:
                                                                          0.5,
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                  ),
                                                                ),
                                                                WidgetSpan(
                                                                  child: SizedBox(
                                                                      width:
                                                                          1.w),
                                                                ),
                                                                TextSpan(
                                                                  text: (resultData ==
                                                                          null)
                                                                      ? "0"
                                                                      : formatter
                                                                          .format(
                                                                          int.parse(
                                                                            resultData["saldo"],
                                                                          ),
                                                                        ),
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          16),
                                                                ),
                                                              ]),
                                                        ),
                                                      ],
                                                    ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              (isLoading)
                                                  ? Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        ShimmerWidget(
                                                            tinggi: 7.h,
                                                            lebar: 18.w),
                                                      ],
                                                    )
                                                  : Column(
                                                      children: [
                                                        Text(
                                                          "Expat Points",
                                                          style:
                                                              GoogleFonts.inter(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 9),
                                                        ),
                                                        RichText(
                                                          text: TextSpan(
                                                            text: (resultData ==
                                                                        null ||
                                                                    resultData[
                                                                            'poin'] ==
                                                                        null)
                                                                ? "0"
                                                                : formatter.format(
                                                                    int.parse(
                                                                        resultData[
                                                                            "poin"])),
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16),
                                                            children: const [
                                                              TextSpan(
                                                                  text:
                                                                      ' Points'),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                              SizedBox(
                                                height: 1.5.h,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              (isLoading)
                                                  ? Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        ShimmerWidget(
                                                            tinggi: 6.h,
                                                            lebar: 10.w),
                                                      ],
                                                    )
                                                  : GestureDetector(
                                                      onTap: () => {
                                                        Get.toNamed(
                                                            "/front-screen/topup",
                                                            arguments: [
                                                              {
                                                                "first": ""
                                                              } //localData}
                                                            ])
                                                      },
                                                      child: RichText(
                                                        textAlign:
                                                            TextAlign.center,
                                                        text: const TextSpan(
                                                          children: [
                                                            WidgetSpan(
                                                                alignment:
                                                                    PlaceholderAlignment
                                                                        .bottom,
                                                                child:
                                                                    RotatedBox(
                                                                        quarterTurns:
                                                                            -2,
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .arrow_drop_down_circle_outlined,
                                                                          color:
                                                                              Colors.white,
                                                                          size:
                                                                              16,
                                                                        ))),
                                                            TextSpan(
                                                              text: 'Top Up',
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        (isLoading)
                                            ? Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    height: 4.h,
                                                  ),
                                                  ShimmerWidget(
                                                      tinggi: 2.h, lebar: 20.w),
                                                ],
                                              )
                                            : Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Text(
                                                    "You are in ",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    "$membership Member "
                                                        .toUpperCase(),
                                                    style: const TextStyle(
                                                        color: Color.fromRGBO(
                                                            114, 162, 138, 1),
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                        (isLoading)
                                            ? Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    height: 6.h,
                                                  ),
                                                  ShimmerWidget(
                                                      tinggi: 3.h, lebar: 72.w),
                                                ],
                                              )
                                            : SliderTheme(
                                                data: const SliderThemeData(
                                                  rangeTickMarkShape:
                                                      RoundRangeSliderTickMarkShape(
                                                    tickMarkRadius: 3,
                                                  ),
                                                  rangeThumbShape:
                                                      RoundRangeSliderThumbShape(
                                                    disabledThumbRadius: 10,
                                                    enabledThumbRadius: 10,
                                                  ),
                                                  trackHeight: 2,
                                                  inactiveTickMarkColor:
                                                      Color.fromRGBO(
                                                          217, 217, 217, 1),
                                                  inactiveTrackColor:
                                                      Color.fromRGBO(
                                                          217, 217, 217, 1),

                                                  /// Active
                                                  thumbColor: Color.fromRGBO(
                                                      114, 162, 138, 1),
                                                  activeTrackColor:
                                                      Color.fromRGBO(
                                                          114, 162, 138, 1),
                                                  activeTickMarkColor:
                                                      Color.fromRGBO(
                                                          114, 162, 138, 1),
                                                ),
                                                child: buildSliderTopLabel(),
                                              ),
                                        // buildSliderTopLabel()
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 2.h), child: const OutletView()),
          Padding(
              padding: EdgeInsets.only(top: 2.h), child: const PromotionView()),
          SizedBox(
            height: 5.h,
          )
        ]))),
        bottomNavigationBar: const Expatnav(
          number: 0,
        ));
  }

  Widget buildSliderTopLabel() {
    final labels = ['0', '200', '400', '600', '800', '1k'];
    const double _min = 0;
    const double _max = 1000;
    const _divisions = 1000;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 82.w,
          child: RangeSlider(
            values: valuesBottom,
            // activeColor: Color.fromRGBO(114, 162, 138, 1),
            // inactiveColor: Color.fromRGBO(217, 217, 217, 1),
            min: _min,
            max: _max,
            divisions: _divisions,
            onChanged: (value) => print(value),
          ),
        ),
        Container(
          width: 75.w,
          margin: const EdgeInsets.symmetric(horizontal: 1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: Utils.modelBuilder(
              labels,
              (index, label) {
                const selectedColor = Colors.white;
                const unselectedColor = Color.fromARGB(70, 255, 255, 255);
                final isSelected =
                    index >= valuesBottom.start && index <= valuesBottom.end;
                final color = isSelected ? selectedColor : unselectedColor;

                return buildLabel(label: label, color: color);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget buildLabel({
    required String label,
    required Color color,
  }) =>
      Text(
        label,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ).copyWith(color: color),
      );
}
