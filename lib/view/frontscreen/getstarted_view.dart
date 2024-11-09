import 'package:crypto/crypto.dart';
import 'package:expatroasters/utils/extensions.dart';
import 'package:expatroasters/utils/functions.dart';
import 'package:expatroasters/utils/globalvar.dart';
import 'package:expatroasters/utils/google_login.dart';
import 'package:expatroasters/widgets/backscreens/button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class GetstartedView extends StatefulWidget {
  const GetstartedView({super.key});

  @override
  State<GetstartedView> createState() {
    return _GetstartedViewState();
  }
}

// Future signUpGoogle() async {
//   await GoogleSignInApi.login();
// }

class _GetstartedViewState extends State<GetstartedView> {
  late Uri toLaunch;

  Future _asyncMethod() async {
    final prefs = await SharedPreferences.getInstance();
    var email = prefs.getString("email");
    var passwd = prefs.getString("passwd");
    var is_google = prefs.getString("is_google");
    var rememberme = prefs.getBool("_rememberme");

    if (rememberme == true) {
      showLoaderDialog(context);
      Map<String, dynamic> mdata;
      mdata = {'email': email, 'passwd': passwd, 'is_google': is_google};
      var url = Uri.parse("$urlapi/auth/signin");
      await expatAPI(url, jsonEncode(mdata)).then((ress) {
        var result = jsonDecode(ress);
        if (result["status"] == 200) {
          Navigator.pop(context);
          Get.toNamed("/front-screen/enterpin");
        } else {
          Navigator.pop(context);
          showAlert(result["messages"]["error"], context);
        }
      }).catchError(
        (err) {
          Navigator.pop(context);
          showAlert(
            "404 - Error, Please Contact Administrator",
            context,
          );
        },
      );
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
  void initState() {
    super.initState();
    _asyncMethod();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50.h,
              child: Image.asset('assets/images/logo.png'),
            ),
            SizedBox(
                height: 35.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      child: ButtonWidget(
                        name: "btnPrimaryGoogle",
                        text: "Sign up with Google",
                        boxsize: '80',
                        onTap: () async {
                          var user = await GoogleLogin.login();
                          loginGoogle(user!);
                        },
                        // onTap: signUpGoogle,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    SizedBox(
                      child: ButtonWidget(
                          name: "btnSecondaryEmail",
                          text: "Sign up with E-mail",
                          boxsize: '80',
                          onTap: () {
                            Get.toNamed("/front-screen/register");
                          }),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Do you have already an account? ',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                          TextSpan(
                            text: 'Login!',
                            style: const TextStyle(
                                color: Color.fromRGBO(114, 162, 138, 1),
                                fontSize: 12),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.toNamed("/front-screen/signin");
                              },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    SizedBox(
                        width: 90.w,
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'By registering, you agree to our ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                              TextSpan(
                                text: "Terms of Use",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.toNamed("/front-screen/termcondition");
                                  },
                              ),
                              TextSpan(
                                text:
                                    ' Learn how we collect, use and share your data.',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ],
                          ),
                        )),
                    SizedBox(
                      height: 5.h,
                    )
                  ],
                ))
          ],
        )));
  }
}
