import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:expatroasters/utils/extensions.dart';
import 'package:expatroasters/utils/functions.dart';
import 'package:expatroasters/utils/globalvar.dart';
import 'package:expatroasters/widgets/backscreens/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() {
    return _SignupViewState();
  }
}

class _SignupViewState extends State<SignupView> {
  final GlobalKey<FormState> _signupFormKey = GlobalKey<FormState>();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  bool _termIsChecked = false;
  bool _passwordVisible = false;

  late String _password;
  double _strength = 0;

  RegExp numReg = RegExp(r".*[0-9].*");
  RegExp letterReg = RegExp(r".*[A-Za-z].*");
  RegExp charReg = RegExp(r".*[!@#$%^&*()].*");

  void _checkPassword(String value) {
    _password = value.trim();

    if (_password.isEmpty) {
      setState(() {
        _strength = 0;
      });
    } else if (_password.length < 8) {
      setState(() {
        _strength = 1 / 4;
      });
    } else if (!charReg.hasMatch(_password)) {
      setState(() {
        _strength = 2 / 4;
      });
    } else {
      if (!letterReg.hasMatch(_password) || !numReg.hasMatch(_password)) {
        setState(() {
          // Password length >= 8
          // But doesn't contain both letter and digit characters
          _strength = 3 / 4;
        });
      } else {
        // Password length >= 8
        // Password contains both letter and digit characters
        setState(() {
          _strength = 1;
        });
      }
    }
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
            height: 1.h,
          ),
          Text(
            "Sign Up",
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
            key: _signupFormKey,
            child: Center(
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
                            style: TextStyle(color: Colors.white, fontSize: 12),
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
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 0.0),
                            ),
                            hintText: 'Enter your email',
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
                              padding: EdgeInsets.symmetric(vertical: 0.5.h),
                              child: const Text("Password",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12)),
                            ),
                            SizedBox(height: 1.h),
                            TextFormField(
                              controller: _passwordTextController,
                              onChanged: (value) => _checkPassword(value),
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
                                      color: Theme.of(context).primaryColorDark,
                                    ),
                                    onPressed: () {
                                      // Update the state i.e. toogle the state of passwordVisible variable
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    }),
                                isDense: true,
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
                    height: 2.h,
                  ),
                  SizedBox(
                    width: 80.w,
                    child: LinearProgressIndicator(
                      value: _strength,
                      backgroundColor: Colors.grey[300],
                      color: _strength <= 1 / 4
                          ? Colors.red
                          : _strength == 2 / 4
                              ? Colors.yellow
                              : _strength == 3 / 4
                                  ? Colors.blue
                                  : Colors.green,
                      minHeight: 5,
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  SizedBox(
                    width: 80.w,
                    child: const Text(
                      "Use 8 or more characters with a mix of letters, numbers & symbols.",
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  SizedBox(
                    child: ButtonWidget(
                      name: "btnPrimaryLigth",
                      text: "Create Account",
                      boxsize: '80',
                      onTap: () async {
                        showLoaderDialog(context);
                        if (_signupFormKey.currentState!.validate()) {
                          Map<String, dynamic> mdata;
                          mdata = {
                            'email': _emailTextController.text,
                            'passwd': sha1
                                .convert(
                                    utf8.encode(_passwordTextController.text))
                                .toString()
                          };
                          printDebug(jsonEncode(mdata));
                          var url = Uri.parse("$urlapi/auth/register");
                          var result = jsonDecode(
                              await expatAPI(url, jsonEncode(mdata)));
                          if (result["status"] == 200) {
                            if (context.mounted) {
                              Navigator.pop(context);
                              _signupFormKey.currentState?.reset();
                              Get.toNamed("/front-screen/completeregister",
                                  arguments: [_emailTextController.text]);
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
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  SizedBox(
                    width: 80.w,
                    child: Row(
                      children: [
                        Transform.scale(
                            scale: 0.7,
                            child: Checkbox(
                                side: const BorderSide(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                                value: _termIsChecked,
                                checkColor: Colors.white,
                                activeColor: Colors.red,
                                onChanged: ((value) {
                                  setState(() {
                                    _termIsChecked =
                                        value == true ? true : false;
                                  });
                                }))),
                        SizedBox(
                          width: 60.w,
                          child: const Text(
                            "I would like to receive your newsletter and other promotional information.",
                            style: TextStyle(fontSize: 10, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Do you have already an account?",
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
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
                    height: 10.h,
                  ),
                ],
              ),
            ),
          )
        ])))));
  }
}
