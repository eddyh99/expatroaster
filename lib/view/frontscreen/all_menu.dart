import 'package:expatroasters/utils/extensions.dart';
import 'package:expatroasters/utils/functions.dart';
import 'package:expatroasters/utils/globalvar.dart';
import 'package:expatroasters/widgets/backscreens/bottomnav_widget.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:expatroasters/widgets/backscreens/async_widget.dart';

class AllMenu extends StatefulWidget {
  const AllMenu({super.key});

  @override
  State<AllMenu> createState() {
    return _AllMenuState();
  }
}

class _AllMenuState extends State<AllMenu> with SingleTickerProviderStateMixin {
  var idcabang = Get.arguments[0]["idcabang"];

  dynamic resultData;
  final List<dynamic> drink = [];
  final List<dynamic> food = [];
  final List<dynamic> retail = [];
  bool is_loading = true;

  @override
  void initState() {
    super.initState();
    _asyncMethod();
    // printDebug(const AsyncTextWidget(pref: "logged", field: "nama"));
  }

  Future _asyncMethod() async {
    //get user detail
    String body = '';
    var url = Uri.parse("$urlapi/v1/produk/getproduk_bycabang?id=$idcabang");
    resultData = jsonDecode(await expatAPI(url, body))["messages"];
    printDebug(resultData);
    for (var isi in resultData) {
      if (isi['kategori'] == 'drink') {
        setState(() {
          drink.add([
            isi["id"],
            isi["picture"],
            isi["deskripsi"],
            isi["nama"],
            isi['harga'],
            isi['kategori']
          ]);
        });
      } else if (isi['kategori'] == 'food') {
        setState(() {
          food.add([
            isi["id"],
            isi["picture"],
            isi["deskripsi"],
            isi["nama"],
            isi['harga'],
            isi['kategori']
          ]);
        });
      } else if (isi['kategori'] == 'retail') {
        setState(() {
          retail.add([
            isi["id"],
            isi["picture"],
            isi["deskripsi"],
            isi["nama"],
            isi['harga'],
            isi['kategori']
          ]);
        });
        is_loading = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          centerTitle: true,
          title: const Text(
            "MENU",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                onPressed: () => {
                  Get.toNamed(
                    "/front-screen/order",
                    arguments: [
                      {"idcabang": idcabang},
                    ],
                  )
                },
                icon: const Icon(Icons.shopping_cart),
                color: Colors.white,
                iconSize: 6.5.w,
              ),
            ),
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.black,
        body: SafeArea(
          child: DefaultTabController(
            length: 3,
            child: Column(children: [
              SizedBox(
                height: 3.h,
              ),
              Container(
                height: 7.5.h,
                color: Colors.black,
                child: TabBar(
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.all(10),
                  unselectedLabelColor: Colors.white,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color.fromRGBO(73, 116, 95, 1),
                  ),
                  dividerColor: Colors.transparent,
                  tabs: [
                    Tab(
                      child: Container(
                        height: 35.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: const Color.fromRGBO(114, 162, 138, 1),
                          ),
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "DRINKS",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        height: 35.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                              color: const Color.fromRGBO(114, 162, 138, 1)),
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "FOOD",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        height: 35.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                              color: const Color.fromRGBO(114, 162, 138, 1)),
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "RETAIL",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    // SizedBox(
                    //   height: 1,
                    // ),
                    ListView(
                      scrollDirection: Axis.vertical,
                      children: [
                        SizedBox(
                          height: 3.h,
                        ),
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(25, 25, 25, 1),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 2.h,
                                      right: 5.w,
                                      bottom: 0,
                                      left: 5.w,
                                    ),
                                    child: Title(
                                      color: Colors.white,
                                      child: const Text(
                                        'Coffe Drink',
                                        style: TextStyle(
                                          fontSize: 30,
                                          color: Color.fromRGBO(
                                            114,
                                            162,
                                            138,
                                            1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  ...drink.map((val) {
                                    return Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 0,
                                              right: 5.w,
                                              bottom: 2.h,
                                              left: 5.w),
                                          child: const Divider(
                                            color:
                                                Color.fromRGBO(55, 55, 55, 1),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: 0,
                                            right: 5.w,
                                            bottom: 0,
                                            left: 5.w,
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              Get.toNamed(
                                                  "/front-screen/orderdetail",
                                                  arguments: [
                                                    {'idcabang': idcabang},
                                                    {'idproduk': val[0]}
                                                  ]);
                                            },
                                            child: Row(
                                              children: [
                                                Image.network(val[1], scale: 3),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10),
                                                      child: Text(
                                                        val[3],
                                                        style: const TextStyle(
                                                            fontSize: 24,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10),
                                                      child: SizedBox(
                                                        width: 50.w,
                                                        child: Text(
                                                          val[2],
                                                          overflow:
                                                              TextOverflow.clip,
                                                          style:
                                                              const TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    0.7),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10),
                                                      child: RichText(
                                                        text:
                                                            TextSpan(children: [
                                                          const WidgetSpan(
                                                            child: Text(
                                                              'Rp',
                                                              //superscript is usually smaller in size

                                                              style: TextStyle(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          114,
                                                                          162,
                                                                          138,
                                                                          1)),
                                                            ),
                                                          ),
                                                          WidgetSpan(
                                                            child: SizedBox(
                                                                width: 1.w),
                                                          ),
                                                          TextSpan(
                                                            text: formatter
                                                                .format(
                                                                    int.parse(
                                                              val[4],
                                                            )),
                                                            style:
                                                                const TextStyle(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            114,
                                                                            162,
                                                                            138,
                                                                            1),
                                                                    fontSize:
                                                                        20),
                                                          ),
                                                        ]),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 2.h,
                                              right: 5.w,
                                              bottom: 2.h,
                                              left: 5.w),
                                          child: const Divider(
                                            color:
                                                Color.fromRGBO(55, 55, 55, 1),
                                          ),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    ListView(
                      scrollDirection: Axis.vertical,
                      children: [
                        SizedBox(
                          height: 3.h,
                        ),
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(25, 25, 25, 1),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 2.h,
                                      right: 5.w,
                                      bottom: 0,
                                      left: 5.w,
                                    ),
                                    child: Title(
                                      color: Colors.white,
                                      child: const Text(
                                        'Sweets',
                                        style: TextStyle(
                                          fontSize: 30,
                                          color: Color.fromRGBO(
                                            114,
                                            162,
                                            138,
                                            1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  ...food.map((val) {
                                    return Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 0,
                                              right: 5.w,
                                              bottom: 2.h,
                                              left: 5.w),
                                          child: const Divider(
                                            color:
                                                Color.fromRGBO(55, 55, 55, 1),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: 0,
                                            right: 5.w,
                                            bottom: 0,
                                            left: 5.w,
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              Get.toNamed(
                                                  "/front-screen/orderdetail",
                                                  arguments: [
                                                    {'idcabang': idcabang},
                                                    {'idproduk': val[0]}
                                                  ]);
                                            },
                                            child: Row(
                                              children: [
                                                Image.network(val[1], scale: 3),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10),
                                                      child: Text(
                                                        val[3],
                                                        style: const TextStyle(
                                                            fontSize: 24,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10),
                                                      child: SizedBox(
                                                        width: 50.w,
                                                        child: Text(
                                                          val[2],
                                                          overflow:
                                                              TextOverflow.clip,
                                                          style:
                                                              const TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    0.7),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10),
                                                      child: RichText(
                                                        text:
                                                            TextSpan(children: [
                                                          const WidgetSpan(
                                                            child: Text(
                                                              'Rp',
                                                              //superscript is usually smaller in size

                                                              style: TextStyle(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          114,
                                                                          162,
                                                                          138,
                                                                          1)),
                                                            ),
                                                          ),
                                                          WidgetSpan(
                                                            child: SizedBox(
                                                                width: 1.w),
                                                          ),
                                                          TextSpan(
                                                            text: formatter
                                                                .format(
                                                                    int.parse(
                                                              val[4],
                                                            )),
                                                            style:
                                                                const TextStyle(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            114,
                                                                            162,
                                                                            138,
                                                                            1),
                                                                    fontSize:
                                                                        20),
                                                          ),
                                                        ]),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 2.h,
                                              right: 5.w,
                                              bottom: 2.h,
                                              left: 5.w),
                                          child: const Divider(
                                            color:
                                                Color.fromRGBO(55, 55, 55, 1),
                                          ),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    ListView(
                      scrollDirection: Axis.vertical,
                      children: [
                        SizedBox(
                          height: 3.h,
                        ),
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(25, 25, 25, 1),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 2.h,
                                      right: 5.w,
                                      bottom: 0,
                                      left: 5.w,
                                    ),
                                    child: Title(
                                      color: Colors.white,
                                      child: const Text(
                                        'Tin 200g',
                                        style: TextStyle(
                                          fontSize: 30,
                                          color: Color.fromRGBO(
                                            114,
                                            162,
                                            138,
                                            1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  ...retail.map((val) {
                                    return Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 0,
                                              right: 5.w,
                                              bottom: 2.h,
                                              left: 5.w),
                                          child: const Divider(
                                            color:
                                                Color.fromRGBO(55, 55, 55, 1),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: 0,
                                            right: 5.w,
                                            bottom: 0,
                                            left: 5.w,
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              Get.toNamed(
                                                  "/front-screen/orderdetail",
                                                  arguments: [
                                                    {'idcabang': idcabang},
                                                    {'idproduk': val[0]}
                                                  ]);
                                            },
                                            child: Row(
                                              children: [
                                                Image.network(val[1], scale: 3),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10),
                                                      child: Text(
                                                        val[3],
                                                        style: const TextStyle(
                                                            fontSize: 24,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10),
                                                      child: SizedBox(
                                                        width: 50.w,
                                                        child: Text(
                                                          val[2],
                                                          overflow:
                                                              TextOverflow.clip,
                                                          style:
                                                              const TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    0.7),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10),
                                                      child: RichText(
                                                        text:
                                                            TextSpan(children: [
                                                          const WidgetSpan(
                                                            child: Text(
                                                              'Rp',
                                                              //superscript is usually smaller in size

                                                              style: TextStyle(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          114,
                                                                          162,
                                                                          138,
                                                                          1)),
                                                            ),
                                                          ),
                                                          WidgetSpan(
                                                            child: SizedBox(
                                                                width: 1.w),
                                                          ),
                                                          TextSpan(
                                                            text: formatter
                                                                .format(
                                                                    int.parse(
                                                              val[4],
                                                            )),
                                                            style:
                                                                const TextStyle(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            114,
                                                                            162,
                                                                            138,
                                                                            1),
                                                                    fontSize:
                                                                        20),
                                                          ),
                                                        ]),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 2.h,
                                              right: 5.w,
                                              bottom: 2.h,
                                              left: 5.w),
                                          child: const Divider(
                                            color:
                                                Color.fromRGBO(55, 55, 55, 1),
                                          ),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ]),
          ),
        ),
        bottomNavigationBar: const Expatnav(),
      ),
    );
  }
}
