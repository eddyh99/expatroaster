import 'dart:convert';

import 'package:expatroasters/utils/extensions.dart';
import 'package:expatroasters/utils/functions.dart';
import 'package:expatroasters/utils/globalvar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfirmationView extends StatefulWidget {
  const ConfirmationView({super.key});

  @override
  State<ConfirmationView> createState() {
    return _ConfirmationViewState();
  }
}

class _ConfirmationViewState extends State<ConfirmationView> {
  var email = Get.arguments[0];
  var password = Get.arguments[1];
  final GlobalKey<FormState> _confirmFormKey = GlobalKey<FormState>();
  final TextEditingController pinController = TextEditingController();
  final focusNode = FocusNode();

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

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
        child: SingleChildScrollView(
          child: Form(
            key: _confirmFormKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Please Check Your Email",
                        style: GoogleFonts.lora(
                            color: const Color.fromRGBO(114, 162, 138, 1),
                            fontSize: 24)),
                    Text("We've sent a code to $email",
                        style: GoogleFonts.lora(
                            color: Colors.white, fontSize: 12)),
                    SizedBox(
                      height: 3.h,
                    ),
                    Pinput(
                      controller: pinController,
                      focusNode: focusNode,
                      length: 4,
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
                        if (_confirmFormKey.currentState!.validate()) {
                          var url =
                              Uri.parse("$urlapi/auth/activate?token=$value");
                          var result = jsonDecode(await expatAPI(url, ""));
                          if (result["status"] == 200) {
                            Map<String, dynamic> mdata;
                            mdata = {
                              'email': email,
                              'passwd': password,
                              'is_google': 'no'
                            };
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            var url = Uri.parse("$urlapi/auth/signin");
                            await expatAPI(url, jsonEncode(mdata)).then((ress) {
                              var result = jsonDecode(ress);
                              print(result);
                              if (result['status'] == 200) {
                                prefs.setString("email", email);
                                prefs.setString("passwd", password);
                                prefs.setBool("_rememberme", false);
                                prefs.setString("id", result["messages"]["id"]);
                                prefs.setString(
                                    "nama", result["messages"]["nama"]);
                                prefs.setString(
                                    "memberid", result["messages"]["memberid"]);
                                prefs.setString(
                                    "role", result["messages"]["role"]);
                                prefs.setString(
                                    "pin", result["messages"]["pin"]);
                                prefs.setString(
                                    "plafon", result["messages"]["plafon"]);
                                prefs.setString("is_google", "no");
                                Get.toNamed("/front-screen/createpin");
                              } else {
                                var psnerr = result['messages']['error'];
                                Navigator.pop(context);
                                showAlert(psnerr, context);
                              }
                            }).catchError((err) {
                              Navigator.pop(context);
                              printDebug("100-$err");
                              showAlert(
                                "100 - Something Wrong, Please Contact Administrator",
                                context,
                              );
                            });
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
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
