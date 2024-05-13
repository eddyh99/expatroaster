import 'package:expatroasters/utils/extensions.dart';
import 'package:expatroasters/utils/functions.dart';
import 'package:expatroasters/utils/globalvar.dart';
import 'package:expatroasters/widgets/backscreens/button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class GetstartedView extends StatefulWidget {
  const GetstartedView({super.key});

  @override
  State<GetstartedView> createState() {
    return _GetstartedViewState();
  }
}

// Future<void> _launchInWebViewOrVC(Uri url) async {
//   if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
//     throw Exception('Could not launch $url');
//   }
// }

class _GetstartedViewState extends State<GetstartedView> {
  late Uri toLaunch;

  Future _asyncMethod() async {
    final prefs = await SharedPreferences.getInstance();
    var email = prefs.getString("email");
    var passwd = prefs.getString("passwd");
    var rememberme = prefs.getBool("_rememberme");

    if (rememberme == true) {
      showLoaderDialog(context);
      Map<String, dynamic> mdata;
      mdata = {'email': email, 'passwd': passwd};
      var url = Uri.parse("$urlapi/auth/signin");
      await expatAPI(url, jsonEncode(mdata)).then((ress) {
        var result = jsonDecode(ress);
        if (result["status"] == 200) {
          Navigator.pop(context);
          Get.toNamed("/front-screen/enterpin");
        } else {
          Navigator.pop(context);
          showAlert(result["messages"]["error"], context);
        }
      }).catchError(
        (err) {
          Navigator.pop(context);
          printDebug("100-$err");
          showAlert(
            "404 - Error, Please Contact Administrator",
            context,
          );
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();

    _asyncMethod();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50.h,
              child: Image.asset('assets/images/logo.png'),
            ),
            SizedBox(
                height: 45.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      child: ButtonWidget(
                          name: "btnPrimaryGoogle",
                          text: "Sign up with Google",
                          boxsize: '80',
                          onTap: () {
                            Get.toNamed("/front-screen/getstarted");
                          }),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    SizedBox(
                      child: ButtonWidget(
                          name: "btnSecondaryEmail",
                          text: "Sign up with E-mail",
                          boxsize: '80',
                          onTap: () {
                            Get.toNamed("/front-screen/register");
                          }),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Do you have already an account? ',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                          TextSpan(
                            text: 'Login!',
                            style: const TextStyle(
                                color: Color.fromRGBO(114, 162, 138, 1),
                                fontSize: 12),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.toNamed("/front-screen/signin");
                              },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    SizedBox(
                        width: 90.w,
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'By registering, you agree to our ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                              TextSpan(
                                text: "Terms of Use",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.toNamed("/front-screen/termcondition");
                                  },
                              ),
                              TextSpan(
                                text:
                                    ' Learn how we collect, use and share your data.',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ],
                          ),
                        )),
                    SizedBox(
                      height: 5.h,
                    )
                  ],
                ))
          ],
        )));
  }
}
