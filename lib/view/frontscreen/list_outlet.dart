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
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListOutlet extends StatefulWidget {
  const ListOutlet({super.key});

  @override
  State<ListOutlet> createState() => _ListOutletState();
}

class _ListOutletState extends State<ListOutlet> {
  dynamic resultData;
  dynamic lengthData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _asyncMethod();
    // readAllPref();
  }

  Future _asyncMethod() async {
    //get user detail
    String body = '';
    var url = Uri.parse("$urlapi/v1/outlet/get_allcabang");
    resultData = jsonDecode(await expatAPI(url, body))["messages"];
    lengthData = resultData.length;
    setState(() {
      isLoading = false;
    });
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
            child: (isLoading)
                ? SizedBox(
                    child: ShimmerWidget(tinggi: 100.h, lebar: 100.w),
                  )
                : ListView(
                    padding: const EdgeInsets.all(8),
                    children: [
                      for (int i = 0; i < lengthData; i++)
                        // Text(
                        //   "$resultData",
                        //   style: TextStyle(color: Colors.white),
                        // )
                        Container(
                          height: 28.h,
                          color: Color.fromRGBO(131, 173, 152, 1),
                          margin: EdgeInsets.all(1.w),
                          // child: Center(child: Text('Entry ${imglst[index][0]}')),
                          child: ListimageView(
                            image: NetworkImage(resultData[i]['picture']),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent),
                              onPressed: () {
                                // Navigator.of(context).pop();
                                confirmOutlet(
                                    context,
                                    capitalizeFirstLetter(
                                        resultData[i]['nama']),
                                    capitalizeFirstLetter(
                                        resultData[i]['alamat']),
                                    resultData[i]['id']);
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    resultData[i]['nama'],
                                    style: const TextStyle(
                                        color: Color.fromRGBO(131, 173, 152, 1),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    width: 100.w,
                                    child: Text(
                                      resultData[i]['alamat'],
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    ),
                                  ),
                                  SizedBox(height: 0.5.h),
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
          ),
          bottomNavigationBar: const Expatnav(
            number: 2,
          )),
    );
  }

  confirmOutlet(BuildContext context, String nama, String alamat, String id) {
    // set up the buttons
    Widget cancelButton = DecoratedBox(
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Colors.black, Colors.black87]),
        borderRadius: BorderRadius.circular(999.0),
        border: Border.all(color: const Color.fromARGB(255, 219, 219, 219)),
      ),
      child: TextButton(
        child: Text("Change Outlet"),
        style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            padding: EdgeInsets.fromLTRB(5.w, 1.w, 5.w, 1.w)),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );

    Widget continueButton = DecoratedBox(
      decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color.fromRGBO(132, 173, 153, 1),
              Color.fromRGBO(132, 173, 153, 1),
              Color.fromRGBO(132, 173, 153, 1),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(999.0),
          ),
          border: Border.all(color: const Color.fromARGB(255, 219, 219, 219)),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(141, 190, 165, 0.3),
              spreadRadius: 4,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ]),
      child: TextButton(
        child: Text("Confirm"),
        style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            padding: EdgeInsets.fromLTRB(10.w, 1.w, 10.w, 1.w)),
        onPressed: () {
          Get.toNamed(
            "/front-screen/allmenu",
            arguments: [
              {"idcabang": id},
            ],
          );
        },
      ),
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.black,
      content: SizedBox(
        height: 30.h,
        width: 90.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Confirm Outlet",
              style: TextStyle(
                fontFamily: GoogleFonts.lora().fontFamily,
                color: Color.fromRGBO(114, 162, 138, 1),
                fontSize: 26,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            Text(
              "$nama",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              "$alamat",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            )
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            cancelButton,
            SizedBox(
              width: 4.w,
            ),
            continueButton,
          ],
        )
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
