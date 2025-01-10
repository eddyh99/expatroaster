import 'package:expatroasters/utils/extensions.dart';
import 'package:expatroasters/utils/functions.dart';
import 'package:expatroasters/widgets/backscreens/Iconsosmed_widget.dart';
import 'package:expatroasters/widgets/backscreens/async_widget.dart';
import 'package:expatroasters/widgets/backscreens/bottomnav_widget.dart';
import 'package:expatroasters/widgets/backscreens/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class QrcodeView extends StatefulWidget {
  const QrcodeView({super.key});
  @override
  State<QrcodeView> createState() {
    return _QrcodeViewState();
  }
}

class _QrcodeViewState extends State<QrcodeView> {
  String memberid = '';
  String nama = '';
  bool isLoadingPref = true;

  Future<void> getCompany() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bearerToken().then((value) => {
          if (value.isEmpty) {Get.offAllNamed("/front-screen/signin")}
        });

    var getmemberid = prefs.getString("memberid") ?? "";
    var getnama = prefs.getString("nama") ?? "";
    nama = getnama!;
    memberid = getmemberid!;
    setState(() {
      isLoadingPref = false;
    });
  }

  Future<void> _launchInWebViewOrVC(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
      throw Exception('Could not launch $url');
    }
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
            onPressed: () => Get.toNamed('front-screen/home'),
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
                    (isLoadingPref)
                        ? ShimmerWidget(tinggi: 2.h, lebar: 20.w)
                        : Text(
                            nama,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
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
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    SizedBox(
                      height: 5.h,
                      child: IconsosmedWidget(),
                    ),
                  ],
                ),
              ),
            ])),
        bottomNavigationBar: const Expatnav(
          number: 1,
        ));
  }
}
