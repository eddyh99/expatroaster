import 'package:expatroasters/utils/extensions.dart';
import 'package:expatroasters/utils/functions.dart';
import 'package:expatroasters/utils/globalvar.dart';
import 'package:expatroasters/widgets/backscreens/bottomnav_widget.dart';
import 'package:expatroasters/widgets/backscreens/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
    print(idcabang);
    // printDebug(const AsyncTextWidget(pref: "logged", field: "nama"));
  }

  Future _asyncMethod() async {
    //get user detail
    String body = '';
    var url =
        Uri.parse("$urlapi/v1/mobile/produk/getproduk_bycabang?id=$idcabang");
    resultData = jsonDecode(await expatAPI(url, body))["messages"];
    printDebug("200 - $resultData");

    setState(() {
      for (var isi in resultData) {
        if (isi['kategori'] == 'drink') {
          // setState(() {
          drink.add([
            isi["id"],
            isi["picture"],
            isi["deskripsi"],
            isi["nama"],
            isi['harga'],
            isi['kategori']
          ]);
          // });
        } else if (isi['kategori'] == 'food') {
          // setState(() {
          food.add([
            isi["id"],
            isi["picture"],
            isi["deskripsi"],
            isi["nama"],
            isi['harga'],
            isi['kategori']
          ]);
          // });
        } else if (isi['kategori'] == 'retail') {
          // setState(() {
          retail.add([
            isi["id"],
            isi["picture"],
            isi["deskripsi"],
            isi["nama"],
            isi['harga'],
            isi['kategori']
          ]);
          // });
        }
      }
      is_loading = false;
    });
    print(drink);
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
              onPressed: () => {Get.toNamed("/front-screen/list_outlet")},
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
                icon: const Stack(
                  children: [
                    Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                    Positioned(
                        right: 1,
                        child: Icon(
                          Icons.brightness_1,
                          color: Colors.green,
                          size: 12.0,
                        ))
                  ],
                ),
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
            child: Column(
              children: [
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
                      Container(
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(25, 25, 25, 1),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(25),
                              topLeft: Radius.circular(25)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 2.h,
                            ),
                            SizedBox(
                              width: 90.w,
                              // height: 2.h,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Title(
                                  color: Colors.white,
                                  child: Text(
                                    'Coffee Drink',
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Color.fromRGBO(
                                        114,
                                        162,
                                        138,
                                        1,
                                      ),
                                      fontFamily: GoogleFonts.lora().fontFamily,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 100.w,
                              height: 60.h,
                              child: ListView.builder(
                                itemCount: (is_loading) ? 5 : drink.length,
                                itemBuilder: (context, i) {
                                  return (is_loading)
                                      ? Column(
                                          children: [
                                            ShimmerWidget(
                                                tinggi: 20.h, lebar: 90.w),
                                            SizedBox(
                                              height: 2.h,
                                            )
                                          ],
                                        )
                                      : GestureDetector(
                                          onTap: () {
                                            Get.toNamed(
                                              "/front-screen/orderdetail",
                                              arguments: [
                                                {'idcabang': idcabang},
                                                {'idproduk': drink[i][0]}
                                              ],
                                            );
                                          },
                                          child: SizedBox(
                                            // height: 30.h,
                                            width: 100.w,
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: 100.w,
                                                  child: Card(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    color: Colors.transparent,
                                                    shadowColor:
                                                        Colors.transparent,
                                                    surfaceTintColor:
                                                        Colors.transparent,
                                                    elevation: 10,
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(2.0),
                                                          child: ConstrainedBox(
                                                            constraints:
                                                                BoxConstraints(
                                                              maxWidth: 35.w,
                                                              maxHeight: 35.h,
                                                            ),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12),
                                                              child:
                                                                  Image.network(
                                                                drink[i][1],
                                                                fit:
                                                                    BoxFit.fill,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                              width: 50.w,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .fromLTRB(
                                                                        10,
                                                                        0,
                                                                        0,
                                                                        0),
                                                                child: Text(
                                                                  drink[i][3],
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          18,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 60.w,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .fromLTRB(
                                                                        10,
                                                                        2,
                                                                        0,
                                                                        0),
                                                                child: Text(
                                                                  drink[i][2],
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            255,
                                                                            255,
                                                                            255,
                                                                            0.7),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 60.w,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .fromLTRB(
                                                                        10,
                                                                        5,
                                                                        0,
                                                                        0),
                                                                child: RichText(
                                                                  text:
                                                                      TextSpan(
                                                                    children: [
                                                                      const WidgetSpan(
                                                                        child:
                                                                            Text(
                                                                          'Rp',
                                                                          style:
                                                                              TextStyle(color: Color.fromRGBO(114, 162, 138, 1)),
                                                                        ),
                                                                      ),
                                                                      WidgetSpan(
                                                                        child: SizedBox(
                                                                            width:
                                                                                1.w),
                                                                      ),
                                                                      TextSpan(
                                                                        text: formatter
                                                                            .format(int.parse(
                                                                          drink[i]
                                                                              [
                                                                              4],
                                                                        )),
                                                                        style: const TextStyle(
                                                                            color: Color.fromRGBO(
                                                                                114,
                                                                                162,
                                                                                138,
                                                                                1),
                                                                            fontSize:
                                                                                20),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: 90.w,
                                                  child: const Divider(
                                                    color: Color.fromRGBO(
                                                        55, 55, 55, 1),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(25, 25, 25, 1),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(25),
                              topLeft: Radius.circular(25)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 2.h,
                            ),
                            SizedBox(
                              width: 90.w,
                              // height: 2.h,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Title(
                                  color: Colors.white,
                                  child: Text(
                                    'Sweets',
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Color.fromRGBO(
                                        114,
                                        162,
                                        138,
                                        1,
                                      ),
                                      fontFamily: GoogleFonts.lora().fontFamily,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 100.w,
                              height: 60.h,
                              child: ListView.builder(
                                itemCount: (is_loading) ? 5 : food.length,
                                itemBuilder: (context, i) {
                                  return (is_loading)
                                      ? Column(
                                          children: [
                                            ShimmerWidget(
                                                tinggi: 20.h, lebar: 90.w),
                                            SizedBox(
                                              height: 2.h,
                                            )
                                          ],
                                        )
                                      : GestureDetector(
                                          onTap: () {
                                            Get.toNamed(
                                              "/front-screen/orderdetail",
                                              arguments: [
                                                {'idcabang': idcabang},
                                                {'idproduk': food[i][0]}
                                              ],
                                            );
                                          },
                                          child: SizedBox(
                                            // height: 30.h,
                                            width: 100.w,
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: 100.w,
                                                  child: Card(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              0.0),
                                                    ),
                                                    color: Colors.transparent,
                                                    shadowColor:
                                                        Colors.transparent,
                                                    surfaceTintColor:
                                                        Colors.transparent,
                                                    elevation: 10,
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(2.0),
                                                          child: ConstrainedBox(
                                                            constraints:
                                                                BoxConstraints(
                                                              maxWidth: 35.w,
                                                              maxHeight: 35.h,
                                                            ),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12),
                                                              child:
                                                                  Image.network(
                                                                food[i][1],
                                                                fit:
                                                                    BoxFit.fill,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                              width: 50.w,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .fromLTRB(
                                                                        10,
                                                                        0,
                                                                        0,
                                                                        0),
                                                                child: Text(
                                                                  food[i][3],
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          18,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 60.w,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .fromLTRB(
                                                                        10,
                                                                        2,
                                                                        0,
                                                                        0),
                                                                child: Text(
                                                                  food[i][2],
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            255,
                                                                            255,
                                                                            255,
                                                                            0.7),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 60.w,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .fromLTRB(
                                                                        10,
                                                                        5,
                                                                        0,
                                                                        0),
                                                                child: RichText(
                                                                  text:
                                                                      TextSpan(
                                                                    children: [
                                                                      const WidgetSpan(
                                                                        child:
                                                                            Text(
                                                                          'Rp',
                                                                          style:
                                                                              TextStyle(color: Color.fromRGBO(114, 162, 138, 1)),
                                                                        ),
                                                                      ),
                                                                      WidgetSpan(
                                                                        child: SizedBox(
                                                                            width:
                                                                                1.w),
                                                                      ),
                                                                      TextSpan(
                                                                        text: formatter
                                                                            .format(int.parse(
                                                                          food[i]
                                                                              [
                                                                              4],
                                                                        )),
                                                                        style: const TextStyle(
                                                                            color: Color.fromRGBO(
                                                                                114,
                                                                                162,
                                                                                138,
                                                                                1),
                                                                            fontSize:
                                                                                20),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: 90.w,
                                                  child: const Divider(
                                                    color: Color.fromRGBO(
                                                        55, 55, 55, 1),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(25, 25, 25, 1),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(25),
                              topLeft: Radius.circular(25)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 2.h,
                            ),
                            SizedBox(
                              width: 90.w,
                              // height: 2.h,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Title(
                                  color: Colors.white,
                                  child: Text(
                                    'Retail',
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Color.fromRGBO(
                                        114,
                                        162,
                                        138,
                                        1,
                                      ),
                                      fontFamily: GoogleFonts.lora().fontFamily,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 100.w,
                              height: 60.h,
                              child: ListView.builder(
                                itemCount: (is_loading) ? 5 : retail.length,
                                itemBuilder: (context, i) {
                                  return (is_loading)
                                      ? Column(
                                          children: [
                                            ShimmerWidget(
                                                tinggi: 20.h, lebar: 90.w),
                                            SizedBox(
                                              height: 2.h,
                                            )
                                          ],
                                        )
                                      : GestureDetector(
                                          onTap: () {
                                            Get.toNamed(
                                              "/front-screen/orderdetail",
                                              arguments: [
                                                {'idcabang': idcabang},
                                                {'idproduk': retail[i][0]}
                                              ],
                                            );
                                          },
                                          child: SizedBox(
                                            // height: 30.h,
                                            width: 100.w,
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: 100.w,
                                                  child: Card(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              0.0),
                                                    ),
                                                    color: Colors.transparent,
                                                    shadowColor:
                                                        Colors.transparent,
                                                    surfaceTintColor:
                                                        Colors.transparent,
                                                    elevation: 10,
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(2.0),
                                                          child: ConstrainedBox(
                                                            constraints:
                                                                BoxConstraints(
                                                              maxWidth: 35.w,
                                                              maxHeight: 35.h,
                                                            ),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12),
                                                              child:
                                                                  Image.network(
                                                                retail[i][1],
                                                                fit:
                                                                    BoxFit.fill,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                              width: 50.w,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .fromLTRB(
                                                                        10,
                                                                        0,
                                                                        0,
                                                                        0),
                                                                child: Text(
                                                                  retail[i][3],
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          18,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 60.w,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .fromLTRB(
                                                                        10,
                                                                        2,
                                                                        0,
                                                                        0),
                                                                child: Text(
                                                                  retail[i][2],
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            255,
                                                                            255,
                                                                            255,
                                                                            0.7),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 60.w,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .fromLTRB(
                                                                        10,
                                                                        5,
                                                                        0,
                                                                        0),
                                                                child: RichText(
                                                                  text:
                                                                      TextSpan(
                                                                    children: [
                                                                      const WidgetSpan(
                                                                        child:
                                                                            Text(
                                                                          'Rp',
                                                                          style:
                                                                              TextStyle(color: Color.fromRGBO(114, 162, 138, 1)),
                                                                        ),
                                                                      ),
                                                                      WidgetSpan(
                                                                        child: SizedBox(
                                                                            width:
                                                                                1.w),
                                                                      ),
                                                                      TextSpan(
                                                                        text: formatter
                                                                            .format(int.parse(
                                                                          retail[i]
                                                                              [
                                                                              4],
                                                                        )),
                                                                        style: const TextStyle(
                                                                            color: Color.fromRGBO(
                                                                                114,
                                                                                162,
                                                                                138,
                                                                                1),
                                                                            fontSize:
                                                                                20),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: 90.w,
                                                  child: const Divider(
                                                    color: Color.fromRGBO(
                                                        55, 55, 55, 1),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: const Expatnav(
          number: 2,
        ),
      ),
    );
  }
}
