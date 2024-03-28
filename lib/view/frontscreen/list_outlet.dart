import 'dart:async';
import 'dart:convert';

import 'package:expatroasters/utils/functions.dart';
import 'package:expatroasters/utils/globalvar.dart';
import 'package:expatroasters/widgets/backscreens/bottomnav_widget.dart';
import 'package:expatroasters/widgets/backscreens/shimmer_widget.dart';
import 'package:expatroasters/widgets/frontscreens/listimage_widget.dart';
import 'package:flutter/material.dart';
import 'package:expatroasters/utils/extensions.dart';
import 'package:get/get.dart';

class ListOutlet extends StatefulWidget {
  const ListOutlet({super.key});

  @override
  State<ListOutlet> createState() => _ListOutletState();
}

class _ListOutletState extends State<ListOutlet> {
  var produkid = Get.arguments[0]["second"];
  dynamic resultData;
  final List<dynamic> imglst = [];
  bool is_loading = true;
  String body = '';

  @override
  void initState() {
    super.initState();
    _asyncMethod();
  }

  Future _asyncMethod() async {
    //get user detail
    var url = Uri.parse("$urlapi/v1/produk/getcabang_byprodukid?id=$produkid");
    var resultData = jsonDecode(await expatAPI(url, body))["messages"];
    setState(() {
      for (var isi in resultData) {
        imglst.add(
            [isi["picture"], isi["nama"], isi["alamat"], isi["id_cabang"]]);
        is_loading = false;
      }
    });

    // setState(() {
    //   resultData = query;
    //   is_loading = false;
    // });
    printDebug(imglst);
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
              onPressed: () => Navigator.of(context).pop(),
            ),
            centerTitle: true,
            title: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: const Text("OUTLET")),
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            elevation: 0,
          ),
          body: SafeArea(
            child: (is_loading)
                ? ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: imglst.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 28.h,
                        margin: EdgeInsets.all(1.w),
                        // color: Color.fromRGBO(131, 173, 152, 1),
                        // child: Center(child: Text('Entry ${imglst[index][0]}')),
                        child: SizedBox(
                          height: 28.h,
                          width: 100.w,
                          child: ShimmerWidget(tinggi: 28.h, lebar: 100.w),
                        ),
                      );
                    },
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: imglst.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 28.h,
                        color: Color.fromRGBO(131, 173, 152, 1),
                        margin: EdgeInsets.all(1.w),
                        // child: Center(child: Text('Entry ${imglst[index][0]}')),
                        child: ListimageView(
                          image: NetworkImage(imglst[index][0]),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent),
                            onPressed: () async {
                              Get.toNamed(
                                "/front-screen/orderdetail",
                                arguments: [
                                  {"idcabang": imglst[index][3]},
                                  {"idproduk": produkid},
                                ],
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  imglst[index][1],
                                  style: const TextStyle(
                                      color: Color.fromRGBO(131, 173, 152, 1),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  width: 100.w,
                                  child: Text(
                                    imglst[index][2],
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                ),
                                SizedBox(height: 0.5.h),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    // separatorBuilder: (BuildContext context, int index) =>
                    //     const Divider(),
                  ),
          ),
          bottomNavigationBar: const Expatnav()),
    );
  }
}
