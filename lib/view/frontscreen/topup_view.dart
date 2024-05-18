import 'package:expatroasters/utils/extensions.dart';
import 'package:expatroasters/utils/functions.dart';
import 'package:expatroasters/utils/globalvar.dart';
import 'package:expatroasters/widgets/backscreens/bottomnav_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TopupView extends StatefulWidget {
  const TopupView({super.key});

  @override
  State<TopupView> createState() {
    return _TopupViewState();
  }
}

class _TopupViewState extends State<TopupView> {
  late final WebViewController wvcontroller;
  String token = "";
  int value = 0;
  int selectedOption = 0;

  @override
  void initState() {
    super.initState();
    bearerToken().then(
      (value) => {
        setState(() {
          token = value;
          wvcontroller.loadRequest(
              Uri.parse("$urlbase/widget/topup/membertopup/$token"));
        })
      },
    );
    wvcontroller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
        ),
      );
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
                onPressed: () => Get.toNamed("/front-screen/home"),
              ),
              centerTitle: true,
              title: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: const Text("TOPUP",
                      style: TextStyle(color: Colors.white))),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: SafeArea(
                child: SingleChildScrollView(
                    child: Center(
              child: SizedBox(
                  height: 500.h,
                  width: 100.w,
                  child: WebViewWidget(controller: wvcontroller)),
            ))),
            bottomNavigationBar: const Expatnav()));
  }
}
