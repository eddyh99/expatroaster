import 'dart:developer';
import 'package:expatroasters/utils/extensions.dart';
import 'package:expatroasters/utils/functions.dart';
import 'package:expatroasters/utils/globalvar.dart';
import 'package:expatroasters/widgets/backscreens/bottomnav_widget.dart';
import 'package:expatroasters/widgets/backscreens/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
  dynamic resultSub;
  final List<dynamic> drink = [];
  final List<dynamic> food = [];
  final List<dynamic> retail = [];

  final List<dynamic> finaldrink = [];
  final List<dynamic> finalfood = [];
  final List<dynamic> finalretail = [];
  bool is_loading = true;

  late final WebViewController wvcontroller;
  var totalorder = '';
  bool isDataReady = true;

  TextEditingController searchController = TextEditingController();
  String searchText = '';

  @override
  void initState() {
    super.initState();
    _asyncMethod();
    wvcontroller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            // print("PROGRESS");
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            // print("FINISH");
            setState(() {
              isDataReady = false;
            });
          },
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..addJavaScriptChannel(
        'Total',
        onMessageReceived: (JavaScriptMessage message) async {
          setState(() {
            totalorder = message.message;
            print(totalorder + "ini total");
          });
        },
      )
      ..loadRequest(Uri.parse("$urlbase/widget/order/getquantitycart"));
  }

  Future _asyncMethod() async {
    //get user detail
    String body = '';
    var url =
        Uri.parse("$urlapi/v1/mobile/produk/getproduk_bycabang?id=$idcabang");
    resultData = jsonDecode(await expatAPI(url, body))["messages"];
    var urlSub = Uri.parse("$urlapi/v1/produk/get_subkategori");
    resultSub = jsonDecode(await expatAPI(urlSub, body))["messages"];
    // printDebug("200 - $resultSub");
    // log('${resultData}');

    setState(() {
      for (var sub in resultSub) {
        String subkategori = sub['subkategori'];
        final List<dynamic> tempdrink = [];
        final List<dynamic> tempfood = [];
        final List<dynamic> tempretail = [];

        for (var product in resultData) {
          if (product['kategori'] == 'drink' &&
              subkategori == product['subkategori']) {
            tempdrink.add([
              product["id"],
              product["picture"],
              product["deskripsi"],
              product["nama"],
              product['price'],
              product['kategori'],
              product['subkategori']
            ]);
          } else if (product['kategori'] == 'food' &&
              subkategori == product['subkategori']) {
            tempfood.add([
              product["id"],
              product["picture"],
              product["deskripsi"],
              product["nama"],
              product['price'],
              product['kategori'],
              product['subkategori']
            ]);
          } else if (product['kategori'] == 'retail' &&
              subkategori == product['subkategori']) {
            tempretail.add([
              product["id"],
              product["picture"],
              product["deskripsi"],
              product["nama"],
              product['price'],
              product['kategori'],
              product['subkategori']
            ]);
          }
        }

        if (tempdrink.isNotEmpty) {
          finaldrink.add([subkategori, tempdrink]);
        }

        if (tempfood.isNotEmpty) {
          finalfood.add([subkategori, tempfood]);
        }

        if (tempretail.isNotEmpty) {
          finalretail.add([subkategori, tempretail]);
        }
      }

      print(finaldrink);

      is_loading = false;
    });
    // log('${finaldrink}');
    // log('${finalfood}');
    // print(finalfood);
  }

  List<dynamic> filterItems(List<dynamic> items, String searchText) {
    return items
        .where(
            (item) => item[3].toLowerCase().contains(searchText.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
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
                icon: Stack(
                  children: [
                    const Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                    (totalorder != '0')
                        ? Positioned(
                            right: 1,
                            child: Icon(
                              Icons.brightness_1,
                              color: Colors.green,
                              size: 12.0,
                            ),
                          )
                        : Text(""),
                  ],
                ),
                color: Colors.white,
                iconSize: 6.5.w,
              ),
            ),
          ],
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.black,
        body: SafeArea(
          child: DefaultTabController(
            length: 3,
            child: Column(
              children: [
                SizedBox(
                  width: 90.w,
                  height: 10.h,
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) {
                      setState(() {
                        searchText = value;
                      });
                    },
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: Icon(
                        Icons.search,
                        size: 20.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 0.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      contentPadding: const EdgeInsets.only(
                          left: 20, bottom: 6, right: 13, top: 6),
                      labelStyle: const TextStyle(color: Colors.white),
                      hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 188, 188, 188),
                          fontSize: 14),
                    ),
                  ),
                ),
                Container(
                  height: 7.h,
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
                                color: const Color.fromRGBO(114, 162, 138, 1)),
                          ),
                          child: const Align(
                            alignment: Alignment.center,
                            child: Text("DRINKS",
                                style: TextStyle(color: Colors.white)),
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
                            child: Text("FOOD",
                                style: TextStyle(color: Colors.white)),
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
                            child: Text("RETAIL",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      // Drinks Tab
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
                            SizedBox(height: 2.h),
                            SizedBox(
                              width: 100.w,
                              height: 59.h,
                              child: ListView.builder(
                                itemCount: is_loading ? 5 : finaldrink.length,
                                itemBuilder: (context, i) {
                                  var resultproduct = is_loading
                                      ? 5
                                      : filterItems(
                                              finaldrink[i][1], searchText)
                                          .length;
                                  final filteredItems = is_loading
                                      ? []
                                      : filterItems(
                                          finaldrink[i][1], searchText);
                                  return is_loading
                                      ? Column(
                                          children: [
                                            ShimmerWidget(
                                                tinggi: 20.h, lebar: 90.w),
                                            SizedBox(height: 2.h),
                                          ],
                                        )
                                      : Column(
                                          children: [
                                            SizedBox(
                                              width: 90.w,
                                              child: Title(
                                                color: Colors.white,
                                                child: Text(
                                                  finaldrink[i][0],
                                                  style: TextStyle(
                                                    fontSize: 24,
                                                    color: const Color.fromRGBO(
                                                        114, 162, 138, 1),
                                                    fontFamily:
                                                        GoogleFonts.lora()
                                                            .fontFamily,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            (is_loading)
                                                ? Column(
                                                    children: [
                                                      ShimmerWidget(
                                                          tinggi: 20.h,
                                                          lebar: 90.w),
                                                      SizedBox(height: 2.h),
                                                    ],
                                                  )
                                                : Column(
                                                    children: List.generate(
                                                        resultproduct, (j) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        Get.toNamed(
                                                          "/front-screen/orderdetail",
                                                          arguments: [
                                                            {
                                                              'idcabang':
                                                                  idcabang
                                                            },
                                                            {
                                                              'idproduk':
                                                                  filteredItems[
                                                                      j][0]
                                                            }
                                                          ],
                                                        );
                                                      },
                                                      child: SizedBox(
                                                        width: 100.w,
                                                        child: Card(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          color: Colors
                                                              .transparent,
                                                          shadowColor: Colors
                                                              .transparent,
                                                          surfaceTintColor:
                                                              Colors
                                                                  .transparent,
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
                                                                        .all(
                                                                        2.0),
                                                                child:
                                                                    ConstrainedBox(
                                                                  constraints:
                                                                      BoxConstraints(
                                                                    maxWidth:
                                                                        35.w,
                                                                    maxHeight:
                                                                        35.h,
                                                                  ),
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12),
                                                                    child: Image
                                                                        .network(
                                                                      filteredItems[
                                                                          j][1],
                                                                      fit: BoxFit
                                                                          .fill,
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
                                                                  SizedBox(
                                                                    width: 50.w,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          10,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                      child:
                                                                          Text(
                                                                        filteredItems[j]
                                                                            [3],
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontSize:
                                                                              18,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 60.w,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          10,
                                                                          2,
                                                                          0,
                                                                          0),
                                                                      child:
                                                                          Text(
                                                                        filteredItems[j]
                                                                            [2],
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          color: Color.fromRGBO(
                                                                              255,
                                                                              255,
                                                                              255,
                                                                              0.7),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 60.w,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          10,
                                                                          5,
                                                                          0,
                                                                          0),
                                                                      child:
                                                                          RichText(
                                                                        text:
                                                                            TextSpan(
                                                                          children: [
                                                                            const WidgetSpan(
                                                                              child: Text(
                                                                                'Rp',
                                                                                style: TextStyle(
                                                                                  color: Color.fromRGBO(114, 162, 138, 1),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            WidgetSpan(
                                                                              child: SizedBox(width: 1.w),
                                                                            ),
                                                                            TextSpan(
                                                                              text: formatter.format(int.parse(
                                                                                filteredItems[j][4],
                                                                              )),
                                                                              style: const TextStyle(
                                                                                color: Color.fromRGBO(114, 162, 138, 1),
                                                                                fontSize: 20,
                                                                              ),
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
                                                    );
                                                  })),
                                            // end of for column
                                            SizedBox(
                                              width: 90.w,
                                              child: const Divider(
                                                color: Color.fromRGBO(
                                                    55, 55, 55, 1),
                                              ),
                                            ),
                                          ],
                                        );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Food Tab
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
                            SizedBox(height: 2.h),
                            SizedBox(
                              width: 100.w,
                              height: 53.h,
                              child: ListView.builder(
                                itemCount: is_loading ? 5 : finalfood.length,
                                itemBuilder: (context, i) {
                                  var resultproduct = is_loading
                                      ? 5
                                      : filterItems(finalfood[i][1], searchText)
                                          .length;
                                  final filteredItems = is_loading
                                      ? []
                                      : filterItems(
                                          finalfood[i][1], searchText);
                                  return is_loading
                                      ? Column(
                                          children: [
                                            ShimmerWidget(
                                                tinggi: 20.h, lebar: 90.w),
                                            SizedBox(height: 2.h),
                                          ],
                                        )
                                      : Column(
                                          children: [
                                            SizedBox(
                                              width: 90.w,
                                              child: Title(
                                                color: Colors.white,
                                                child: Text(
                                                  finalfood[i][0],
                                                  style: TextStyle(
                                                    fontSize: 24,
                                                    color: const Color.fromRGBO(
                                                        114, 162, 138, 1),
                                                    fontFamily:
                                                        GoogleFonts.lora()
                                                            .fontFamily,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            (is_loading)
                                                ? Column(
                                                    children: [
                                                      ShimmerWidget(
                                                          tinggi: 20.h,
                                                          lebar: 90.w),
                                                      SizedBox(height: 2.h),
                                                    ],
                                                  )
                                                : Column(
                                                    children: List.generate(
                                                        resultproduct, (j) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        Get.toNamed(
                                                          "/front-screen/orderdetail",
                                                          arguments: [
                                                            {
                                                              'idcabang':
                                                                  idcabang
                                                            },
                                                            {
                                                              'idproduk':
                                                                  filteredItems[
                                                                      j][0]
                                                            }
                                                          ],
                                                        );
                                                      },
                                                      child: SizedBox(
                                                        width: 100.w,
                                                        child: Card(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          color: Colors
                                                              .transparent,
                                                          shadowColor: Colors
                                                              .transparent,
                                                          surfaceTintColor:
                                                              Colors
                                                                  .transparent,
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
                                                                        .all(
                                                                        2.0),
                                                                child:
                                                                    ConstrainedBox(
                                                                  constraints:
                                                                      BoxConstraints(
                                                                    maxWidth:
                                                                        35.w,
                                                                    maxHeight:
                                                                        35.h,
                                                                  ),
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12),
                                                                    child: Image
                                                                        .network(
                                                                      filteredItems[
                                                                          j][1],
                                                                      fit: BoxFit
                                                                          .fill,
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
                                                                  SizedBox(
                                                                    width: 50.w,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          10,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                      child:
                                                                          Text(
                                                                        filteredItems[j]
                                                                            [3],
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontSize:
                                                                              18,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 60.w,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          10,
                                                                          2,
                                                                          0,
                                                                          0),
                                                                      child:
                                                                          Text(
                                                                        filteredItems[j]
                                                                            [2],
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          color: Color.fromRGBO(
                                                                              255,
                                                                              255,
                                                                              255,
                                                                              0.7),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 60.w,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          10,
                                                                          5,
                                                                          0,
                                                                          0),
                                                                      child:
                                                                          RichText(
                                                                        text:
                                                                            TextSpan(
                                                                          children: [
                                                                            const WidgetSpan(
                                                                              child: Text(
                                                                                'Rp',
                                                                                style: TextStyle(
                                                                                  color: Color.fromRGBO(114, 162, 138, 1),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            WidgetSpan(
                                                                              child: SizedBox(width: 1.w),
                                                                            ),
                                                                            TextSpan(
                                                                              text: formatter.format(int.parse(
                                                                                filteredItems[j][4],
                                                                              )),
                                                                              style: const TextStyle(
                                                                                color: Color.fromRGBO(114, 162, 138, 1),
                                                                                fontSize: 20,
                                                                              ),
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
                                                    );
                                                  })),
                                            // end of for column
                                            SizedBox(
                                              width: 90.w,
                                              child: const Divider(
                                                color: Color.fromRGBO(
                                                    55, 55, 55, 1),
                                              ),
                                            ),
                                          ],
                                        );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Retail Tab
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
                            SizedBox(height: 2.h),
                            // SizedBox(
                            //   width: 90.w,
                            //   child: Padding(
                            //     padding: const EdgeInsets.only(left: 12.0),
                            //     child: Title(
                            //       color: Colors.white,
                            //       child: Text(
                            //         'Retail',
                            //         style: TextStyle(
                            //           fontSize: 24,
                            //           color: const Color.fromRGBO(
                            //               114, 162, 138, 1),
                            //           fontFamily: GoogleFonts.lora().fontFamily,
                            //           fontWeight: FontWeight.w700,
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            SizedBox(
                              width: 100.w,
                              height: 53.h,
                              child: ListView.builder(
                                itemCount: is_loading ? 5 : finalretail.length,
                                itemBuilder: (context, i) {
                                  var resultproduct = is_loading
                                      ? 5
                                      : filterItems(
                                              finalretail[i][1], searchText)
                                          .length;
                                  final filteredItems = is_loading
                                      ? []
                                      : filterItems(
                                          finalretail[i][1], searchText);
                                  return is_loading
                                      ? Column(
                                          children: [
                                            ShimmerWidget(
                                                tinggi: 20.h, lebar: 90.w),
                                            SizedBox(height: 2.h),
                                          ],
                                        )
                                      : Column(
                                          children: [
                                            SizedBox(
                                              width: 90.w,
                                              child: Title(
                                                color: Colors.white,
                                                child: Text(
                                                  finalretail[i][0],
                                                  style: TextStyle(
                                                    fontSize: 24,
                                                    color: const Color.fromRGBO(
                                                        114, 162, 138, 1),
                                                    fontFamily:
                                                        GoogleFonts.lora()
                                                            .fontFamily,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            (is_loading)
                                                ? Column(
                                                    children: [
                                                      ShimmerWidget(
                                                          tinggi: 20.h,
                                                          lebar: 90.w),
                                                      SizedBox(height: 2.h),
                                                    ],
                                                  )
                                                : Column(
                                                    children: List.generate(
                                                        resultproduct, (j) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        Get.toNamed(
                                                          "/front-screen/orderdetail",
                                                          arguments: [
                                                            {
                                                              'idcabang':
                                                                  idcabang
                                                            },
                                                            {
                                                              'idproduk':
                                                                  filteredItems[
                                                                      j][0]
                                                            }
                                                          ],
                                                        );
                                                      },
                                                      child: SizedBox(
                                                        width: 100.w,
                                                        child: Card(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          color: Colors
                                                              .transparent,
                                                          shadowColor: Colors
                                                              .transparent,
                                                          surfaceTintColor:
                                                              Colors
                                                                  .transparent,
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
                                                                        .all(
                                                                        2.0),
                                                                child:
                                                                    ConstrainedBox(
                                                                  constraints:
                                                                      BoxConstraints(
                                                                    maxWidth:
                                                                        35.w,
                                                                    maxHeight:
                                                                        35.h,
                                                                  ),
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12),
                                                                    child: Image
                                                                        .network(
                                                                      filteredItems[
                                                                          j][1],
                                                                      fit: BoxFit
                                                                          .fill,
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
                                                                  SizedBox(
                                                                    width: 50.w,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          10,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                      child:
                                                                          Text(
                                                                        filteredItems[j]
                                                                            [3],
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontSize:
                                                                              18,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 60.w,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          10,
                                                                          2,
                                                                          0,
                                                                          0),
                                                                      child:
                                                                          Text(
                                                                        filteredItems[j]
                                                                            [2],
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          color: Color.fromRGBO(
                                                                              255,
                                                                              255,
                                                                              255,
                                                                              0.7),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 60.w,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          10,
                                                                          5,
                                                                          0,
                                                                          0),
                                                                      child:
                                                                          RichText(
                                                                        text:
                                                                            TextSpan(
                                                                          children: [
                                                                            const WidgetSpan(
                                                                              child: Text(
                                                                                'Rp',
                                                                                style: TextStyle(
                                                                                  color: Color.fromRGBO(114, 162, 138, 1),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            WidgetSpan(
                                                                              child: SizedBox(width: 1.w),
                                                                            ),
                                                                            TextSpan(
                                                                              text: formatter.format(int.parse(
                                                                                filteredItems[j][4],
                                                                              )),
                                                                              style: const TextStyle(
                                                                                color: Color.fromRGBO(114, 162, 138, 1),
                                                                                fontSize: 20,
                                                                              ),
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
                                                    );
                                                  })),
                                            // end of for column
                                            SizedBox(
                                              width: 90.w,
                                              child: const Divider(
                                                color: Color.fromRGBO(
                                                    55, 55, 55, 1),
                                              ),
                                            ),
                                          ],
                                        );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
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
