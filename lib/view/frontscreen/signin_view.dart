import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:expatroaster/utils/extensions.dart';
import 'package:expatroaster/utils/functions.dart';
import 'package:expatroaster/utils/globalvar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninView extends StatefulWidget {
  const SigninView({Key? key}) : super(key: key);

  @override
  State<SigninView> createState() {
    return _SigninViewState();
  }
}

class _SigninViewState extends State<SigninView> {
  final GlobalKey<FormState> _signinFormKey = GlobalKey<FormState>();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  bool _rememberIsChecked = false;
  bool _passwordVisible = false;

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      backgroundColor: const Color.fromRGBO(30, 30, 30, 1),
      content: SizedBox(
          height: 9.h,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Color.fromRGBO(114, 162, 138, 1))),
            ],
          )),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: SafeArea(
            child: Center(
                child: Column(children: [
          Padding(
              padding: EdgeInsets.all(30.sp),
              child: SizedBox(
                height: 10.h,
                child: Image.asset("assets/images/logo.png"),
              )),
          Form(
              key: _signinFormKey,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 80.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 0.5.h),
                              child: const Text(
                                "Email Address",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              ),
                            ),
                            SizedBox(height: 1.h),
                            TextFormField(
                              style: const TextStyle(color: Colors.white),
                              controller: _emailTextController,
                              maxLines: 1,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                isDense: true,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 0.0),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 0.0),
                                ),
                                hintText: 'Enter your email',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your email address";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      SizedBox(
                          width: 80.w,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(vertical: 0.5.h),
                                  child: const Text("Password",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 10)),
                                ),
                                SizedBox(height: 1.h),
                                TextFormField(
                                  controller: _passwordTextController,
                                  obscureText: !_passwordVisible,
                                  maxLines: 1,
                                  keyboardType: TextInputType.text,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                        icon: Icon(
                                          // Based on passwordVisible state choose the icon
                                          _passwordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                        ),
                                        onPressed: () {
                                          // Update the state i.e. toogle the state of passwordVisible variable
                                          setState(() {
                                            _passwordVisible =
                                                !_passwordVisible;
                                          });
                                        }),
                                    isDense: true,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 0.0),
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 0.0),
                                    ),
                                    hintText: 'Enter your Password',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter your password";
                                    }
                                    return null;
                                  },
                                ),
                              ])),
                      SizedBox(
                        width: 85.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 40.w,
                              child: Row(
                                children: [
                                  Transform.scale(
                                      scale: 0.7,
                                      child: Checkbox(
                                          side: const BorderSide(
                                            color: Colors.grey,
                                            width: 1,
                                          ),
                                          value: _rememberIsChecked,
                                          checkColor: Colors.white,
                                          activeColor: Colors.red,
                                          onChanged: ((value) {
                                            setState(() {
                                              _rememberIsChecked =
                                                  value == true ? true : false;
                                            });
                                          }))),
                                  const Text(
                                    "Remember Me",
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            const Text("Forgot Password",
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Color.fromRGBO(114, 162, 138, 1)))
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
                              if (_signinFormKey.currentState!.validate()) {
                                Map<String, dynamic> mdata;
                                mdata = {
                                  'email': _emailTextController.text,
                                  'passwd': sha1
                                      .convert(utf8
                                          .encode(_passwordTextController.text))
                                      .toString()
                                };
                                printDebug(jsonEncode(mdata));
                                var url = Uri.parse("$urlapi/auth/signin");
                                var result = jsonDecode(
                                    await expatAPI(url, jsonEncode(mdata)));
                                if (result["code"] == "200") {
                                  if (context.mounted) {
                                    Navigator.pop(context);
                                  }
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setString(
                                      "email", _emailTextController.text);
                                  prefs.setString(
                                      "passwd",
                                      sha1
                                          .convert(utf8.encode(
                                              _passwordTextController.text))
                                          .toString());
                                  prefs.setBool(
                                      "_rememberme", _rememberIsChecked);

                                  Get.toNamed("/front-screen/home", arguments: [
                                    {"first": result["message"]}
                                  ]);
                                  _signinFormKey.currentState?.reset();
                                  _emailTextController.clear();
                                  _passwordTextController.clear();
                                } else {
                                  var psnerror = result["message"];
                                  if (context.mounted) {
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(psnerror),
                                      backgroundColor: Colors.deepOrange,
                                    ));
                                  }
                                }
                              }
                            },
                            child: const Text("Sign In")),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      SizedBox(
                        height: 29.h,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Text(
                                "If you don’t have an account yet?",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              ),
                              SizedBox(
                                width: 90.w,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          const Color.fromRGBO(25, 25, 25, 1),
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                      )),
                                  onPressed: () {
                                    Get.toNamed("/front-screen/register");
                                  },
                                  child: const Text("Sign Up"),
                                ),
                              ),
                            ]),
                      )
                    ],
                  ),
                ),
              ))
        ]))));
  }
}
