import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:expatroasters/utils/extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:email_validator/email_validator.dart';

void printDebug(Object object) {
  if (kDebugMode) {
    print(object);
  }
}

int randomNumber() {
  int min = 1000;
  int max = 9999;
  final rnd = Random();
  int r = min + rnd.nextInt(max - min);
  return r;
}

Future bearerToken() async {
  final prefs = await SharedPreferences.getInstance();
  var email = prefs.getString("email");
  var passwd = prefs.getString("passwd");

  String token = '';
  if (email != null && passwd != null) {
    token = sha1.convert(utf8.encode(email + passwd)).toString();
  }
  debugPrint('100-$token');

  return token;
}

Future<String> expatAPI(Uri url, String body) async {
  final prefs = await SharedPreferences.getInstance();
  var email = prefs.getString("email");
  var passwd = prefs.getString("passwd");

  String token = '';
  var headers = {'Content-Type': 'application/json'};
  if (email != null && passwd != null) {
    token = sha1.convert(utf8.encode(email + passwd)).toString();
  }

  if (token.isNotEmpty) {
    headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
  }

  Response response = await post(url, headers: headers, body: body);
  return response.body;
}

Future<dynamic> readAllPref() async {
  final prefs = await SharedPreferences.getInstance();
  final keys = prefs.getKeys();

  final prefsMap = Map<String, dynamic>();
  for (String key in keys) {
    prefsMap[key] = prefs.get(key);
  }
}

readPrefStr(String key) async {
  final SharedPreferences pref = await SharedPreferences.getInstance();
  return jsonDecode(pref.getString(key)!);
}

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

showAlert(String value, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      value,
      style: const TextStyle(color: Colors.white),
    ),
    backgroundColor: const Color.fromRGBO(114, 162, 138, 1),
  ));
}

String? validateEmail(String? email) {
  dynamic isValid = EmailValidator.validate('$email');

  // Navigator.pop(context);
  if (email == null || email.isEmpty) {
    return "Please enter your email";
  }

  if (!isValid) {
    return "Please enter a valid email";
  }

  return null;
}

String capitalizeFirstLetter(String word) {
  if (word.isEmpty) {
    return word; // Return empty string if input is empty
  }
  return word[0].toUpperCase() + word.substring(1);
}
