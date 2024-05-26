import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:expatroasters/utils/extensions.dart';
import 'package:expatroasters/utils/functions.dart';
import 'package:expatroasters/utils/globalvar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:pinput/pinput.dart';

class SettingNewPinView extends StatefulWidget {
  const SettingNewPinView({super.key});

  @override
  State<SettingNewPinView> createState() {
    return _SettingNewPinViewState();
  }
}

const List<String> gender = <String>['Male', 'Female'];

class _SettingNewPinViewState extends State<SettingNewPinView> {
  final GlobalKey<FormState> _settingFormKey = GlobalKey<FormState>();
  final TextEditingController pinController = TextEditingController();
  final focusNode = FocusNode();
  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  Future<dynamic> getPrefer() async {
    var data = await readPrefStr("logged");
    printDebug(data);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Get.toNamed("/front-screen/settings"),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _settingFormKey,
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
                      obscuringCharacter: "*",
                      obscureText: true,
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
                        showLoaderDialog(context);
                        if (!_settingFormKey.currentState!.validate()) {
                          Navigator.pop(context);
                        }

                        if (_settingFormKey.currentState!.validate()) {
                          Get.toNamed('front-screen/settingConfirmPin',
                              arguments: [
                                {
                                  "newpin": sha1
                                      .convert(utf8.encode(value))
                                      .toString()
                                }
                              ]);
                          // Map<String, dynamic> mdata;
                          // mdata = {
                          //   'pin': sha1.convert(utf8.encode(value)).toString(),
                          // };
                          // var url =
                          //     Uri.parse("$urlapi/v1/mobile/member/check_pin");
                          // await expatAPI(url, jsonEncode(mdata)).then(
                          //   (ress) {
                          //     var result = jsonDecode(ress);
                          //     printDebug(result);
                          //     if (result["status"] == 200) {
                          //       Navigator.pop(context);
                          //       Get.toNamed("/front-screen/home");
                          //     } else {
                          //       Navigator.pop(context);
                          //       showAlert(result["messages"]["error"], context);
                          //     }
                          //   },
                          // ).catchError(
                          //   (err) {
                          //     Navigator.pop(context);
                          //     printDebug("100-$err");
                          //     showAlert(
                          //       "404 - Error, Please Contact Administrator",
                          //       context,
                          //     );
                          //   },
                          // );
                        }
                        ;
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
