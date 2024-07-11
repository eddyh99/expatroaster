import 'dart:convert';

import 'package:expatroasters/utils/extensions.dart';
import 'package:expatroasters/utils/functions.dart';
import 'package:expatroasters/utils/globalvar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

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
                    Text("We've sent a code to $localData",
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
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
