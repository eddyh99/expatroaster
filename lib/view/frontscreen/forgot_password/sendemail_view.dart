import 'package:expatroasters/utils/extensions.dart';
import 'package:expatroasters/utils/globalvar.dart';
import 'package:expatroasters/widgets/backscreens/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SendemailView extends StatefulWidget {
  const SendemailView({super.key});

  @override
  State<SendemailView> createState() {
    return _SendemailViewState();
  }
}

class _SendemailViewState extends State<SendemailView> {
  final GlobalKey<FormState> _settingFormKey = GlobalKey<FormState>();
  final TextEditingController _emailTextController = TextEditingController();
  late final WebViewController wvcontroller;

  @override
  void initState() {
    super.initState();
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
            key: _settingFormKey,
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
                            "Forgot password?",
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
                            "Don’t worry! It happens. Please enter the email associated with your account.",
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
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 0.5.h),
                                child: const Text(
                                  "Email address",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ),
                              SizedBox(height: 1.h),
                              TextFormField(
                                controller: _emailTextController,
                                maxLines: 1,
                                keyboardType: TextInputType.text,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  isDense: true,
                                  prefixIconColor: Colors.white,
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                      width: 0.0,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                      width: 0.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 0.0),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 0.0),
                                  ),
                                  contentPadding: const EdgeInsets.only(
                                      left: 20, bottom: 15, right: 13, top: 15),
                                  hintStyle: TextStyle(
                                      fontSize: 12,
                                      color: Color.fromRGBO(163, 163, 163, 1)),
                                  hintText: 'Enter your email address',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter email address";
                                  }
                                  return null;
                                },
                              ),
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
                      text: 'Send Code',
                      boxsize: '90',
                      onTap: () async {
                        dynamic email = _emailTextController.text;
                        wvcontroller = WebViewController();
                        wvcontroller.loadRequest(
                          Uri.parse(
                              "$urlbase/auth/send_email/${Uri.encodeComponent(email)}"),
                        );
                        Get.toNamed(
                          "/front-screen/enterotp_forgot",
                          arguments: [
                            {"email": email}
                          ],
                        );

                        // showLoaderDialog(context);
                        // if (!_settingFormKey.currentState!.validate()) {
                        //   Navigator.pop(context);
                        // }

                        // if (_settingFormKey.currentState!.validate()) {
                        //   String body = '';
                        //   var url =
                        //       Uri.parse("$urlapi/auth/get_resettoken?email=");
                        //   jsonDecode(await expatAPI(url, body))["messages"];
                        // }
                      },
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
