import 'dart:async';
import 'dart:convert';

import 'package:expatroasters/utils/functions.dart';
import 'package:expatroasters/utils/globalvar.dart';
import 'package:expatroasters/widgets/backscreens/bottomnav_widget.dart';
import 'package:expatroasters/widgets/backscreens/shimmer_widget.dart';
import 'package:expatroasters/widgets/frontscreens/listimage_widget.dart';
import 'package:flutter/material.dart';
import 'package:expatroasters/utils/extensions.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ListOutlet extends StatefulWidget {
  const ListOutlet({super.key});

  @override
  State<ListOutlet> createState() => _ListOutletState();
}

const List<String> provinsi = [
  'Bali',
  'Surabaya',
  'Jakarta',
  'Yogyakarta',
  'Makassar',
  'Semarang',
  'Medan',
  'Bandung',
  'Tanggerang',
  'Balikpapan',
];

class _ListOutletState extends State<ListOutlet> {
  dynamic resultData;
  dynamic lengthData;
  bool isLoading = true;
  String? _currentDistrict;
  Position? _currentPosition;
  String? dropdownValue = provinsi.first;
  //final WebViewController wvcontroller;
  final List<String> kota = [];

  @override
  void initState() {
    super.initState();
    _asyncMethod();
    _getCurrentPosition();
  }

  Future _asyncMethod() async {
    //get user detail
    String body = '';
    var url = Uri.parse("$urlapi/v1/outlet/get_allcabang");
    resultData = jsonDecode(await expatAPI(url, body))["messages"];
    lengthData = resultData.length;
    printDebug(resultData);
    setState(() {
      for (var dt in resultData) {
        if (!kota.contains(dt['provinsi'])) {
          kota.add(dt['provinsi']);
        }
      }
      isLoading = false;
    });
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showAlert('Location services are disabled. Please enable the services',
          context);
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showAlert('Location permissions are denied', context);
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      showAlert(
          'Location permissions are permanently denied, we cannot request permissions.',
          context);
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
      print(_currentPosition);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentDistrict = place.administrativeArea;
        if (_currentDistrict == 'Bali') {
          _currentDistrict = "Bali";
        } else if (_currentDistrict == 'Daerah Khusus Ibukota Jakarta') {
          _currentDistrict = "Jakarta";
        } else if (_currentDistrict == 'Daerah Istimewa Yogyakarta') {
          _currentDistrict = "Yogyakarta";
        } else {
          _currentDistrict = place.subAdministrativeArea;
          if (_currentDistrict == "Kota Makassar") {
            _currentDistrict = "Makassar";
          } else if (_currentDistrict == "Kota Semarang") {
            _currentDistrict = "Semarang";
          } else if (_currentDistrict == "Kota Medan") {
            _currentDistrict = "Medan";
          } else if (_currentDistrict == "Kota Bandung") {
            _currentDistrict = "Bandung";
          } else if (_currentDistrict == "Kota Tanggerang") {
            _currentDistrict = "Tanggerang";
          } else if (_currentDistrict == "Balikpapan City") {
            _currentDistrict = "Balikpapan";
          }
        }
        dropdownValue = _currentDistrict;
      });
    }).catchError((e) {
      debugPrint(e);
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
              onPressed: () => Get.toNamed('front-screen/home'),
            ),
            centerTitle: true,
            title: Text(
              "SELECT OUTLET",
              style: TextStyle(fontSize: 20),
            ),
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
                      SizedBox(
                        width: 90.w,
                        height: 12.h,
                        child: Center(
                          child: DropdownMenu(
                            menuStyle: MenuStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith((states) {
                                return Colors
                                    .white; //your desired selected background color
                              }),
                            ),
                            width: 90.w,
                            initialSelection: dropdownValue,
                            onSelected: (String? value) {
                              setState(() {
                                dropdownValue = value!;
                              });
                              // Call API
                            },
                            dropdownMenuEntries: kota
                                .map<DropdownMenuEntry<String>>((String value) {
                              return DropdownMenuEntry<String>(
                                  value: value,
                                  label: value,
                                  style: MenuItemButton.styleFrom(
                                    foregroundColor:
                                        Color.fromRGBO(47, 47, 47, 1),
                                    //text color
                                  ));
                            }).toList(),
                            inputDecorationTheme: InputDecorationTheme(
                              constraints: BoxConstraints(maxHeight: 10.h),
                              isDense: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            textStyle: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      for (int i = 0; i < lengthData; i++)
                        if (resultData[i]["provinsi"] == dropdownValue)
                          Column(
                            children: [
                              SizedBox(
                                height: 2.h,
                              ),
                              Container(
                                height: 28.h,
                                // color: Color.fromRGBO(131, 173, 152, 1),
                                margin: EdgeInsets.all(1.w),
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(25, 255, 255, 255),
                                    borderRadius: BorderRadius.circular(10)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: ListimageView(
                                    image:
                                        NetworkImage(resultData[i]['picture']),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(0),
                                        ),
                                        backgroundColor:
                                            Color.fromARGB(55, 0, 0, 0),
                                        shadowColor:
                                            const Color.fromARGB(182, 0, 0, 0),
                                      ),
                                      // backgroundColor: Colors.transparent,
                                      // shadowColor: Colors.transparent),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            resultData[i]['nama'],
                                            style: const TextStyle(
                                                color: Color.fromRGBO(
                                                    131, 173, 152, 1),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          SizedBox(
                                            width: 100.w,
                                            child: Text(
                                              resultData[i]['alamat'],
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                          SizedBox(height: 0.5.h),
                                          SizedBox(
                                            width: 100.w,
                                            child: Text(
                                              "OPERATIONAL HOUR",
                                              style: const TextStyle(
                                                  color: Color.fromRGBO(
                                                      131, 173, 152, 1),
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                          SizedBox(height: 0.5.h),
                                          SizedBox(
                                            width: 100.w,
                                            child: Text(
                                              resultData[i]['opening'],
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                          SizedBox(height: 0.5.h),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                    ],
                  ),
          ),
          // floatingActionButton: favoriteButton(),
          // floatingActionButtonLocation:
          //     FloatingActionButtonLocation.centerFloat,
          bottomNavigationBar: const Expatnav(
            number: 2,
          )),
    );
  }

  confirmOutlet(BuildContext context, String nama, String alamat, String id) {
    // set up the buttons
    Widget cancelButton = SizedBox(
        width: 30.w,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient:
                const LinearGradient(colors: [Colors.black, Colors.black87]),
            borderRadius: BorderRadius.circular(999.0),
            border: Border.all(color: const Color.fromARGB(255, 219, 219, 219)),
          ),
          child: TextButton(
            style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h)),
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Change"),
          ),
        ));

    Widget continueButton = SizedBox(
        width: 30.w,
        child: DecoratedBox(
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
              border:
                  Border.all(color: const Color.fromARGB(255, 219, 219, 219)),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(141, 190, 165, 0.3),
                  spreadRadius: 4,
                  blurRadius: 10,
                  offset: Offset(0, 3),
                ),
              ]),
          child: TextButton(
            style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h)),
            onPressed: () {
              var wvcontroller = WebViewController();
              wvcontroller
                  .loadRequest(Uri.parse("$urlbase/widget/order/removecookie"));
              Get.toNamed(
                "/front-screen/allmenu",
                arguments: [
                  {"idcabang": id},
                ],
              );
            },
            child: const Text("Confirm"),
          ),
        ));
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
                color: const Color.fromRGBO(114, 162, 138, 1),
                fontSize: 26,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            Text(
              nama,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              alamat,
              textAlign: TextAlign.center,
              style: const TextStyle(
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
