import 'package:expatroasters/utils/extensions.dart';
import 'package:expatroasters/utils/functions.dart';
import 'package:expatroasters/utils/globalvar.dart';
// import 'package:expatroasters/widgets/backscreens/bottomnav_widget.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:get/get.dart';

class OrderDetailView extends StatefulWidget {
  const OrderDetailView({super.key});

  @override
  State<OrderDetailView> createState() {
    return _OrderDetailViewState();
  }
}

class _OrderDetailViewState extends State<OrderDetailView> {
  late final WebViewController wvcontroller;
  var idcabang = Get.arguments[0]["idcabang"];
  var idproduk = Get.arguments[1]["idproduk"];
  // int idproduk = 6;

  @override
  void initState() {
    super.initState();
    printDebug(idcabang);
    printDebug(idproduk);

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
    wvcontroller.loadRequest(
      Uri.parse(
          "$urlbase/widget/order/detail?cabang=$idcabang&product=$idproduk"),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.black,
        body: SafeArea(
          child: WebViewWidget(controller: wvcontroller),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.toNamed(
              "/front-screen/allmenu",
              arguments: [
                {"idcabang": idcabang}
              ],
            );
          },
          icon: const Icon(Icons.restaurant_menu),
          label: Text(
            "Menu",
            style: TextStyle(fontSize: 18),
          ),
          backgroundColor: Color.fromRGBO(131, 173, 152, 1),
          foregroundColor: Colors.white,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        // bottomNavigationBar: const Expatnav(),
      ),
    );
  }
}
