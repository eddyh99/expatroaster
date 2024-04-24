import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:expatroasters/utils/extensions.dart';
import 'package:expatroasters/utils/functions.dart';
import 'package:expatroasters/utils/globalvar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PinView extends StatefulWidget {
  const PinView({super.key});

  @override
  State<PinView> createState() {
    return _PinViewState();
  }
}

class _PinViewState extends State<PinView> {
  final GlobalKey<FormState> _confirmFormKey = GlobalKey<FormState>();
  final TextEditingController pin1 = TextEditingController();
  final TextEditingController pin2 = TextEditingController();
  final TextEditingController pin3 = TextEditingController();
  final TextEditingController pin4 = TextEditingController();
  final TextEditingController pin5 = TextEditingController();
  final TextEditingController pin6 = TextEditingController();

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
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Create New PIN",
                      style: GoogleFonts.lora(
                          color: const Color.fromRGBO(114, 162, 138, 1),
                          fontSize: 18)),
                  SizedBox(
                    height: 3.h,
                  ),
                  Form(
                    key: _confirmFormKey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: 12.w,
                            height: 12.h,
                            child: TextFormField(
                              style: const TextStyle(color: Colors.white),
                              controller: pin1,
                              maxLines: 1,
                              maxLength: 1,
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () =>
                                  FocusScope.of(context).nextFocus(),
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
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 0.0),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your PIN";
                                }
                                return null;
                              },
                            )),
                        SizedBox(
                          width: 2.w,
                        ),
                        SizedBox(
                            width: 12.w,
                            height: 12.h,
                            child: TextFormField(
                              style: const TextStyle(color: Colors.white),
                              controller: pin2,
                              maxLines: 1,
                              maxLength: 1,
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () =>
                                  FocusScope.of(context).nextFocus(),
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
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 0.0),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your PIN";
                                }
                                return null;
                              },
                            )),
                        SizedBox(
                          width: 2.w,
                        ),
                        SizedBox(
                            width: 12.w,
                            height: 12.h,
                            child: TextFormField(
                              style: const TextStyle(color: Colors.white),
                              controller: pin3,
                              maxLines: 1,
                              maxLength: 1,
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () =>
                                  FocusScope.of(context).nextFocus(),
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
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 0.0),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your PIN";
                                }
                                return null;
                              },
                            )),
                        SizedBox(
                          width: 2.w,
                        ),
                        SizedBox(
                            width: 12.w,
                            height: 12.h,
                            child: TextFormField(
                              style: const TextStyle(color: Colors.white),
                              controller: pin4,
                              maxLines: 1,
                              maxLength: 1,
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () =>
                                  FocusScope.of(context).nextFocus(),
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
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 0.0),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your PIN";
                                }
                                return null;
                              },
                            )),
                        SizedBox(
                          width: 2.w,
                        ),
                        SizedBox(
                            width: 12.w,
                            height: 12.h,
                            child: TextFormField(
                              style: const TextStyle(color: Colors.white),
                              controller: pin5,
                              maxLines: 1,
                              maxLength: 1,
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () =>
                                  FocusScope.of(context).nextFocus(),
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
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 0.0),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your PIN";
                                }
                                return null;
                              },
                            )),
                        SizedBox(
                          width: 2.w,
                        ),
                        SizedBox(
                            width: 12.w,
                            height: 12.h,
                            child: TextFormField(
                              style: const TextStyle(color: Colors.white),
                              controller: pin6,
                              maxLines: 1,
                              maxLength: 1,
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () =>
                                  FocusScope.of(context).nextFocus(),
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
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 0.0),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your PIN";
                                }
                                return null;
                              },
                            )),
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 5.w),
                      child: SizedBox(
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
                                Map<String, dynamic> mdata;
                                mdata = {
                                  'pin': sha1
                                      .convert(utf8.encode(pin1.text +
                                          pin2.text +
                                          pin3.text +
                                          pin4.text +
                                          pin5.text +
                                          pin6.text))
                                      .toString(),
                                };
                                var url = Uri.parse(
                                    "$urlapi/v1/mobile/member/update_pin");
                                var result = jsonDecode(
                                    await expatAPI(url, jsonEncode(mdata)));
                                if (result["status"] == 200) {
                                  if (context.mounted) {
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text(
                                        "Your PIN has been successfully created, please relogin again",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      backgroundColor:
                                          Color.fromRGBO(114, 162, 138, 1),
                                    ));
                                    _confirmFormKey.currentState?.reset();
                                    SharedPreferences preferences =
                                        await SharedPreferences.getInstance();
                                    await preferences.clear();
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
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      backgroundColor: const Color.fromRGBO(
                                          114, 162, 138, 1),
                                    ));
                                  }
                                }
                              }
                            },
                            child: const Text(
                              "Create PIN",
                              style: TextStyle(color: Colors.white),
                            ),
                          )))
                ],
              ))),
    );
  }
}
