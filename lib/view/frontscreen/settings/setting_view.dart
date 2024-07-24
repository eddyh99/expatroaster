import 'dart:convert';
import 'dart:io';
import 'package:expatroasters/utils/extensions.dart';
import 'package:expatroasters/utils/country.dart';
import 'package:expatroasters/utils/functions.dart';
import 'package:expatroasters/utils/globalvar.dart';
import 'package:expatroasters/widgets/backscreens/button_widget.dart';
import 'package:expatroasters/widgets/backscreens/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final TextEditingController _pinTextController = TextEditingController();
  final TextEditingController _newpassTextController = TextEditingController();
  final TextEditingController _phoneTextController = TextEditingController();

  var dobformat = DateFormat('yyyy-MM-dd');
  RegExp numReg = RegExp(r".*[0-9].*");
  RegExp letterReg = RegExp(r".*[A-Za-z].*");
  RegExp charReg = RegExp(r".*[!@#$%^&*()].*");
  File? image;
  dynamic resultData;
  String body = '';
  dynamic _previmage;
  String selectedGender = '';
  String selectedCountry = country.first;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _asyncMethod();
  }

  Future _asyncMethod() async {
    //get user detail
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var url = Uri.parse("$urlapi/v1/mobile/member/get_userdetail");
    var query = jsonDecode(await expatAPI(url, body))["messages"];
    resultData = query;
    print(resultData);
    setState(() {
      _nameTextController.text = resultData["nama"];
      _emailTextController.text = resultData["email"]!;
      _dobTextController.text =
          (resultData["dob"] == null) ? "" : resultData["dob"];
      selectedGender = toBeginningOfSentenceCase(resultData["gender"]);
      _phoneTextController.text =
          (resultData["phone"] == null) ? "" : resultData["phone"];
      selectedCountry = resultData["country"];
      _previmage = resultData["picture"];
      isLoading = false;
    });
    print(isLoading);
  }

  Future<void> simpansettings() async {
    showLoaderDialog(context);
    var url = Uri.parse("$urlapi/v1/mobile/member/updatemember");
    String baseimage = "";
    if (image != null) {
      List<int> imageBytes = image!.readAsBytesSync();
      baseimage = base64Encode(imageBytes);
    }

    Map<String, dynamic> mdata;
    mdata = {
      'nama': _nameTextController.text,
      'dob': _dobTextController.text,
      'media': baseimage,
      'gender': selectedGender.toLowerCase(),
      'phone': _phoneTextController.text,
      'country': selectedCountry,
    };

    SharedPreferences prefs = await SharedPreferences.getInstance();

    await expatAPI(url, jsonEncode(mdata)).then((ress) {
      Navigator.pop(context);
      prefs.setString("nama", _nameTextController.text);
      showAlert(
        "Profile successfully updated",
        context,
      );
      Get.toNamed("/front-screen/profile");
    }).catchError((err) {
      Navigator.pop(context);
      showAlert(
        "Something Wrong, Please Contact Administrator",
        context,
      );
    });
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
            onPressed: () => Get.toNamed("/front-screen/pilihSettings"),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: const Text(
                "SETTINGS",
                style: TextStyle(color: Colors.white),
              )),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _settingFormKey,
              child: Column(
                children: [
                  (isLoading)
                      ? ShimmerWidget(tinggi: 60, lebar: 90.w)
                      : SizedBox(
                          width: 90.w,
                          height: 100,
                          child: Row(
                            children: [
                              (_previmage != null && image == null)
                                  ? Image.network(
                                      _previmage,
                                      width: 100,
                                      height: 100,
                                    )
                                  : (image != null)
                                      ? Image.file(
                                          image!,
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        )
                                      : (selectedGender == 'Male')
                                          ? Image.asset(
                                              "assets/images/men-default.png",
                                              width: 80,
                                              height: 80,
                                              fit: BoxFit.cover,
                                            )
                                          : Image.asset(
                                              "assets/images/women-default.png",
                                              width: 80,
                                              height: 80,
                                              fit: BoxFit.cover,
                                            ),
                              // image != null
                              //     ? Image.file(
                              //         image!,
                              //         width: 100,
                              //         height: 100,
                              //         fit: BoxFit.cover,
                              //       )
                              //     : (selectedGender == 'male')
                              //         ? Image.asset(
                              //             "assets/images/men-default.png",
                              //             width: 80,
                              //             height: 80,
                              //             fit: BoxFit.cover,
                              //           )
                              //         : Image.asset(
                              //             "assets/images/women-default.png",
                              //             width: 80,
                              //             height: 80,
                              //             fit: BoxFit.cover,
                              //           ),
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
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(100),
                            ],
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
                              labelText: 'Name',
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
                              hintText: 'Date of Birth (yyyy-mm-dd)',
                              labelText: 'Date of Birth (yyyy-mm-dd)',
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
                            readOnly: true,
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
                              setState(() {
                                selectedGender = value!;
                              });
                            },
                            dropdownMenuEntries: gender
                                .map<DropdownMenuEntry<String>>((String value) {
                              return DropdownMenuEntry<String>(
                                value: value,
                                label: value,
                              );
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
                            textStyle: const TextStyle(color: Colors.white),
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
                            textStyle: const TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        const Divider(
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        SizedBox(
                          width: 100.w,
                          child: TextFormField(
                            style: const TextStyle(color: Colors.white),
                            controller: _newpassTextController,
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
                              suffixIcon: const IconButton(
                                padding: EdgeInsets.only(top: 0),
                                icon: Icon(Icons.arrow_forward_ios),
                                disabledColor: Colors.white,
                                onPressed: null,
                              ),
                            ),
                            onTap: () {
                              Get.toNamed('/front-screen/settingPassword');
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
                            controller: _pinTextController,
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
                              suffixIcon: const IconButton(
                                padding: EdgeInsets.only(top: 0),
                                icon: Icon(Icons.arrow_forward_ios),
                                disabledColor: Colors.white,
                                onPressed: null,
                              ),
                            ),
                            onTap: () {
                              Get.toNamed('front-screen/settingNewPin');
                            },
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
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
                      onTap: () {
                        simpansettings();
                      },
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
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
