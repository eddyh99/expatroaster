import 'package:expatroaster/utils/extensions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class GetstartedView extends StatefulWidget {
  const GetstartedView({Key? key}) : super(key: key);

  @override
  State<GetstartedView> createState() {
    return _GetstartedViewState();
  }
}

Future<void> _launchInWebViewOrVC(Uri url) async {
  if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
    throw Exception('Could not launch $url');
  }
}

class _GetstartedViewState extends State<GetstartedView> {
  late Uri toLaunch;

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
                              TextSpan(
                                text: 'our Terms of Use.',
                                style: const TextStyle(
                                    color: Colors.blue, fontSize: 10),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    _launchInWebViewOrVC(Uri.parse(
                                        'https://en.wikipedia.org/wiki/Terms_of_service'));
                                  },
                              ),
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
