import 'package:connectivity_plus/connectivity_plus.dart';
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
  double _webViewHeight = 1;
  String token = "";
  int value = 0;
  int selectedOption = 0;
  bool _isOffline = false;
  bool isDataReady = true;

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
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
          onPageFinished: (String url) async {
            // Inject auto height content
            final height = await wvcontroller.runJavaScriptReturningResult(
                "document.documentElement.scrollHeight;");
            setState(() {
              _webViewHeight = double.tryParse(height.toString()) ?? 1;
              isDataReady = false;
            });
          },
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
              child: Stack(
                children: [
                  WebViewWidget(controller: wvcontroller),
                  (isDataReady)
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : Stack(),
                ],
              ),
            ),
            bottomNavigationBar: const Expatnav()));
  }

}
