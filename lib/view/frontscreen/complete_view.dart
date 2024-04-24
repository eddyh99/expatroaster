import 'package:expatroasters/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CompleteView extends StatefulWidget {
  const CompleteView({super.key});

  @override
  State<CompleteView> createState() {
    return _CompleteViewState();
  }
}

class _CompleteViewState extends State<CompleteView> {
  var localData = Get.arguments[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Center(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Confirm your email address",
                          style: GoogleFonts.lora(
                              color: const Color.fromRGBO(114, 162, 138, 1),
                              fontSize: 24)),
                      SizedBox(
                        height: 3.h,
                      ),
                      SizedBox(
                          width: 100.w,
                          child: const DecoratedBox(
                              decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                //
                                color: Colors.white,
                                width: 1.0,
                              ),
                            ),
                          ))),
                      SizedBox(
                        height: 3.h,
                      ),
                      SizedBox(
                          width: 90.w,
                          child: Column(
                            children: [
                              const Text("We sent a confirmation email to:",
                                  style: TextStyle(color: Colors.white)),
                              SizedBox(height: 2.h),
                              Text(localData,
                                  style: const TextStyle(color: Colors.white)),
                              SizedBox(height: 2.h),
                              const Text(
                                "Check your inbox/spam folder and click on the confirmation link to continue.",
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          )),
                      SizedBox(
                        height: 5.h,
                      ),
                      SizedBox(
                        width: 60.w,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromRGBO(114, 162, 138, 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                )),
                            onPressed: () async {
                              Get.toNamed("/front-screen/confirm",
                                  arguments: [localData]);
                            },
                            child: const Text(
                              "CONFIRMATION CODE",
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    ],
                  )))),
    );
  }
}
