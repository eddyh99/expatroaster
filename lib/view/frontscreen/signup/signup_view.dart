import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:expatroasters/utils/extensions.dart';
import 'package:expatroasters/utils/functions.dart';
import 'package:expatroasters/utils/globalvar.dart';
import 'package:expatroasters/utils/google_login.dart';
import 'package:expatroasters/widgets/backscreens/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
  final TextEditingController _password2TextController =
      TextEditingController();
  late final WebViewController wvcontroller;

  bool _termIsChecked = false;
  bool _passwordVisible = false;
  bool _password2Visible = false;

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

  void loginGoogle(GoogleSignInAccount user) async {
    showLoaderDialog(context);
    if (user != null) {
      Map<String, dynamic> mdata;
      mdata = {
        'email': user.email,
        'passwd': sha1.convert(utf8.encode(user.email)).toString(),
        'is_google': 'yes'
      };
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var url = Uri.parse("$urlapi/auth/signin");
      await expatAPI(url, jsonEncode(mdata)).then((ressLogin) {
        var resultLogin = jsonDecode(ressLogin);

        if (resultLogin['status'] == 200 && resultLogin['error'] == null) {
          prefs.setString("email", user.email);
          prefs.setString(
              "passwd", sha1.convert(utf8.encode(user.email)).toString());
          prefs.setBool("_rememberme", false);
          prefs.setString("id", resultLogin["messages"]["id"]);
          prefs.setString("nama", resultLogin["messages"]["nama"]);
          prefs.setString("memberid", resultLogin["messages"]["memberid"]);
          prefs.setString("role", resultLogin["messages"]["role"]);
          prefs.setString("pin", resultLogin["messages"]["pin"]);
          prefs.setString("plafon", resultLogin["messages"]["plafon"]);
          prefs.setString("is_google", "yes");
          if (resultLogin['messages']['pin']?.isEmpty) {
            Get.toNamed("/front-screen/createpin");
          } else {
            Get.toNamed("/front-screen/enterpin");
          }
        } else if (resultLogin['status'] == 400 && resultLogin['error'] == 2) {
          var urlRegister = Uri.parse("$urlapi/auth/register");
          expatAPI(urlRegister, jsonEncode(mdata)).then((ressRegister) {
            var resultRegister = jsonDecode(ressRegister);

            if (resultRegister["status"] == 200) {
              var urlReLogin = Uri.parse("$urlapi/auth/signin");
              expatAPI(urlReLogin, jsonEncode(mdata)).then((ressReLogin) {
                var resultReLogin = jsonDecode(ressReLogin);

                if (resultReLogin["status"] == 200) {
                  prefs.setString("email", user.email);
                  prefs.setString("passwd",
                      sha1.convert(utf8.encode(user.email)).toString());
                  prefs.setBool("_rememberme", false);
                  prefs.setString("id", resultReLogin["messages"]["id"]);
                  prefs.setString("nama", resultReLogin["messages"]["nama"]);
                  prefs.setString(
                      "memberid", resultReLogin["messages"]["memberid"]);
                  prefs.setString("role", resultReLogin["messages"]["role"]);
                  prefs.setString("pin", resultReLogin["messages"]["pin"]);
                  prefs.setString(
                      "plafon", resultReLogin["messages"]["plafon"]);
                  prefs.setString("is_google", "yes");
                  Get.toNamed("/front-screen/createpin");
                } else {
                  GoogleLogin.logout();
                  var psnerr = resultReLogin['messages']['error'];
                  showAlert(psnerr, context);
                }
              }).catchError((err) {
                GoogleLogin.logout();
                showAlert(
                  "Something Wrong, Please Contact Administrator",
                  context,
                );
              });
            }
          }).catchError((err) {
            GoogleLogin.logout();
            showAlert(
              "Something Wrong, Please Contact Administrator",
              context,
            );
          });
        } else if (resultLogin['status'] == 400 &&
                resultLogin['error'] == '03' ||
            resultLogin['status'] == 400 && resultLogin['error'] == '04') {
          GoogleLogin.logout();
          showAlert(
            "Email Already use, please login via email manual",
            context,
          );
        } else {
          GoogleLogin.logout();
          showAlert(
            "Something Wrong, Please Contact Administrator",
            context,
          );
        }
      }).catchError((err) {
        Navigator.pop(context);
        showAlert(
          "Something Wrong, Please Contact Administrator",
          context,
        );
      });
    } else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "Sign up with Google Failed Please try again or try another method",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromRGBO(114, 162, 138, 1),
      ));
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
            child: const Divider(
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
                color: const Color.fromRGBO(114, 162, 138, 1),
                fontSize: 20,
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
                            "Email",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                        SizedBox(height: 1.h),
                        TextFormField(
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                          controller: _emailTextController,
                          maxLines: 1,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
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
                            contentPadding: const EdgeInsets.only(
                                left: 20, bottom: 15, right: 13, top: 15),
                            hintStyle: const TextStyle(
                                fontSize: 12,
                                color: Color.fromRGBO(163, 163, 163, 1)),
                            hintText: 'example@gmail.com',
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
                          child: const Text("Create a password",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12)),
                        ),
                        SizedBox(height: 1.h),
                        TextFormField(
                          controller: _passwordTextController,
                          onChanged: (value) => _checkPassword(value),
                          obscureText: !_passwordVisible,
                          maxLines: 1,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
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
                            contentPadding: const EdgeInsets.only(
                                left: 20, bottom: 11, right: 13, top: 11),
                            hintStyle: const TextStyle(
                                fontSize: 12,
                                color: Color.fromRGBO(163, 163, 163, 1)),
                            hintText: 'must be at least 8 characters',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your password";
                            }
                            if (_strength != 1) {
                              return "Your password must Unique";
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
                          padding: EdgeInsets.symmetric(vertical: 0.5.h),
                          child: const Text("Confirm password",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12)),
                        ),
                        SizedBox(height: 1.h),
                        TextFormField(
                          controller: _password2TextController,
                          // onChanged: (value) => _checkPassword(value),
                          obscureText: !_password2Visible,
                          maxLines: 1,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _password2Visible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    _password2Visible = !_password2Visible;
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
                            contentPadding: const EdgeInsets.only(
                                left: 20, bottom: 11, right: 13, top: 11),
                            hintStyle: const TextStyle(
                                fontSize: 12,
                                color: Color.fromRGBO(163, 163, 163, 1)),
                            hintText: 'repeat password',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your confirm password";
                            }
                            if (value != _passwordTextController.text) {
                              return "Password doesn't match";
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
                      name: "btnPrimaryLight",
                      text: "Create Account",
                      boxsize: '80',
                      onTap: () async {
                        showLoaderDialog(context);
                        if (!_signupFormKey.currentState!.validate()) {
                          Navigator.pop(context);
                        }
                        if (_signupFormKey.currentState!.validate()) {
                          Map<String, dynamic> mdata;
                          mdata = {
                            'email': _emailTextController.text,
                            'passwd': sha1
                                .convert(
                                    utf8.encode(_passwordTextController.text))
                                .toString(),
                            'is_google': 'no'
                          };
                          var url = Uri.parse("$urlapi/auth/register");
                          var result = jsonDecode(
                              await expatAPI(url, jsonEncode(mdata)));
                          if (result["status"] == 200) {
                            if (context.mounted) {
                              Navigator.pop(context);
                              _signupFormKey.currentState?.reset();

                              dynamic email = _emailTextController.text;
                              wvcontroller = WebViewController();
                              wvcontroller.loadRequest(
                                Uri.parse(
                                    "$urlbase/auth/send_activation/${Uri.encodeComponent(email)}?otp=${result['messages']}"),
                              );
                              Get.toNamed("/front-screen/completeregister",
                                  arguments: [
                                    {
                                      "email": email,
                                      "password": sha1
                                          .convert(utf8.encode(
                                              _passwordTextController.text))
                                          .toString()
                                    },
                                  ]);
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
                      text: "Sign in",
                      boxsize: '80',
                      onTap: () {
                        Get.toNamed("/front-screen/signin");
                      },
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  if (Platform.isAndroid)
                    SizedBox(
                      child: ButtonWidget(
                          name: "btnSecondaryGoogle",
                          text: "Sign in with Google",
                          boxsize: '80',
                          onTap: () async {
                            var user = await GoogleLogin.login();
                            loginGoogle(user!);
                          }),
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
