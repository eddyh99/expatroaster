import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:expatroasters/utils/extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

void printDebug(Object object) {
  if (kDebugMode) {
    print(object);
  }
}

// Future<bool> openMailApp() async {
//   var result = await OpenMailApp.openMailApp();
//   if (!result.canOpen && !result.didOpen) {
//     return false;
//   }
//   return true;
// }

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
