import 'dart:convert';
import 'dart:ffi';

import 'package:expatroasters/utils/extensions.dart';
import 'package:expatroasters/utils/functions.dart';
import 'package:expatroasters/utils/globalvar.dart';
import 'package:expatroasters/widgets/backscreens/shimmer_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailHistoryOrder extends StatefulWidget {
  const DetailHistoryOrder({super.key});

  @override
  State<DetailHistoryOrder> createState() {
    return _DetailHistoryOrderState();
  }
}

class _DetailHistoryOrderState extends State<DetailHistoryOrder> {
  bool isLoading = true;
  dynamic resultData;
  var idtransaksi = Get.arguments[0]["id_transaksi"];
  num price = 0;

  Future _historyOrder() async {
    String body = '';
    var url = Uri.parse(
        "$urlapi/v1/mobile/history/history_byinvoice?invoice=$idtransaksi");
    resultData = jsonDecode(await expatAPI(url, body))["messages"];
    setState(() {
      for (var data in resultData) {
        var temp;
        temp = int.parse(data['jumlah']) * int.parse(data['harga']);
        price += temp;
      }
      print(price);
      isLoading = false;
    });
    // print(resultData);
  }

  @override
  void initState() {
    super.initState();
    _historyOrder();
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
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: const Text("HISTORY ORDER")),
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
                  height: 4.h,
                ),
                SizedBox(
                  width: 90.w,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: 20.w,
                          child: Image.asset('assets/images/logo.png')),
                      SizedBox(
                        width: 70.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ((isLoading)
                                ? ShimmerWidget(tinggi: 2.h, lebar: 40.w)
                                : Text(
                                    resultData[0]['tanggal'],
                                    style: TextStyle(color: Colors.white),
                                    textAlign: TextAlign.end,
                                  )),
                            SizedBox(
                              height: 1.h,
                            ),
                            ((isLoading)
                                ? ShimmerWidget(tinggi: 2.h, lebar: 30.w)
                                : Text(
                                    idtransaksi,
                                    style: TextStyle(color: Colors.white),
                                    textAlign: TextAlign.end,
                                  )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                SizedBox(
                  width: 100.w,
                  child: Divider(
                    height: 2,
                    color: Colors.white24,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                ((isLoading)
                    ? Text("")
                    : (resultData[0]['id_pengiriman'] == null)
                        ? Column(
                            children: [
                              SizedBox(
                                width: 90.w,
                                child: Text(
                                  "Pickup details",
                                  style: TextStyle(color: Colors.white54),
                                ),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              ((isLoading)
                                  ? SizedBox(
                                      width: 90.w,
                                      child: ShimmerWidget(
                                          tinggi: 2.h, lebar: 30.w))
                                  : SizedBox(
                                      width: 90.w,
                                      child: Text(
                                        (isLoading)
                                            ? ""
                                            : resultData[0]['cabang'],
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    )),
                              ((isLoading)
                                  ? SizedBox(
                                      width: 90.w,
                                      child: ShimmerWidget(
                                          tinggi: 2.h, lebar: 30.w))
                                  : SizedBox(
                                      width: 90.w,
                                      child: Text(
                                        (isLoading)
                                            ? ""
                                            : resultData[0]['almtcabang'],
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                    )),
                              SizedBox(
                                height: 4.h,
                              ),
                              SizedBox(
                                width: 100.w,
                                child: Divider(
                                  height: 2,
                                  color: Colors.white24,
                                ),
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              SizedBox(
                                width: 90.w,
                                child: Text(
                                  "Delivery details",
                                  style: TextStyle(color: Colors.white54),
                                ),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              SizedBox(
                                width: 80.w,
                                child: Text(
                                  "From",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ),
                              ((isLoading)
                                  ? SizedBox(
                                      width: 80.w,
                                      child: ShimmerWidget(
                                          tinggi: 2.h, lebar: 30.w))
                                  : SizedBox(
                                      width: 80.w,
                                      child: Text(
                                        (isLoading)
                                            ? ""
                                            : resultData[0]['nama'],
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    )),
                              SizedBox(
                                height: 1.h,
                              ),
                              SizedBox(
                                height: 4.h,
                                width: 80.w,
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  child: VerticalDivider(
                                    color: Colors.white38,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              SizedBox(
                                width: 80.w,
                                child: Text(
                                  "To",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ),
                              ((isLoading)
                                  ? SizedBox(
                                      width: 80.w,
                                      child: ShimmerWidget(
                                          tinggi: 4.h, lebar: 30.w))
                                  : SizedBox(
                                      width: 80.w,
                                      child: Text(
                                        '${resultData[0]['title']},\n${resultData[0]['alamat']} - ${resultData[0]['phone']}',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    )),
                              SizedBox(
                                height: 4.h,
                              ),
                              SizedBox(
                                width: 100.w,
                                child: Divider(
                                  height: 2,
                                  color: Colors.white24,
                                ),
                              ),
                            ],
                          )),
                SizedBox(
                  width: 90.w,
                  // height: 70.w,
                  child: Container(
                    // padding: EdgeInsets.all(20),
                    child: ListView.builder(
                      itemCount: resultData == null ? 3 : resultData.length,
                      shrinkWrap: true,
                      itemBuilder: (context, i) {
                        return (isLoading)
                            ? Column(
                                children: [
                                  ShimmerWidget(tinggi: 10.h, lebar: 90.w),
                                  SizedBox(
                                    height: 2.h,
                                  )
                                ],
                              )
                            : Column(
                                children: [
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      padding: const MaterialStatePropertyAll(
                                          EdgeInsets.all(10)),
                                      foregroundColor:
                                          const MaterialStatePropertyAll(
                                              Colors.white),
                                      backgroundColor:
                                          const MaterialStatePropertyAll(
                                              Colors.black),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          side: const BorderSide(
                                            color:
                                                Color.fromRGBO(53, 53, 66, 1),
                                          ),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 55.w,
                                          child: Container(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${resultData[i]['nama']}',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      (resultData[i][
                                                                  'optional'] ==
                                                              null)
                                                          ? ""
                                                          : resultData[i]
                                                              ['optional'],
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white70,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 2.w,
                                                    ),
                                                    Text(
                                                      (resultData[i][
                                                                  'additional'] ==
                                                              null)
                                                          ? ""
                                                          : resultData[i]
                                                              ['additional'],
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white70,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  (resultData[i]['satuan'] ==
                                                          null)
                                                      ? ""
                                                      : resultData[i]['satuan'],
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white70,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 25.w,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                '${resultData[i]['jumlah']}',
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white70,
                                                ),
                                              ),
                                              Text(
                                                'Rp ${formatter.format(int.parse(resultData[i]['harga']))}',
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white70,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                SizedBox(
                  width: 100.w,
                  child: Divider(
                    height: 2,
                    color: Colors.white24,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                SizedBox(
                  width: 90.w,
                  child: Text(
                    "Payment details",
                    style: TextStyle(color: Colors.white54),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                SizedBox(
                  width: 90.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Method",
                        style: TextStyle(color: Colors.white54, fontSize: 12),
                      ),
                      Text(
                        (isLoading) ? "" : resultData[0]['carabayar'],
                        style: TextStyle(color: Colors.white54, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                SizedBox(
                  width: 90.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Price",
                        style: TextStyle(color: Colors.white54, fontSize: 12),
                      ),
                      Text(
                        'Rp ${formatter.format(price)}',
                        style: TextStyle(color: Colors.white54, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                SizedBox(
                  width: 90.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Handling & Delivery Fee",
                        style: TextStyle(color: Colors.white54, fontSize: 12),
                      ),
                      Text(
                        'Rp 0',
                        style: TextStyle(color: Colors.white54, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                SizedBox(
                  width: 90.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Discount",
                        style: TextStyle(color: Colors.white54, fontSize: 12),
                      ),
                      Text(
                        'Rp 0',
                        style: TextStyle(color: Colors.white54, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                SizedBox(
                  width: 90.w,
                  child: Divider(
                    height: 2,
                    color: Colors.white12,
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                SizedBox(
                  width: 90.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total",
                        style: TextStyle(color: Colors.white54, fontSize: 12),
                      ),
                      Text(
                        'Rp ${formatter.format(price)}',
                        style: TextStyle(color: Colors.white54, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
