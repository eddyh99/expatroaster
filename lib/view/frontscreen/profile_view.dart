import 'dart:convert';

import 'package:expatroasters/utils/extensions.dart';
import 'package:expatroasters/utils/functions.dart';
import 'package:expatroasters/utils/globalvar.dart';
import 'package:expatroasters/widgets/backscreens/Iconsosmed_widget.dart';
import 'package:expatroasters/widgets/backscreens/bottomnav_widget.dart';
import 'package:expatroasters/widgets/backscreens/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() {
    return _ProfileViewState();
  }
}

class _ProfileViewState extends State<ProfileView> {
  dynamic resultData;
  String body = '';
  String token = '';
  String nama = '';
  String membership = '';
  bool isLoadingPref = true;
  late final WebViewController wvcontroller;

  @override
  void initState() {
    super.initState();
    _asyncMethod();
    getPrefer();
    // _loadAllPreferences();
  }

  Future<void> _launchInWebViewOrVC(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<dynamic> getPrefer() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var getNama = prefs.getString("nama");
    nama = getNama!;
    var getMembership = prefs.getString("membership");
    membership = getMembership!;
    setState(() {
      isLoadingPref = false;
    });
  }

  Future _asyncMethod() async {
    var url = Uri.parse("$urlapi/v1/mobile/member/get_userdetail");
    var query = jsonDecode(await expatAPI(url, body))["messages"];
    print(query);
    if (query != null) {
      setState(() {
        resultData = query;
        bearerToken().then(
          (value) => {
            setState(() {
              print(value);
            })
          },
        );
      });
    }
  }

  Future logout() async {
    wvcontroller = WebViewController();
    wvcontroller.loadRequest(Uri.parse("$urlbase/widget/order/removecookie"));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Get.toNamed("/front-screen/signin");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
                child: Column(children: [
              Text("PROFILE", style: GoogleFonts.inter(color: Colors.white)),
              SizedBox(
                height: 3.h,
              ),
              SizedBox(
                width: 80.w,
                height: 43.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20), // Image border
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(48), // Image radius
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        image: DecorationImage(
                          image: AssetImage(
                              "assets/images/background-profile.png"),
                          fit: BoxFit.contain,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 3.h),
                        child: Column(
                          children: [
                            (resultData == null)
                                ? const ShimmerWidget(tinggi: 60, lebar: 60)
                                : CircleAvatar(
                                    radius: 30, // Image radius
                                    backgroundColor: Colors.white,
                                    backgroundImage: (resultData["picture"] ==
                                                null &&
                                            resultData["gender"] == "male")
                                        ? const AssetImage(
                                                "assets/images/men-default.png")
                                            as ImageProvider
                                        : (resultData["picture"] == null &&
                                                resultData["gender"] ==
                                                    "female")
                                            ? const AssetImage(
                                                    "assets/images/women-default.png")
                                                as ImageProvider
                                            : NetworkImage(
                                                resultData["picture"],
                                              ),
                                  ),
                            SizedBox(
                              height: 2.h,
                            ),
                            (isLoadingPref)
                                ? ShimmerWidget(tinggi: 2.h, lebar: 20.w)
                                : Text(
                                    nama,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Text(
                              "EXPAT. ROASTERS POINTS".toUpperCase(),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 10),
                            ),
                            Text(
                              (resultData == null || resultData['poin'] == null)
                                  ? "0"
                                  : formatter
                                      .format(int.parse(resultData["poin"])),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 40),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            SizedBox(
                              width: 70.w,
                              height: 6.h,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(114, 162, 138, 1),
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                child: Center(
                                  child: Text(
                                    membership.toUpperCase(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.w, right: 10.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100.w,
                      height: 8.h,
                      child: DecoratedBox(
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              //
                              color: Colors.white,
                              width: 1.0,
                            ),
                            bottom: BorderSide(
                              //
                              color: Colors.white,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed("/front-screen/about");
                            },
                            child: const Text("ABOUT",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                                textAlign: TextAlign.center),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 100.w,
                      height: 8.h,
                      child: DecoratedBox(
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              //
                              color: Colors.white,
                              width: 1.0,
                            ),
                            bottom: BorderSide(
                              //
                              color: Colors.white,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed("/front-screen/history");
                            },
                            child: const Text("HISTORY",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                                textAlign: TextAlign.center),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 100.w,
                      height: 8.h,
                      child: DecoratedBox(
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              //
                              color: Colors.white,
                              width: 1.0,
                            ),
                            bottom: BorderSide(
                              //
                              color: Colors.white,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed("/front-screen/benefit");
                            },
                            child: const Text("BENEFITS",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                                textAlign: TextAlign.center),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 100.w,
                      height: 8.h,
                      child: DecoratedBox(
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            ),
                            bottom: BorderSide(
                              //
                              color: Colors.white,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed("/front-screen/profile");
                            },
                            child: const Text("CONTACT US",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                                textAlign: TextAlign.center),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 100.w,
                      height: 8.h,
                      child: DecoratedBox(
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              //
                              color: Colors.white,
                              width: 1.0,
                            ),
                            bottom: BorderSide(
                              //
                              color: Colors.white,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () =>
                                {Get.toNamed("/front-screen/pilihSettings")},
                            child: const Text("SETTINGS",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                                textAlign: TextAlign.center),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    SizedBox(
                      height: 5.h,
                      child: IconsosmedWidget(),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                  ],
                ),
              )
            ])),
          ),
        ),
        bottomNavigationBar: const Expatnav(
          number: 3,
        ));
  }
}
