import 'dart:convert';

import 'package:expatroasters/utils/extensions.dart';
import 'package:expatroasters/utils/functions.dart';
import 'package:expatroasters/utils/globalvar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfirmationView extends StatefulWidget {
  const ConfirmationView({super.key});

  @override
  State<ConfirmationView> createState() {
    return _ConfirmationViewState();
  }
}

class _ConfirmationViewState extends State<ConfirmationView> {
  var localData = Get.arguments[0];
  final GlobalKey<FormState> _confirmFormKey = GlobalKey<FormState>();
  final TextEditingController otp1 = TextEditingController();
  final TextEditingController otp2 = TextEditingController();
  final TextEditingController otp3 = TextEditingController();
  final TextEditingController otp4 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.toNamed("/front-screen/signin"),
        ),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Please Check Your Email",
                      style: GoogleFonts.lora(
                          color: const Color.fromRGBO(114, 162, 138, 1),
                          fontSize: 24)),
                  Text("We've sent a code to $localData",
                      style:
                          GoogleFonts.lora(color: Colors.white, fontSize: 12)),
                  SizedBox(
                    height: 3.h,
                  ),
                  Form(
                    key: _confirmFormKey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: 15.w,
                            height: 15.h,
                            child: TextFormField(
                              style: const TextStyle(color: Colors.white),
                              controller: otp1,
                              maxLines: 1,
                              maxLength: 1,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                isDense: true,
                                counterText: "",
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 0.0,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 0.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 0.0),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 0.0),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your OTP";
                                }
                                return null;
                              },
                            )),
                        SizedBox(
                          width: 2.w,
                        ),
                        SizedBox(
                            width: 15.w,
                            height: 15.h,
                            child: TextFormField(
                              style: const TextStyle(color: Colors.white),
                              controller: otp2,
                              maxLines: 1,
                              maxLength: 1,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                isDense: true,
                                counterText: "",
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 0.0,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 0.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 0.0),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 0.0),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your OTP";
                                }
                                return null;
                              },
                            )),
                        SizedBox(
                          width: 2.w,
                        ),
                        SizedBox(
                            width: 15.w,
                            height: 15.h,
                            child: TextFormField(
                              style: const TextStyle(color: Colors.white),
                              controller: otp3,
                              maxLines: 1,
                              maxLength: 1,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                isDense: true,
                                counterText: "",
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 0.0,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 0.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 0.0),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 0.0),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your OTP";
                                }
                                return null;
                              },
                            )),
                        SizedBox(
                          width: 2.w,
                        ),
                        SizedBox(
                            width: 15.w,
                            height: 15.h,
                            child: TextFormField(
                              style: const TextStyle(color: Colors.white),
                              controller: otp4,
                              maxLines: 1,
                              maxLength: 1,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                isDense: true,
                                counterText: "",
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 0.0,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 0.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 0.0),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 0.0),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your OTP";
                                }
                                return null;
                              },
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                      width: 80.w,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(114, 162, 138, 1),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            )),
                        onPressed: () async {
                          showLoaderDialog(context);
                          // printDebug(context.mounted);
                          if (!_confirmFormKey.currentState!.validate()) {
                            Navigator.pop(context);
                          }

                          if (_confirmFormKey.currentState!.validate()) {
                            var url = Uri.parse(
                                "$urlapi/auth/activate?token=${otp1.text}${otp2.text}${otp3.text}${otp4.text}");
                            var result = jsonDecode(await expatAPI(url, ""));
                            if (result["status"] == 200) {
                              if (context.mounted) {
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                    result["messages"],
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor:
                                      const Color.fromRGBO(114, 162, 138, 1),
                                ));
                                _confirmFormKey.currentState?.reset();
                                Get.toNamed("/front-screen/signin");
                              }
                            } else {
                              var psnerror = result["messages"]["error"];
                              if (context.mounted) {
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                    psnerror,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor:
                                      const Color.fromRGBO(114, 162, 138, 1),
                                ));
                              }
                            }
                          }
                        },
                        child: const Text(
                          "Verify",
                          style: TextStyle(color: Colors.white),
                        ),
                      ))
                ],
              ))),
    );
  }
}
