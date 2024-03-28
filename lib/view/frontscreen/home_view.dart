import 'dart:convert';
import 'package:expatroasters/utils/extensions.dart';
import 'package:expatroasters/utils/functions.dart';
import 'package:expatroasters/utils/globalvar.dart';
import 'package:expatroasters/widgets/backscreens/async_widget.dart';
import 'package:expatroasters/widgets/backscreens/bottomnav_widget.dart';
import 'package:expatroasters/widgets/backscreens/order_widget.dart';
import 'package:expatroasters/widgets/backscreens/outlet_widget.dart';
import 'package:expatroasters/widgets/backscreens/promotion_widget.dart';
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
  //var localData = Get.arguments[0]["first"];
  dynamic resultData;
  String body = '';
  bool is_loading = true;

  Future _asyncMethod() async {
    //get user detail
    var url = Uri.parse("$urlapi/v1/member/get_userdetail");
    var query = jsonDecode(await expatAPI(url, body))["messages"];
    setState(() {
      resultData = query;
      is_loading = false;
    });
    //printDebug(localData);
    printDebug(const AsyncTextWidget(pref: "logged", field: "nama"));
  }

  void _readFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String value = prefs.getString('logged') ?? 'default value';
    print(value);
  }

  @override
  void initState() {
    super.initState();
    _readFromPreferences();
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
              child: Column(children: [
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
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.h),
                            child:
                                Image.asset("assets/images/icon_handshake.png"),
                          ),
                          SizedBox(
                              width: 100.w,
                              height: 20.h,
                              child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(30, 30, 30, 1),
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 2.h, horizontal: 2.h),
                                    child: Row(
                                      children: [
                                        const Expanded(
                                          flex: 5,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Hi",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              AsyncTextWidget(
                                                  pref: "logged",
                                                  field: "nama"),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                "Total Saldo",
                                                style: GoogleFonts.inter(
                                                    color: Colors.white,
                                                    fontSize: 9),
                                              ),
                                              RichText(
                                                text: TextSpan(children: [
                                                  WidgetSpan(
                                                    child: Transform.translate(
                                                      offset:
                                                          const Offset(2, -6),
                                                      child: const Text(
                                                        'Rp',
                                                        //superscript is usually smaller in size
                                                        textScaleFactor: 0.5,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                  WidgetSpan(
                                                    child: SizedBox(width: 1.w),
                                                  ),
                                                  TextSpan(
                                                      text: (resultData == null)
                                                          ? "0"
                                                          : formatter.format(int
                                                              .parse(resultData[
                                                                  "saldo"])),
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16)),
                                                ]),
                                              ),
                                              SizedBox(
                                                height: 1.5.h,
                                              ),
                                              Text(
                                                "Expat Points",
                                                style: GoogleFonts.inter(
                                                    color: Colors.white,
                                                    fontSize: 9),
                                              ),
                                              RichText(
                                                text: TextSpan(
                                                  text: (resultData == null)
                                                      ? "0"
                                                      : formatter.format(
                                                          int.parse(resultData[
                                                              "poin"])),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16),
                                                  children: const [
                                                    TextSpan(text: ' Points'),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 1.5.h,
                                              ),
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
                                                  textAlign: TextAlign.center,
                                                  text: const TextSpan(
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
                                                                color: Colors
                                                                    .white,
                                                                size: 16,
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
                                        )
                                      ],
                                    ),
                                  )))
                        ],
                      ),
                    )
                  ],
                ),
              ])),
          Padding(
              padding: EdgeInsets.only(top: 2.h), child: const OutletView()),
          SizedBox(height: 2.h),
          Padding(padding: EdgeInsets.only(top: 2.h), child: const OrderView()),
          SizedBox(height: 2.h),
          Padding(
              padding: EdgeInsets.only(top: 2.h), child: const PromotionView()),
          SizedBox(
            height: 5.h,
          )
        ]))),
        bottomNavigationBar: const Expatnav());
  }
}
