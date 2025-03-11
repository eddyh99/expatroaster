import 'package:expatroasters/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:expatroasters/utils/extensions.dart';
import 'package:expatroasters/utils/globalvar.dart';
import 'dart:convert';
import 'package:get/get.dart';

import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EnterpinView extends StatefulWidget {
  const EnterpinView({super.key});

  @override
  State<EnterpinView> createState() {
    return _EnterpinViewState();
  }
}

class _EnterpinViewState extends State<EnterpinView> {
  final GlobalKey<FormState> _enterpinFormKey = GlobalKey<FormState>();
  final TextEditingController pinController = TextEditingController();
  final focusNode = FocusNode();
  String phone = '';
  Future<dynamic> getPrefer() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var getphone = prefs.getString("phone") ?? "";
    phone = getphone;
  }

  @override
  void initState() {
    super.initState();
    getPrefer();
  }

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
          onPressed: () => Get.offAllNamed("/front-screen/signin"),
        ),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Form(
          key: _enterpinFormKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 5.h),
                Text(
                  "Enter Pin",
                  style: TextStyle(
                      color: const Color.fromRGBO(114, 162, 138, 1),
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
                  obscuringCharacter: "*",
                  obscureText: true,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  defaultPinTheme: PinTheme(
                    height: 50.0,
                    width: 50.0,
                    textStyle: const TextStyle(color: Colors.white),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.black,
                      border: Border.all(color: Colors.white),
                    ),
                  ),
                  hapticFeedbackType: HapticFeedbackType.lightImpact,
                  onCompleted: (value) async {
                    showLoaderDialog(context);
                    if (!_enterpinFormKey.currentState!.validate()) {
                      Navigator.pop(context);
                    }

                    if (_enterpinFormKey.currentState!.validate()) {
                      Map<String, dynamic> mdata;
                      mdata = {
                        'pin': sha1.convert(utf8.encode(value)).toString(),
                      };
                      var url = Uri.parse("$urlapi/v1/mobile/member/check_pin");
                      await expatAPI(url, jsonEncode(mdata)).then(
                        (ress) {
                          var result = jsonDecode(ress);
                          if (result["status"] == 200) {
                            Navigator.pop(context);
                            if (phone.isEmpty) {
                              Get.toNamed("/front-screen/settings");
                            } else {
                              Get.offAllNamed("/front-screen/home");
                            }
                          } else {
                            Navigator.pop(context);
                            showAlert(result["messages"]["error"], context);
                          }
                        },
                      ).catchError(
                        (err) {
                          Navigator.pop(context);
                          // printDebug("100-$err");
                          showAlert(
                            "404 - Error, Please Contact Administrator",
                            context,
                          );
                        },
                      );
                    }
                    ;
                  },
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
