import 'dart:async';
import 'dart:convert';
import 'package:expatroasters/utils/extensions.dart';
import 'package:expatroasters/utils/functions.dart';
import 'package:expatroasters/utils/globalvar.dart';
import 'package:expatroasters/widgets/backscreens/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:intl/intl.dart';

class EnterotpView extends StatefulWidget {
  const EnterotpView({super.key});

  @override
  State<EnterotpView> createState() {
    return _EnterotpViewState();
  }
}

class _EnterotpViewState extends State<EnterotpView> {
  final GlobalKey<FormState> _otpFormKey = GlobalKey<FormState>();
  final TextEditingController otpController = TextEditingController();
  late WebViewController wvcontroller;
  final focusNode = FocusNode();
  var email = Get.arguments[0]["email"];
  String newotp = '';

  Timer? _timer;
  int _start = 60;
  final NumberFormat formatter = NumberFormat('00'); // Initialize the formatter

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    otpController.dispose();
    focusNode.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.toNamed("/front-screen/signin"),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _otpFormKey,
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    width: 90.w,
                    child: Column(
                      children: [
                        SizedBox(
                          width: 100.w,
                          child: Text(
                            "Please check your email",
                            style: TextStyle(
                                color: Color.fromRGBO(114, 162, 138, 1),
                                fontSize: 36,
                                fontFamily: GoogleFonts.lora().fontFamily,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                        SizedBox(
                          width: 100.w,
                          child: Text(
                            "We’ve sent a code to $email",
                            style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontSize: 12,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        SizedBox(
                          width: 90.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 1.h),
                              Pinput(
                                controller: otpController,
                                focusNode: focusNode,
                                length: 4,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                defaultPinTheme: PinTheme(
                                  height: 50.0,
                                  width: 50.0,
                                  textStyle: TextStyle(color: Colors.white),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.black,
                                    border: Border.all(color: Colors.white),
                                  ),
                                ),
                                onCompleted: (value) async {
                                  setState(() {
                                    newotp = value;
                                  });
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  SizedBox(
                    child: ButtonWidget(
                      name: 'btnPrimaryLight',
                      text: 'Verify',
                      boxsize: '90',
                      onTap: () async {
                        String body = '';
                        var url =
                            Uri.parse("$urlapi/auth/cekToken?token=$newotp");
                        await expatAPI(url, body).then((ress) {
                          var result = jsonDecode(ress);
                          var psnerr = result['messages']['error'];
                          if (result['status'] == 200) {
                            Get.toNamed(
                              "/front-screen/password_forgot",
                              arguments: [
                                {
                                  "currentpass": result['messages']['passwd'],
                                  "userid": result['messages']['id'],
                                }
                              ],
                            );
                          } else {
                            showAlert(psnerr, context);
                          }
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  SizedBox(
                    height: 3.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Send Code Again ? ",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        (_start == 0)
                            ? GestureDetector(
                                onTap: () {
                                  wvcontroller = WebViewController();
                                  wvcontroller.loadRequest(
                                    Uri.parse(
                                        "$urlbase/auth/send_email/${Uri.encodeComponent(email)}"),
                                  );
                                  setState(() {
                                    _start = 60;
                                    startTimer();
                                  });
                                },
                                child: Text(
                                  "Resend",
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 12),
                                ),
                              )
                            : Text(
                                "00:${formatter.format(_start)}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
