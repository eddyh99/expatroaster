import 'package:expatroasters/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:expatroasters/utils/extensions.dart';
import 'package:expatroasters/utils/globalvar.dart';
import 'package:expatroasters/utils/functions.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:get/get.dart';

import 'package:crypto/crypto.dart';

class PinView extends StatefulWidget {
  const PinView({super.key});

  @override
  State<PinView> createState() {
    return _PinViewState();
  }
}

class _PinViewState extends State<PinView> {
  final GlobalKey<FormState> _createpinFormKey = GlobalKey<FormState>();
  final TextEditingController pinController = TextEditingController();
  final focusNode = FocusNode();
  String newpin = '';

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Form(
          key: _createpinFormKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 5.h),
                Text(
                  "Create New Pin",
                  style: TextStyle(
                      color: Color.fromRGBO(114, 162, 138, 1),
                      fontSize: 36,
                      fontFamily: GoogleFonts.lora().fontFamily,
                      fontWeight: FontWeight.w700),
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 10.h),
                Pinput(
                  controller: pinController,
                  focusNode: focusNode,
                  length: 6,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  hapticFeedbackType: HapticFeedbackType.lightImpact,
                  onCompleted: (value) async {
                    setState(() {
                      newpin = value;
                    });
                  },
                ),
                SizedBox(height: 10.h),
                Center(
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
                      child: Text("SAVE PIN"),
                      onPressed: () async {
                        // showLoaderDialog(context);
                        if (!_createpinFormKey.currentState!.validate()) {
                          Navigator.pop(context);
                        }

                        if (_createpinFormKey.currentState!.validate()) {
                          Map<String, dynamic> mdata;
                          mdata = {
                            'pin': sha1.convert(utf8.encode(newpin)).toString(),
                          };

                          var url =
                              Uri.parse("$urlapi/v1/mobile/member/update_pin");
                          await expatAPI(url, jsonEncode(mdata)).then(
                            (ress) {
                              var result = jsonDecode(ress);
                              printDebug(result);
                              if (result["status"] == 200) {
                                Navigator.pop(context);
                                showAlert(result["messages"], context);
                                Get.toNamed("/front-screen/signin");
                                printDebug(result["messages"]);
                              } else {
                                Navigator.pop(context);
                                showAlert(result["messages"]["error"], context);
                              }
                              // printDebug(ress);
                            },
                          ).catchError(
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
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
