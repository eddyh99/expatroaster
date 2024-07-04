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

class SettingPasswordView extends StatefulWidget {
  const SettingPasswordView({super.key});

  @override
  State<SettingPasswordView> createState() {
    return _SettingPasswordViewState();
  }
}

class _SettingPasswordViewState extends State<SettingPasswordView> {
  final GlobalKey<FormState> _settingFormKey = GlobalKey<FormState>();
  final TextEditingController _currentPasswordTextController =
      TextEditingController();
  final TextEditingController _password1TextController =
      TextEditingController();
  final TextEditingController _password2TextController =
      TextEditingController();
  late String _currpassword;
  late String _userid;
  late String _inptcurrpassword;

  bool _passwordVisible1 = false;
  bool _passwordVisible2 = false;
  bool _passwordVisible3 = false;
  RegExp numReg = RegExp(r".*[0-9].*");
  RegExp letterReg = RegExp(r".*[A-Za-z].*");
  RegExp charReg = RegExp(r".*[!@#$%^&*()].*");

  Future _asyncMethod() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _currpassword = prefs.getString("passwd")!;
    _userid = prefs.getString("id")!;
  }

  void _currentValidation(String value) {
    _inptcurrpassword = value.trim();
    _inptcurrpassword = sha1.convert(utf8.encode(_inptcurrpassword)).toString();
  }

  @override
  void initState() {
    super.initState();
    _asyncMethod();
  }

  Future<void> _savePassword() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = Uri.parse("$urlapi/auth/updatepass");
    showLoaderDialog(context);
    if (!_settingFormKey.currentState!.validate()) {
      Navigator.pop(context);
    } else {
      if (_currpassword == _inptcurrpassword) {
        Map<String, dynamic> mdata = {
          "userid": _userid,
          "oldpass": _currpassword,
          "newpass": sha1
              .convert(utf8.encode(_password1TextController.text))
              .toString()
        };

        await expatAPI(url, jsonEncode(mdata)).then((ress) {
          var result = jsonDecode(ress);
          printDebug(result);
          if (result["status"] == 200) {
            prefs.setString(
              "passwd",
              sha1
                  .convert(utf8.encode(_password1TextController.text))
                  .toString(),
            );
            Navigator.pop(context);
            showAlert("Password successfully updated", context);
            Future.delayed(const Duration(milliseconds: 500), () {
              Get.toNamed("/front-screen/profile");
            });
          } else {
            Navigator.pop(context);
            showAlert(result["messages"]["error"], context);
          }
        });
      } else {
        Navigator.pop(context);
        showAlert(
          "Your Current Password is Wrong",
          context,
        );
      }
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
                            "Create \nNew Password",
                            style: TextStyle(
                                color: Color.fromRGBO(114, 162, 138, 1),
                                fontSize: 36,
                                fontFamily: GoogleFonts.lora().fontFamily,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        SizedBox(
                          width: 90.w,
                          child: TextFormField(
                            controller: _currentPasswordTextController,
                            obscureText: !_passwordVisible1,
                            onChanged: (value) {
                              _currentValidation(value);
                            },
                            maxLines: 1,
                            keyboardType: TextInputType.text,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  icon: Icon(
                                    // Based on passwordVisible state choose the icon
                                    _passwordVisible1
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                  onPressed: () {
                                    // Update the state i.e. toogle the state of passwordVisible variable
                                    setState(() {
                                      _passwordVisible1 = !_passwordVisible1;
                                    });
                                  }),
                              isDense: true,
                              labelText: 'Current Password',
                              labelStyle: const TextStyle(color: Colors.white),
                              hintStyle: const TextStyle(
                                  color: Color.fromARGB(255, 93, 93, 93)),
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
                              hintText: 'must be at least 8 characters',
                              contentPadding: const EdgeInsets.only(
                                  left: 20, bottom: 10, right: 10, top: 10),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your password";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        SizedBox(
                          width: 90.w,
                          child: TextFormField(
                            controller: _password1TextController,
                            obscureText: !_passwordVisible2,
                            maxLines: 1,
                            keyboardType: TextInputType.text,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  icon: Icon(
                                    // Based on passwordVisible state choose the icon
                                    _passwordVisible2
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                  onPressed: () {
                                    // Update the state i.e. toogle the state of passwordVisible variable
                                    setState(() {
                                      _passwordVisible2 = !_passwordVisible2;
                                    });
                                  }),
                              isDense: true,
                              labelText: 'Create a new password',
                              labelStyle: const TextStyle(color: Colors.white),
                              hintStyle: const TextStyle(
                                  color: Color.fromARGB(255, 93, 93, 93)),
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
                              hintText: 'must be at least 8 characters',
                              contentPadding: const EdgeInsets.only(
                                  left: 20, bottom: 10, right: 10, top: 10),
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
                        SizedBox(
                          height: 5.h,
                        ),
                        SizedBox(
                          width: 90.w,
                          child: TextFormField(
                            controller: _password2TextController,
                            obscureText: !_passwordVisible3,
                            maxLines: 1,
                            keyboardType: TextInputType.text,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  icon: Icon(
                                    // Based on passwordVisible state choose the icon
                                    _passwordVisible3
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                  onPressed: () {
                                    // Update the state i.e. toogle the state of passwordVisible variable
                                    setState(() {
                                      _passwordVisible3 = !_passwordVisible3;
                                    });
                                  }),
                              isDense: true,
                              labelText: 'Confirm password',
                              labelStyle: const TextStyle(color: Colors.white),
                              hintStyle: const TextStyle(
                                  color: Color.fromARGB(255, 93, 93, 93)),
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
                              hintText: 'repeat password',
                              contentPadding: const EdgeInsets.only(
                                  left: 20, bottom: 10, right: 10, top: 10),
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
