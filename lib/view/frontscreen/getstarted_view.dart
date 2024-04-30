import 'package:expatroasters/utils/extensions.dart';
import 'package:expatroasters/utils/functions.dart';
import 'package:expatroasters/utils/globalvar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

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
    print(rememberme);
    if (rememberme == true) {
      showLoaderDialog(context);
      Map<String, dynamic> mdata;
      mdata = {'email': email, 'passwd': passwd};
      var url = Uri.parse("$urlapi/auth/signin");
      await expatAPI(url, jsonEncode(mdata)).then((ress) {
        var result = jsonDecode(ress);
        printDebug("MASUK THEN $result");
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
      // printDebug(result);
      // if (result["status"] == 200) {
      //   Get.toNamed("/front-screen/home");
      // } else {
      //   var psnerror = result["message"];
      //   if (context.mounted) {
      //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //       content: Text(psnerror),
      //       backgroundColor: Colors.deepOrange,
      //     ));
      //     Get.toNamed("/front-screen/signin");
      //   }
      // }
    }
  }

  @override
  void initState() {
    super.initState();
    _asyncMethod();
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
                      width: 90.w,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(114, 162, 138, 1),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            )),
                        onPressed: () {
                          Get.toNamed("/front-screen/getstarted");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/icon_google.png'),
                            SizedBox(
                              width: 2.w,
                            ),
                            const Text("Sign up with Google")
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    SizedBox(
                      width: 90.w,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(25, 25, 25, 1),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            )),
                        onPressed: () {
                          Get.toNamed("/front-screen/register");
                        },
                        child: const Text("Sign up with E-mail"),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Do you have already an account? ',
                            style: TextStyle(color: Colors.white, fontSize: 10),
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
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: 'By registering, you agree to ',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              ),
                              // TextSpan(
                              //   text: 'our Terms of Use.',
                              //   style: const TextStyle(
                              //       color: Colors.blue, fontSize: 10),
                              //   recognizer: TapGestureRecognizer()
                              //     ..onTap = () {
                              //       _launchInWebViewOrVC(Uri.parse(
                              //           'https://en.wikipedia.org/wiki/Terms_of_service'));
                              //     },
                              // ),
                              const TextSpan(
                                text:
                                    ' Learn how we collect, use and share your data.',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
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
