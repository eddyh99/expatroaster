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

class SigninView extends StatefulWidget {
  const SigninView({super.key});

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

  // Future<dynamic> getPrefer() async {
  //   var data = await readPrefStr("logged");
  //   printDebug(data);
  // }

  @override
  void initState() {
    super.initState();
    // getPrefer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: SafeArea(
            child: SingleChildScrollView(
                child: Center(
                    child: Column(children: [
          Padding(
            padding: EdgeInsets.all(30.sp),
            child: SizedBox(
              height: 10.h,
              child: Image.asset("assets/images/logo.png"),
            ),
          ),
          SizedBox(
            width: 80.w,
            child: Divider(
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          Text(
            "Log in",
            style: TextStyle(
                fontFamily: GoogleFonts.lora().fontFamily,
                color: Color.fromRGBO(114, 162, 138, 1),
                fontSize: 26,
                fontWeight: FontWeight.w800),
          ),
          SizedBox(
            height: 3.h,
          ),
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
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                            SizedBox(height: 1.h),
                            TextFormField(
                              style: const TextStyle(color: Colors.white),
                              controller: _emailTextController,
                              maxLines: 1,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                isDense: true,
                                prefixIconColor: Colors.white,
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 0.0,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 0.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 0.0),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 0.0),
                                ),
                                hintText: 'Enter your email',
                                contentPadding: const EdgeInsets.only(
                                    left: 20, bottom: 13, right: 13, top: 13),
                              ),
                              validator: validateEmail,
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
                                          color: Colors.white, fontSize: 12)),
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
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                        width: 0.0,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                        width: 0.0,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 0.0),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 0.0),
                                    ),
                                    hintText: 'Enter your Password',
                                    contentPadding: const EdgeInsets.only(
                                        left: 20,
                                        bottom: 10,
                                        right: 10,
                                        top: 10),
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
                            const Text(
                              "Forgot Password",
                              style: TextStyle(
                                fontSize: 12,
                                color: Color.fromRGBO(114, 162, 138, 1),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      SizedBox(
                        child: ButtonWidget(
                          name: "btnPrimaryLight",
                          text: "Sign in",
                          boxsize: '80',
                          onTap: () async {
                            showLoaderDialog(context);
                            // printDebug(context.mounted);
                            if (!_signinFormKey.currentState!.validate()) {
                              Navigator.pop(context);
                            }

                            if (_signinFormKey.currentState!.validate()) {
                              Map<String, dynamic> mdata;
                              mdata = {
                                'email': _emailTextController.text,
                                'passwd': sha1
                                    .convert(utf8
                                        .encode(_passwordTextController.text))
                                    .toString()
                              };
                              // print(mdata);
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              var url = Uri.parse("$urlapi/auth/signin");

                              await expatAPI(url, jsonEncode(mdata))
                                  .then((ress) {
                                var result = jsonDecode(ress);
                                print(result);
                                if (result['status'] == 200) {
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
                                  prefs.setString(
                                      "logged", jsonEncode(result["messages"]));
                                  if (result['messages']['pin']?.isEmpty) {
                                    Get.toNamed("/front-screen/createpin");
                                  } else {
                                    Get.toNamed("/front-screen/enterpin");
                                    _signinFormKey.currentState?.reset();
                                    _emailTextController.clear();
                                    _passwordTextController.clear();
                                  }
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
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      const SizedBox(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "If you don`t have an account yet?",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              ),
                            ]),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      SizedBox(
                        child: ButtonWidget(
                          name: "btnSecondary",
                          text: "Sign Up",
                          boxsize: '80',
                          onTap: () {
                            Get.toNamed("/front-screen/register");
                          },
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                    ],
                  ),
                ),
              ))
        ])))));
  }
}
