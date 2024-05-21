import 'dart:convert';

import 'package:expatroasters/utils/functions.dart';
import 'package:expatroasters/utils/globalvar.dart';
import 'package:expatroasters/widgets/backscreens/shimmer_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:expatroasters/utils/extensions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() {
    return _HistoryViewState();
  }
}

class _HistoryViewState extends State<HistoryView> {
  // final String _currentDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  final DateRangePickerController _controller = DateRangePickerController();

  late String _startDate = DateFormat('2020-01-01').format(DateTime.now());
  late String _endDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  late String _showstartDate =
      DateFormat('dd MMMM yyyy').format(DateTime.now());
  late String _showendDate = DateFormat('dd MMMM yyyy').format(DateTime.now());
  // late String _endDate = DateFormat('dd MMMM yyyy').format(DateTime.now());
  dynamic resultPoin, resultTopup, resultOrder, resultUserpoin;
  bool isLoading = true;

  String convertToMonth(String tgl) {
    String bulan = '';
    if (tgl == '01') {
      bulan = 'Jan';
    } else if (tgl == '02') {
      bulan = 'Feb';
    } else if (tgl == '03') {
      bulan = 'Mar';
    } else if (tgl == '04') {
      bulan = 'Apr';
    } else if (tgl == '05') {
      bulan = 'May';
    } else if (tgl == '06') {
      bulan = 'Jun';
    } else if (tgl == '07') {
      bulan = 'Jul';
    } else if (tgl == '08') {
      bulan = 'Aug';
    } else if (tgl == '09') {
      bulan = 'Sep';
    } else if (tgl == '10') {
      bulan = 'Oct';
    } else if (tgl == '11') {
      bulan = 'Nov';
    } else if (tgl == '12') {
      bulan = 'Dec';
    }
    return bulan;
  }

  String totalOrder(String total) {
    var allorder = int.parse(total);
    allorder -= 1;
    return "Total +$allorder more";
  }

  Future selectionSubmit(DateRangePickerSelectionChangedArgs args) async {
    setState(() {
      _startDate =
          DateFormat('yyyy-MM-dd').format(args.value.startDate).toString();
      _endDate = DateFormat('yyyy-MM-dd')
          .format(args.value.endDate ?? args.value.startDate)
          .toString();

      _showstartDate =
          DateFormat('dd MMMM yyyy').format(args.value.startDate).toString();
      _showendDate = DateFormat('dd MMMM yyyy')
          .format(args.value.endDate ?? args.value.startDate)
          .toString();
    });
    // print(object)
  }

  Future _userpoin() async {
    //get user detail
    String body = '';
    var url = Uri.parse("$urlapi/v1/mobile/member/get_userdetail");
    resultUserpoin = jsonDecode(await expatAPI(url, body))["messages"];
    setState(() {
      isLoading = false;
      print(resultUserpoin);
    });
  }

  Future _historyPoin() async {
    //get user detail
    String body = '';
    var url = Uri.parse(
        "$urlapi/v1/mobile/history/history_poin?start_date=$_startDate&end_date=$_endDate");
    resultPoin = jsonDecode(await expatAPI(url, body))["messages"];
    setState(() {
      isLoading = false;
    });
    // print(resultPoin[1]['tanggal']);
  }

  Future _historyTopup() async {
    String body = '';
    var url = Uri.parse(
        "$urlapi/v1/mobile/history/history_topup?start_date=$_startDate&end_date=$_endDate");
    resultTopup = jsonDecode(await expatAPI(url, body))["messages"];
    setState(() {
      isLoading = false;
    });
    // print(resultTopup[1]['tanggal']);
  }

  Future _historyOrder() async {
    //get user detail
    String body = '';
    var url = Uri.parse(
        "$urlapi/v1/mobile/history/history_transaksi?start_date=$_startDate&end_date=$_endDate");
    resultOrder = jsonDecode(await expatAPI(url, body))["messages"];
    setState(() {
      isLoading = false;
    });
    // print(resultTopup[1]['tanggal']);
  }

  @override
  void initState() {
    super.initState();
    _historyPoin();
    _historyTopup();
    _historyOrder();
    _userpoin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: const Text("HISTORY")),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Center(
          child: Column(
            children: [
              SizedBox(
                width: 80.w,
                height: 22.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20), // Image border
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(48), // Image radius
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        image: DecorationImage(
                          image: AssetImage(
                              "assets/images/background-profile.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 3.h),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 2.h,
                            ),
                            Text(
                              "EXPAT. ROASTERS POINTS".toUpperCase(),
                              style: const TextStyle(
                                  color: Colors.white54, fontSize: 12),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Text(
                              (resultUserpoin == null ||
                                      resultUserpoin['poin'] == null)
                                  ? "0"
                                  : formatter.format(
                                      int.parse(resultUserpoin["poin"])),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 40),
                            ),
                          ],
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
                width: 90.w,
                height: 10.h,
                child: ElevatedButton(
                  style: ButtonStyle(
                      foregroundColor: MaterialStatePropertyAll(Colors.white),
                      backgroundColor: MaterialStatePropertyAll(Colors.black),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Colors.white)))),
                  onPressed: () {
                    showDialog<Container>(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          padding: EdgeInsets.all(2.h),
                          child: SfDateRangePicker(
                            showActionButtons: true,
                            selectionMode: DateRangePickerSelectionMode.range,
                            controller: _controller,
                            onSelectionChanged: selectionSubmit,
                            onSubmit: (value) {
                              isLoading = true;
                              _historyPoin();
                              _historyTopup();
                              _historyOrder();
                              Navigator.pop(context);
                              print(value);
                            },
                            onCancel: () {
                              Navigator.pop(context);
                            },
                          ),
                        );
                      },
                    );
                  },
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Date",
                              style: TextStyle(fontSize: 11),
                            ),
                            Text("$_showstartDate - $_showendDate"),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                            alignment: Alignment.centerRight,
                            child: Icon(Icons.arrow_drop_down)),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 100.w,
                child: DefaultTabController(
                  length: 3,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 3.h,
                      ),
                      Container(
                        height: 8.h,
                        width: 95.w,
                        color: Color.fromRGBO(14, 14, 18, 1),
                        child: TabBar(
                          physics: const ClampingScrollPhysics(),
                          padding: const EdgeInsets.all(6),
                          unselectedLabelColor: Colors.white,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: const Color.fromRGBO(73, 116, 95, 1),
                          ),
                          dividerColor: Colors.transparent,
                          tabs: [
                            Tab(
                              child: Container(
                                height: 30.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: const Color.fromRGBO(
                                        255, 255, 255, 0.15),
                                  ),
                                ),
                                child: const Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "POINT",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                ),
                              ),
                            ),
                            Tab(
                              child: Container(
                                height: 30.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                      color: const Color.fromRGBO(
                                          255, 255, 255, 0.15)),
                                ),
                                child: const Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "TOP UP",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                ),
                              ),
                            ),
                            Tab(
                              child: Container(
                                height: 30.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                      color: const Color.fromRGBO(
                                          255, 255, 255, 0.15)),
                                ),
                                child: const Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "PURCHASE",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
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
                              padding: EdgeInsets.all(20),
                              child: ListView.builder(
                                itemCount:
                                    resultPoin == null ? 3 : resultPoin.length,
                                reverse: true,
                                itemBuilder: (context, i) {
                                  return (isLoading)
                                      ? Column(
                                          children: [
                                            ShimmerWidget(
                                                tinggi: 10.h, lebar: 90.w),
                                            SizedBox(
                                              height: 2.h,
                                            )
                                          ],
                                        )
                                      : Column(
                                          children: [
                                            ElevatedButton(
                                              style: ButtonStyle(
                                                padding:
                                                    const MaterialStatePropertyAll(
                                                        EdgeInsets.all(10)),
                                                foregroundColor:
                                                    const MaterialStatePropertyAll(
                                                        Colors.white),
                                                backgroundColor:
                                                    const MaterialStatePropertyAll(
                                                        Colors.black),
                                                shape:
                                                    MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    side: const BorderSide(
                                                      color: Color.fromRGBO(
                                                          53, 53, 66, 1),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              onPressed: () {},
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 15.w,
                                                    height: 15.w,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: const Color
                                                            .fromRGBO(
                                                            53, 53, 66, 1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          convertToMonth((resultPoin ==
                                                                      null)
                                                                  ? "0"
                                                                  : resultPoin[
                                                                              i]
                                                                          [
                                                                          'tanggal']
                                                                      .substring(
                                                                          5,
                                                                          7)) +
                                                              "\n" +
                                                              ((resultPoin ==
                                                                      null)
                                                                  ? "0"
                                                                  : resultPoin[
                                                                              i]
                                                                          [
                                                                          'tanggal']
                                                                      .substring(
                                                                          8,
                                                                          10)),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 2.w,
                                                  ),
                                                  SizedBox(
                                                    width: 55.w,
                                                    child: Container(
                                                      child: Text(
                                                        (resultPoin == null)
                                                            ? "0"
                                                            : resultPoin[i]
                                                                    ['poin'] +
                                                                ' Points',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 2.h,
                                            ),
                                          ],
                                        );
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(20),
                              child: ListView.builder(
                                itemCount: resultTopup == null
                                    ? 3
                                    : resultTopup.length,
                                reverse: true,
                                itemBuilder: (context, i) {
                                  return (isLoading)
                                      ? Column(
                                          children: [
                                            ShimmerWidget(
                                                tinggi: 10.h, lebar: 90.w),
                                            SizedBox(
                                              height: 2.h,
                                            )
                                          ],
                                        )
                                      : Column(
                                          children: [
                                            ElevatedButton(
                                              style: ButtonStyle(
                                                padding:
                                                    const MaterialStatePropertyAll(
                                                        EdgeInsets.all(10)),
                                                foregroundColor:
                                                    const MaterialStatePropertyAll(
                                                        Colors.white),
                                                backgroundColor:
                                                    const MaterialStatePropertyAll(
                                                        Colors.black),
                                                shape:
                                                    MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    side: const BorderSide(
                                                      color: Color.fromRGBO(
                                                          53, 53, 66, 1),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              onPressed: () {},
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 15.w,
                                                    height: 15.w,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: const Color
                                                            .fromRGBO(
                                                            53, 53, 66, 1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          convertToMonth((resultTopup ==
                                                                      null)
                                                                  ? "0"
                                                                  : resultTopup[
                                                                              i]
                                                                          [
                                                                          'tanggal']
                                                                      .substring(
                                                                          5,
                                                                          7)) +
                                                              "\n" +
                                                              ((resultTopup ==
                                                                      null)
                                                                  ? "0"
                                                                  : resultTopup[
                                                                              i]
                                                                          [
                                                                          'tanggal']
                                                                      .substring(
                                                                          8,
                                                                          10)),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 2.w,
                                                  ),
                                                  SizedBox(
                                                    width: 55.w,
                                                    child: Container(
                                                      child: Text(
                                                        (resultTopup == null)
                                                            ? "0"
                                                            : 'Rp ${formatter.format(
                                                                int.parse(
                                                                  resultTopup[i]
                                                                      [
                                                                      'nominal'],
                                                                ),
                                                              )}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 2.h,
                                            ),
                                          ],
                                        );
                                },
                              ),
                            ),
                            // Display Purchase
                            Container(
                              padding: EdgeInsets.all(20),
                              child: ListView.builder(
                                itemCount: resultOrder == null
                                    ? 3
                                    : resultOrder.length,
                                reverse: true,
                                itemBuilder: (context, i) {
                                  return (isLoading)
                                      ? Column(
                                          children: [
                                            ShimmerWidget(
                                                tinggi: 10.h, lebar: 90.w),
                                            SizedBox(
                                              height: 2.h,
                                            )
                                          ],
                                        )
                                      : Column(
                                          children: [
                                            ElevatedButton(
                                              style: ButtonStyle(
                                                padding:
                                                    const MaterialStatePropertyAll(
                                                        EdgeInsets.all(10)),
                                                foregroundColor:
                                                    const MaterialStatePropertyAll(
                                                        Colors.white),
                                                backgroundColor:
                                                    const MaterialStatePropertyAll(
                                                        Colors.black),
                                                shape:
                                                    MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    side: const BorderSide(
                                                      color: Color.fromRGBO(
                                                          53, 53, 66, 1),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              onPressed: () {
                                                Get.toNamed(
                                                    'front-screen/historyorder',
                                                    arguments: [
                                                      {
                                                        'id_transaksi':
                                                            resultOrder[i]
                                                                ['id_transaksi']
                                                      }
                                                    ]);
                                              },
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 15.w,
                                                    height: 20.w,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: const Color
                                                            .fromRGBO(
                                                            53, 53, 66, 1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          convertToMonth((resultOrder ==
                                                                      null)
                                                                  ? "0"
                                                                  : resultOrder[
                                                                              i]
                                                                          [
                                                                          'tanggal']
                                                                      .substring(
                                                                          5,
                                                                          7)) +
                                                              "\n" +
                                                              ((resultOrder ==
                                                                      null)
                                                                  ? "0"
                                                                  : resultOrder[
                                                                              i]
                                                                          [
                                                                          'tanggal']
                                                                      .substring(
                                                                          8,
                                                                          10)),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 2.w,
                                                  ),
                                                  SizedBox(
                                                    width: 55.w,
                                                    child: Container(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            (resultOrder ==
                                                                    null)
                                                                ? 'nama'
                                                                : resultOrder[i]
                                                                    ['nama'],
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                          Text(
                                                            '( ${resultOrder[i]['id_transaksi']} )',
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white60,
                                                                fontSize: 12),
                                                          ),
                                                          ((resultOrder[i][
                                                                      'total'] ==
                                                                  '1')
                                                              ? const Text(
                                                                  "Total 1",
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white60,
                                                                      fontSize:
                                                                          12),
                                                                )
                                                              : Text(
                                                                  totalOrder(
                                                                      resultOrder[
                                                                              i]
                                                                          [
                                                                          'total']),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white60,
                                                                      fontSize:
                                                                          12),
                                                                )),
                                                          // Text(
                                                          //   resultOrder[i]
                                                          //       ['total'],
                                                          //   overflow:
                                                          //       TextOverflow
                                                          //           .ellipsis,
                                                          //   style: TextStyle(
                                                          //       color: Colors
                                                          //           .white60,
                                                          //       fontSize: 12),
                                                          // ),
                                                          Text(
                                                            (resultOrder[i][
                                                                        'is_proses'] ==
                                                                    null)
                                                                ? 'is proses'
                                                                : resultOrder[i]
                                                                    [
                                                                    'is_proses'],
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                color: (resultOrder[i]
                                                                            [
                                                                            'is_proses'] ==
                                                                        'pending')
                                                                    ? Color
                                                                        .fromARGB(
                                                                            255,
                                                                            255,
                                                                            178,
                                                                            24)
                                                                    : (resultOrder[i]['is_proses'] ==
                                                                            'complete')
                                                                        ? Colors
                                                                            .green
                                                                        : Colors
                                                                            .white,
                                                                fontSize: 12),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 2.h,
                                            ),
                                          ],
                                        );
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
