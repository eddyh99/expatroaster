import 'package:expatroasters/utils/extensions.dart';
import 'package:expatroasters/utils/functions.dart';
import 'package:expatroasters/widgets/backscreens/async_widget.dart';
import 'package:expatroasters/widgets/backscreens/bottomnav_widget.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrcodeView extends StatefulWidget {
  const QrcodeView({super.key});
  @override
  State<QrcodeView> createState() {
    return _QrcodeViewState();
  }
}

class _QrcodeViewState extends State<QrcodeView> {
  String memberid = '';

  Future<void> getCompany() async {
    var name = await readPrefStr("logged");
    setState(() {
      memberid = name["memberid"];
    });
  }

  @override
  void initState() {
    super.initState();
    getCompany();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.black,
        ),
        body: SafeArea(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              SizedBox(
                width: 100.w,
              ),
              Image.asset(
                "assets/images/icon_handshake.png",
                color: const Color.fromRGBO(114, 162, 138, 1),
              ),
              SizedBox(
                height: 2.h,
              ),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Hi",
                      style: TextStyle(color: Colors.white),
                    ),
                    const AsyncTextWidget(pref: "logged", field: "nama"),
                    SizedBox(
                      height: 2.h,
                    ),
                    SizedBox(
                        width: 275,
                        height: 300,
                        child: DecoratedBox(
                            decoration: const BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  //
                                  color: Colors.white,
                                  width: 1.0,
                                ),
                                bottom: BorderSide(
                                  //
                                  color: Colors.white,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2.w, vertical: 2.h),
                              child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 2.h, vertical: 2.h),
                                    child: QrImageView(
                                      data: memberid,
                                      version: QrVersions.auto,
                                      size: 300.0,
                                    ),
                                  )),
                            )))
                  ],
                ),
              ),
            ])),
        bottomNavigationBar: const Expatnav(pos: 1));
  }
}
