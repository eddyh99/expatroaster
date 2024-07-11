import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:expatroasters/utils/extensions.dart';
import 'package:expatroasters/utils/functions.dart';
import 'package:expatroasters/utils/globalvar.dart';
import 'package:expatroasters/widgets/backscreens/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgotpassView extends StatefulWidget {
  const ForgotpassView({super.key});

  @override
  State<ForgotpassView> createState() {
    return _ForgotpassViewState();
  }
}

class _ForgotpassViewState extends State<ForgotpassView> {
  final GlobalKey<FormState> _settingFormKey = GlobalKey<FormState>();
  final TextEditingController _password1TextController =
      TextEditingController();
  final TextEditingController _password2TextController =
      TextEditingController();
  final _currentpass = Get.arguments[0]["currentpass"];
  final _userid = Get.arguments[0]["userid"];

  bool _passwordVisible2 = false;
  bool _passwordVisible3 = false;
  RegExp numReg = RegExp(r".*[0-9].*");
  RegExp letterReg = RegExp(r".*[A-Za-z].*");
  RegExp charReg = RegExp(r".*[!@#$%^&*()].*");

  @override
  void initState() {
    super.initState();
  }

  Future<void> _savePassword() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = Uri.parse("$urlapi/auth/updatepass");
    showLoaderDialog(context);
    if (!_settingFormKey.currentState!.validate()) {
      Navigator.pop(context);
    } else {
      Map<String, dynamic> mdata = {
        "userid": _userid,
        "oldpass": _currentpass,
        "newpass":
            sha1.convert(utf8.encode(_password1TextController.text)).toString()
      };

      await expatAPI(url, jsonEncode(mdata)).then((ress) {
        var result = jsonDecode(ress);
        printDebug(result);
        if (result["status"] == 200) {
          prefs.setString(
            "passwd",
            sha1.convert(utf8.encode(_password1TextController.text)).toString(),
          );
          Navigator.pop(context);
          showAlert("Password successfully updated", context);
          Future.delayed(const Duration(milliseconds: 500), () {
            Get.toNamed("/front-screen/signin");
          });
        } else {
          Navigator.pop(context);
          showAlert(result["messages"]["error"], context);
        }
      });
    }
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
                            "Reset password",
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
                            "Please type something you’ll remember",
                            style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontSize: 12,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 0.5.h),
                              child: const Text(
                                "New Password",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                            SizedBox(
                              width: 90.w,
                              child: TextFormField(
                                controller: _password1TextController,
                                obscureText: !_passwordVisible2,
                                maxLines: 1,
                                keyboardType: TextInputType.text,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12),
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                      icon: Icon(
                                        // Based on passwordVisible state choose the icon
                                        _passwordVisible2
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color:
                                            Theme.of(context).primaryColorDark,
                                      ),
                                      onPressed: () {
                                        // Update the state i.e. toogle the state of passwordVisible variable
                                        setState(() {
                                          _passwordVisible2 =
                                              !_passwordVisible2;
                                        });
                                      }),
                                  isDense: true,
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
                                  hintStyle: TextStyle(
                                      fontSize: 12,
                                      color: Color.fromRGBO(163, 163, 163, 1)),
                                  hintText: 'must be 8 characters',
                                  contentPadding: const EdgeInsets.only(
                                      left: 20, bottom: 11, right: 10, top: 11),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter your password";
                                  }

                                  if (value != _password2TextController.text) {
                                    return "Password doesn't match";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 0.5.h),
                              child: const Text(
                                "Confirm Password",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                            SizedBox(
                              width: 90.w,
                              child: TextFormField(
                                controller: _password2TextController,
                                obscureText: !_passwordVisible3,
                                maxLines: 1,
                                keyboardType: TextInputType.text,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12),
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                      icon: Icon(
                                        // Based on passwordVisible state choose the icon
                                        _passwordVisible3
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color:
                                            Theme.of(context).primaryColorDark,
                                      ),
                                      onPressed: () {
                                        // Update the state i.e. toogle the state of passwordVisible variable
                                        setState(() {
                                          _passwordVisible3 =
                                              !_passwordVisible3;
                                        });
                                      }),
                                  isDense: true,
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
                                  hintStyle: TextStyle(
                                      fontSize: 12,
                                      color: Color.fromRGBO(163, 163, 163, 1)),
                                  hintText: 'repeat password',
                                  contentPadding: const EdgeInsets.only(
                                      left: 20, bottom: 11, right: 10, top: 11),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter your password";
                                  }
                                  if (value != _password1TextController.text) {
                                    return "Password doesn't match";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3.h,
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
                      text: 'Save',
                      boxsize: '90',
                      onTap: () {
                        _savePassword();
                        // SnackBar(content: Text("data"));
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
