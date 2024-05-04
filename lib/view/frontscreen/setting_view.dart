import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:expatroasters/utils/extensions.dart';
import 'package:expatroasters/utils/country.dart';
import 'package:expatroasters/utils/functions.dart';
import 'package:expatroasters/utils/globalvar.dart';
import 'package:expatroasters/widgets/backscreens/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() {
    return _SettingViewState();
  }
}

const List<String> gender = <String>['Male', 'Female'];

class _SettingViewState extends State<SettingView> {
  final GlobalKey<FormState> _settingFormKey = GlobalKey<FormState>();
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _dobTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();

  final TextEditingController _currentTextController = TextEditingController();
  final TextEditingController _newpassTextController = TextEditingController();
  final TextEditingController _confirmTextController = TextEditingController();
  final TextEditingController _phoneTextController = TextEditingController();
  var dobformat = DateFormat('MM/d/yyyy');
  late String _password;

  bool _passwordVisible = false;
  RegExp numReg = RegExp(r".*[0-9].*");
  RegExp letterReg = RegExp(r".*[A-Za-z].*");
  RegExp charReg = RegExp(r".*[!@#$%^&*()].*");
  File? image;
  dynamic resultData;
  String body = '';

  @override
  void initState() {
    super.initState();
    _asyncMethod();
  }

  Future _asyncMethod() async {
    //get user detail
    var url = Uri.parse("$urlapi/v1/mobile/member/get_userdetail");
    var query = jsonDecode(await expatAPI(url, body))["messages"];
    //printDebug(query);
    // printDebug(resultData);
    // setState(() {
    //   resultData = query;
    //   _nameTextController.text = resultData["nama"];
    //   _dobTextController.text = resultData["dob"];
    //   if (resultData["gender"] == "female") {
    //     selectedOption = 2;
    //   } else {
    //     selectedOption = 1;
    //   }
    // });
  }

  void _checkPassword(String value) {
    _password = value.trim();

    if (_password.isEmpty) {
      setState(() {});
    } else if (_password.length < 8) {
      setState(() {});
    } else if (!charReg.hasMatch(_password)) {
      setState(() {});
    } else {
      if (!letterReg.hasMatch(_password) || !numReg.hasMatch(_password)) {
        setState(() {
          // Password length >= 8
          // But doesn't contain both letter and digit characters
        });
      } else {
        // Password length >= 8
        // Password contains both letter and digit characters
        setState(() {});
      }
    }
  }

  Future<void> simpansettings() async {
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

    var url = Uri.parse("$urlapi/v1/member/updatemember");
    try {
      String baseimage = "";
      if (image != null) {
        List<int> imageBytes = image!.readAsBytesSync();
        String baseimage = base64Encode(imageBytes);
        debugPrint(baseimage);
      }

      if (_newpassTextController.text.isNotEmpty) {
        if (!_currentTextController.text.isNotEmpty) {
          var snackBar =
              const SnackBar(content: Text('Please enter your old password'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }

      if (_newpassTextController.text != _confirmTextController.text) {
        var snackBar = const SnackBar(
            content: Text('New password & Confirm password does not match'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

      var newpass = "";
      if (_newpassTextController.text.isNotEmpty) {
        newpass =
            sha1.convert(utf8.encode(_newpassTextController.text)).toString();
      }

      Map<String, dynamic> mdata;
      mdata = {
        'name': _nameTextController.text,
        'dob': _dobTextController.text,
        'media': baseimage,
        'gender': selectedOption,
        'passwd': newpass
      };

      var result = jsonDecode(await expatAPI(url, jsonEncode(mdata)));
      if (result["code"] == "200") {
        if (context.mounted) {
          var psnerror = "Settings successfully updated";
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(psnerror),
              backgroundColor: Colors.deepOrange,
            ),
          );
          Navigator.of(context, rootNavigator: true).pop();
          Navigator.pop(context);
          _settingFormKey.currentState?.reset();
        }
      } else {
        if (context.mounted) {
          var psnerror = result["message"];
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(psnerror),
            backgroundColor: Colors.deepOrange,
          ));
          Navigator.of(context, rootNavigator: true).pop();
          Navigator.pop(context);
        }
      }
    } catch (e) {
      debugPrint(e.toString());

      // log(e.toString());
      //there is error during converting file image to base64 encoding.
    }
  }

  Future pickgambar(String sumber) async {
    try {
      if (sumber == 'gallery') {
        final image =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (image == null) return;
        final imageTemporary = File(image.path);
        setState(() {
          this.image = imageTemporary;
        });
      } else {
        final image = await ImagePicker().pickImage(source: ImageSource.camera);
        if (image == null) return;
        final imageTemporary = File(image.path);
        setState(() {
          this.image = imageTemporary;
        });
      }
    } on PlatformException {
      debugPrint("gagal");
    }
  }

  int selectedOption = 1;

  String selectedGender = gender.first;
  String selectedCountry = country.first;

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
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: const Text(
                "SETTINGS ACCOUNT",
                style: TextStyle(color: Colors.white),
              )),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _settingFormKey,
              child: Column(
                children: [
                  SizedBox(
                    width: 90.w,
                    height: 100,
                    child: Row(
                      children: [
                        image != null
                            ? Image.file(
                                image!,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              )
                            : Image.asset("assets/images/avatar.png",
                                color: Colors.white),
                        TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () => pickgambar('gallery'),
                          child: const Row(
                            children: [
                              Icon(Icons.folder),
                              SizedBox(width: 10),
                              Text("Choose Picture")
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 100.w,
                    height: 3.h,
                  ),
                  SizedBox(
                    width: 90.w,
                    child: Column(
                      children: [
                        SizedBox(
                          width: 100.w,
                          child: TextFormField(
                            style: const TextStyle(color: Colors.white),
                            controller: _nameTextController,
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
                              // hintText: 'Your Name',
                              labelText: 'Full name',
                              labelStyle: const TextStyle(color: Colors.white),
                              hintStyle: const TextStyle(color: Colors.white),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your name";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        SizedBox(
                          width: 100.w,
                          child: TextFormField(
                            onTap: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              ).then((date) {
                                //tambahkan setState dan panggil variabel _dateTime.
                                _dobTextController.text = (date == null)
                                    ? _dobTextController.text
                                    : dobformat.format(date).toString();

                                // setState(() {
                                // });
                              });
                            },
                            style: const TextStyle(color: Colors.white),
                            controller: _dobTextController,
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
                              hintText: 'Date of Birth (mm/dd/yyyy)',
                              labelText: 'Date of Birth (mm/dd/yyyy)',
                              hintStyle: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        SizedBox(
                          width: 100.w,
                          child: TextFormField(
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
                              labelText: 'Email',
                              hintStyle: const TextStyle(color: Colors.white),
                              labelStyle: const TextStyle(color: Colors.white),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter phone number";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        SizedBox(
                          width: 100.w,
                          child: TextFormField(
                            style: const TextStyle(color: Colors.white),
                            controller: _phoneTextController,
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
                              labelText: 'Phone Number',
                              labelStyle: const TextStyle(color: Colors.white),
                              hintStyle: const TextStyle(color: Colors.white),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter phone number";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        SizedBox(
                          width: 90.w,
                          child: DropdownMenu<String>(
                            width: 90.w,
                            initialSelection: selectedGender,
                            onSelected: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                selectedGender = value!;
                              });
                            },
                            dropdownMenuEntries: gender
                                .map<DropdownMenuEntry<String>>((String value) {
                              return DropdownMenuEntry<String>(
                                  value: value, label: value);
                            }).toList(),
                            inputDecorationTheme: InputDecorationTheme(
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
                              labelStyle: const TextStyle(color: Colors.white),
                              hintStyle: const TextStyle(color: Colors.white),
                            ),
                            textStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        SizedBox(
                          width: 90.w,
                          child: DropdownMenu<String>(
                            width: 90.w,
                            initialSelection: selectedCountry,
                            onSelected: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                selectedCountry = value!;
                                print(selectedCountry);
                              });
                            },
                            dropdownMenuEntries: country
                                .map<DropdownMenuEntry<String>>((String value) {
                              return DropdownMenuEntry<String>(
                                  value: value, label: value);
                            }).toList(),
                            inputDecorationTheme: InputDecorationTheme(
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
                              labelStyle: const TextStyle(color: Colors.white),
                              hintStyle: const TextStyle(color: Colors.white),
                            ),
                            textStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Divider(
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        SizedBox(
                          width: 100.w,
                          child: TextFormField(
                            style: const TextStyle(color: Colors.white),
                            controller: _currentTextController,
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
                              labelText: 'Change Password',
                              labelStyle: const TextStyle(color: Colors.white),
                              hintStyle: const TextStyle(color: Colors.white),
                              suffixIcon: IconButton(
                                padding: EdgeInsets.only(top: 0),
                                icon: Icon(Icons.arrow_forward_ios),
                                disabledColor: Colors.white,
                                onPressed: null,
                              ),
                            ),
                            onTap: () {
                              print("PASSWORD");
                            },
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        SizedBox(
                          width: 100.w,
                          child: TextFormField(
                            style: const TextStyle(color: Colors.white),
                            controller: _currentTextController,
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
                              labelText: 'Change PIN',
                              labelStyle: const TextStyle(color: Colors.white),
                              hintStyle: const TextStyle(color: Colors.white),
                              suffixIcon: IconButton(
                                padding: EdgeInsets.only(top: 0),
                                icon: Icon(Icons.arrow_forward_ios),
                                disabledColor: Colors.white,
                                onPressed: null,
                              ),
                            ),
                            onTap: () {
                              print("PIN");
                            },
                          ),
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
                      boxsize: '80',
                      onTap: () {},
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
