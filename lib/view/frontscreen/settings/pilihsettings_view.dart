import 'package:expatroasters/utils/extensions.dart';
import 'package:expatroasters/utils/globalvar.dart';
import 'package:expatroasters/utils/google_login.dart';
import 'package:expatroasters/widgets/backscreens/bottomnav_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class PilihSettingsView extends StatefulWidget {
  const PilihSettingsView({super.key});

  @override
  State<PilihSettingsView> createState() {
    return _PilihSettingsViewState();
  }
}

class _PilihSettingsViewState extends State<PilihSettingsView> {
  dynamic resultData;
  bool isLoadingPref = true;
  late final WebViewController wvcontroller;

  Future<void> _launchInWebViewOrVC(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  Future logout() async {
    wvcontroller = WebViewController();
    wvcontroller.loadRequest(Uri.parse("$urlbase/widget/order/removecookie"));
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var isGoogle = prefs.getString("is_google");
    if (isGoogle == 'yes') {
      await GoogleLogin.logout();
    }
    await prefs.clear();
    Get.toNamed("/front-screen/signin");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Get.toNamed("/front-screen/profile"),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: const Text(
                "SETTINGS",
                style: TextStyle(color: Colors.white, fontSize: 18),
              )),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
                child: Column(children: [
              SizedBox(
                height: 3.h,
              ),
              SizedBox(
                height: 5.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100.w,
                      height: 8.h,
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed("/front-screen/settings");
                        },
                        child: DecoratedBox(
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                //
                                color: Colors.white,
                                width: 1.0,
                              ),
                            ),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("ACCOUNT",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w800,
                                        ),
                                        textAlign: TextAlign.center),
                                    Text(
                                        "Profile, password, and account security ",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w100),
                                        textAlign: TextAlign.center),
                                  ],
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.arrow_right,
                                      color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 100.w,
                      height: 8.h,
                      child: GestureDetector(
                        onTap: () {
                          _launchInWebViewOrVC(Uri.parse(
                              'https://mobile.expatroasters.com/faq.html'));
                        },
                        child: DecoratedBox(
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                //
                                color: Colors.white,
                                width: 1.0,
                              ),
                            ),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("FAQ",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w800,
                                        ),
                                        textAlign: TextAlign.center),
                                  ],
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.arrow_right,
                                      color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 100.w,
                      height: 8.h,
                      child: GestureDetector(
                        onTap: () {
                          _launchInWebViewOrVC(Uri.parse(
                              'https://mobile.expatroasters.com/privacy_policy.html'));
                        },
                        child: DecoratedBox(
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                //
                                color: Colors.white,
                                width: 1.0,
                              ),
                            ),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("PRIVACY POLICY",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w800,
                                        ),
                                        textAlign: TextAlign.center),
                                  ],
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.arrow_right,
                                      color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 100.w,
                      height: 8.h,
                      child: GestureDetector(
                        onTap: () {
                          _launchInWebViewOrVC(Uri.parse(
                              'https://mobile.expatroasters.com/term_condition.html'));
                        },
                        child: DecoratedBox(
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                //
                                color: Colors.white,
                                width: 1.0,
                              ),
                            ),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("TERMS & CONDITIONS",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w800,
                                        ),
                                        textAlign: TextAlign.center),
                                  ],
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.arrow_right,
                                      color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 100.w,
                      height: 8.h,
                      child: GestureDetector(
                        onTap: () async {
                          logout();
                        },
                        child: DecoratedBox(
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                //
                                color: Colors.white,
                                width: 1.0,
                              ),
                            ),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("SIGN OUT",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w800,
                                        ),
                                        textAlign: TextAlign.center),
                                  ],
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.arrow_right,
                                      color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
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
