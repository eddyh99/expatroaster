import 'dart:convert';

import 'package:expatroasters/utils/extensions.dart';
import 'package:expatroasters/utils/functions.dart';
import 'package:expatroasters/utils/globalvar.dart';
import 'package:expatroasters/widgets/backscreens/async_widget.dart';
import 'package:expatroasters/widgets/backscreens/bottomnav_widget.dart';
import 'package:expatroasters/widgets/backscreens/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  @override
  void initState() {
    super.initState();
    _asyncMethod();
  }

  Future _asyncMethod() async {
    var url = Uri.parse("$urlapi/v1/member/mobile/get_userdetail");
    var query = jsonDecode(await expatAPI(url, body))["message"];
    //printDebug(query);
    if (query != null) {
      setState(() {
        resultData = query;
      });
    }
    //printDebug(resultData);
  }

  Future logout() async {
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
          child: Center(
              child: Column(children: [
            Text("PROFILE", style: GoogleFonts.inter(color: Colors.white)),
            SizedBox(
              height: 3.h,
            ),
            SizedBox(
                width: 80.w,
                height: 40.h,
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
                              fit: BoxFit.cover,
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
                                        backgroundImage: (resultData[
                                                    "picture"] ==
                                                "")
                                            ? const AssetImage(
                                                    "assets/images/avatar.png")
                                                as ImageProvider
                                            : NetworkImage(
                                                resultData["picture"])),
                                SizedBox(
                                  height: 1.h,
                                ),
                                const AsyncTextWidget(
                                    pref: "logged", field: "nama"),
                                SizedBox(
                                  height: 3.h,
                                ),
                                const Text(
                                  "Expat Points",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10),
                                ),
                                Text(
                                  (resultData == null)
                                      ? "0"
                                      : formatter.format(
                                          int.parse(resultData["poin"])),
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
                                  height: 4.h,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: const Color.fromRGBO(
                                          114, 162, 138, 1),
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),
                                    child: const Align(
                                      alignment: Alignment.center,
                                      child: AsyncTextWidget(
                                          pref: "logged", field: "nama"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ))),
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
                      height: 6.h,
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
                                child: const Text("ABOUT EXPAT. ROASTERS",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                    textAlign: TextAlign.center),
                              )))),
                  SizedBox(
                      width: 100.w,
                      height: 6.h,
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
                                onTap: () => {},
                                child: const Text("POINTS HISTORY",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                    textAlign: TextAlign.center),
                              )))),
                  SizedBox(
                      width: 100.w,
                      height: 6.h,
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
                                child: const Text("BENEFIT",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                    textAlign: TextAlign.center),
                              )))),
                  SizedBox(
                      width: 100.w,
                      height: 6.h,
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
                                    {Get.toNamed("/front-screen/settings")},
                                child: const Text("SETTINGS",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                    textAlign: TextAlign.center),
                              )))),
                  SizedBox(
                      width: 100.w,
                      height: 6.h,
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
                                onTap: () async => {logout()},
                                child: const Text("LOGOUT",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                    textAlign: TextAlign.center),
                              )))),
                  SizedBox(
                    height: 5.h,
                  )
                ],
              ),
            )
          ])),
        ),
        bottomNavigationBar: const Expatnav(pos: 3));
  }
}
