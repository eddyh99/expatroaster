import 'dart:convert';
import 'package:expatroasters/utils/extensions.dart';
import 'package:expatroasters/utils/functions.dart';
import 'package:expatroasters/utils/globalvar.dart';
import 'package:expatroasters/widgets/backscreens/bottomnav_widget.dart';
import 'package:expatroasters/widgets/backscreens/outlet_widget.dart';
import 'package:expatroasters/widgets/backscreens/promotion_widget.dart';
import 'package:expatroasters/widgets/backscreens/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shared_preferences/shared_preferences.dart';

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
  double point = 0.0;
  List<String> labels = [];
  late double _currentSliderValue;
  RangeValues valuesBottom = const RangeValues(0, 0);

  Future<dynamic> getPrefer() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var getNama = prefs.getString("nama");
    nama = getNama!;
  }

  Future getProfile() async {
    var url = Uri.parse("$urlapi/v1/mobile/member/get_userdetail");
    var query = jsonDecode(await expatAPI(url, body))["messages"];
    if (query != null) {
      setState(() {
        resultData = query;
        membership = resultData['membership'];
        _currentSliderValue = double.parse(resultData["poin"]);
        point =
            (resultData['poin'] == null) ? 0 : double.parse(resultData['poin']);
        // printDebug(valuesBottom);
        valuesBottom = RangeValues(
          0,
          (resultData['poin'] == null) ? 0 : double.parse(resultData['poin']),
        );
        List<String> stepValuesList = resultData["step_values"].split(',');

        // Convert and add step values to the labels list
        for (var value in stepValuesList) {
          int intValue = int.parse(value);
          if (intValue >= 1000) {
            labels.add('${(intValue / 1000).toStringAsFixed(1)}K');
          } else {
            labels.add(value);
          }
        }
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 5.h,
                      child: Image.asset("assets/images/logo.png"),
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
                                      : SizedBox(
                                          width: 80.w,
                                          child: Center(
                                            child: Text.rich(TextSpan(
                                                text: "Hi, ",
                                                style: const TextStyle(
                                                    fontSize: 16),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: nama,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w800))
                                                ])),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 100.w,
                            height: 26.h,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(30, 30, 30, 1),
                                borderRadius: BorderRadius.circular(1.0),
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
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Text(
                                                          "Balance",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 9,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300),
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
                                                                    child: Text(
                                                                      'Rp',
                                                                      style: TextStyle(
                                                                          fontSize: 16 *
                                                                              MediaQuery.textScalerOf(context).scale(
                                                                                  0.5),
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
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Expat. Roasters Points",
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
                                                MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 2.h,
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
                                                  : Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        GestureDetector(
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
                                                                TextAlign.start,
                                                            text:
                                                                const TextSpan(
                                                              children: [
                                                                WidgetSpan(
                                                                    alignment:
                                                                        PlaceholderAlignment
                                                                            .bottom,
                                                                    child: RotatedBox(
                                                                        quarterTurns: -2,
                                                                        child: Icon(
                                                                          Icons
                                                                              .arrow_drop_down_circle_outlined,
                                                                          color:
                                                                              Colors.white,
                                                                          size:
                                                                              14,
                                                                        ))),
                                                                TextSpan(
                                                                  text:
                                                                      'Top Up',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        10,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
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
                                                        color: Colors.white,
                                                        fontSize: 10),
                                                  ),
                                                  Text(
                                                    "$membership Member "
                                                        .toUpperCase(),
                                                    style: const TextStyle(
                                                        color: Color.fromRGBO(
                                                            114, 162, 138, 1),
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 10),
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
                                            : CustomSlider(
                                                value: _currentSliderValue,
                                                labels: labels,
                                                onChanged: (double value) {
                                                  setState(() {
                                                    // _currentSliderValue = value;
                                                  });
                                                },
                                              ),
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
}

class CustomThumbShape extends SliderComponentShape {
  final double _thumbSize = 20.0;
  final ImageProvider imageProvider;

  CustomThumbShape(this.imageProvider);

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(_thumbSize, _thumbSize);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final ImageConfiguration imageConfiguration = ImageConfiguration(
      size: Size(_thumbSize, _thumbSize),
    );

    imageProvider.resolve(imageConfiguration).addListener(
      ImageStreamListener(
        (ImageInfo info, bool synchronousCall) {
          final Paint paint = Paint()..filterQuality = FilterQuality.high;
          canvas.drawImageRect(
            info.image,
            Rect.fromLTRB(0, 0, info.image.width.toDouble(),
                info.image.height.toDouble()),
            Rect.fromCenter(
              center: center,
              width: _thumbSize,
              height: _thumbSize,
            ),
            paint,
          );
        },
      ),
    );
  }
}

class CustomSlider extends StatelessWidget {
  final double value;
  final List<String> labels;
  final ValueChanged<double> onChanged;

  const CustomSlider({
    super.key,
    required this.value,
    required this.labels,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    double min = double.parse(labels.first) - 1;
    double max = double.parse(labels.last) + 1;
    int divisions = (max - min).toInt();

    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: Colors.blue,
        inactiveTrackColor: Colors.blue.withOpacity(0.3),
        trackHeight: 4.0,
        thumbShape:
            CustomThumbShape(const AssetImage('assets/images/thumb.png')),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 28.0),
        tickMarkShape: const RoundSliderTickMarkShape(),
        activeTickMarkColor: Colors.blue,
        inactiveTickMarkColor: Colors.blue.withOpacity(0.7),
      ),
      child: Stack(
        children: [
          Slider(
            value: value,
            min: min,
            max: max,
            divisions: divisions,
            label: value.round().toString(),
            onChanged: onChanged,
          ),
          Positioned(
            left: 12.0,
            right: 12.0,
            bottom: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(labels.length, (index) {
                return Expanded(
                  child: Column(
                    children: [
                      Container(
                        width: 12.0,
                        height: 12.0,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        labels[index].toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
