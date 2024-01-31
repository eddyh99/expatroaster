import 'package:expatroaster/utils/extensions.dart';
import 'package:expatroaster/widgets/backscreens/bottomnav_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopupView extends StatefulWidget {
  const TopupView({Key? key}) : super(key: key);

  @override
  State<TopupView> createState() {
    return _TopupViewState();
  }
}

class _TopupViewState extends State<TopupView> {
  var localData = Get.arguments[0]["first"];
  final TextEditingController _amountText = TextEditingController();
  int value = 0;
  int selectedOption = 0;

  @override
  void initState() {
    super.initState();
  }

  Widget customRadioButton(String text, int index) {
    return SizedBox(
        width: 28.w,
        child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: (value == index)
                            ? const BorderSide(
                                color: Color.fromRGBO(114, 162, 138, 1))
                            : const BorderSide(color: Colors.white)))),
            onPressed: () {
              setState(() {
                value = index;
              });
            },
            child: RichText(
              text: TextSpan(
                text: "Rp ",
                style: TextStyle(
                    color: (value == index) ? Colors.green : Colors.black,
                    fontSize: 10,
                    fontWeight: FontWeight.bold),
                children: [
                  TextSpan(text: text),
                ],
              ),
            )));
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
              title: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: const Text("TOPUP")),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: SafeArea(
                child: SingleChildScrollView(
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 2.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "SELECT TOP-UP VALUE",
                              style: TextStyle(color: Colors.white),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                customRadioButton("50.000", 1),
                                customRadioButton("100.000", 2),
                                customRadioButton("200.000", 3),
                              ],
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                customRadioButton("300.000", 4),
                                customRadioButton("500.000", 5),
                                customRadioButton("1.000.000", 6),
                              ],
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            SizedBox(
                              width: 100.w,
                              child: TextFormField(
                                style: const TextStyle(color: Colors.white),
                                controller: _amountText,
                                maxLines: 1,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 0.0),
                                  ),
                                  isDense: true,
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 0.0),
                                  ),
                                  hintText: 'Enter specific value',
                                  hintStyle: TextStyle(color: Colors.white),
                                ),
                                onChanged: (text) {
                                  if (text.isNotEmpty) {
                                    setState(() {
                                      value = 0;
                                    });
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            const Text("PAYMENT METHOD (by Doku)",
                                style: TextStyle(color: Colors.white)),
                            SizedBox(
                              height: 3.h,
                            ),
                            SizedBox(
                              width: 100.w,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Radio<int>(
                                        value: 1,
                                        groupValue: selectedOption,
                                        activeColor: Colors
                                            .grey, // Change the active radio button color here
                                        fillColor: MaterialStateProperty.all(Colors
                                            .white), // Change the fill color when selected
                                        splashRadius:
                                            20, // Change the splash radius when clicked
                                        onChanged: (value) {
                                          setState(() {
                                            selectedOption = value!;
                                          });
                                        },
                                      ),
                                      const Text("Credit Card",
                                          style:
                                              TextStyle(color: Colors.white)),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Image.asset(
                                        "assets/images/card.png",
                                        width: 25.w,
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Radio<int>(
                                        value: 2,
                                        groupValue: selectedOption,
                                        activeColor: Colors
                                            .grey, // Change the active radio button color here
                                        fillColor: MaterialStateProperty.all(Colors
                                            .white), // Change the fill color when selected
                                        splashRadius:
                                            20, // Change the splash radius when clicked
                                        onChanged: (value) {
                                          setState(() {
                                            selectedOption = value!;
                                          });
                                        },
                                      ),
                                      const Text("Virtual Account",
                                          style:
                                              TextStyle(color: Colors.white)),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Image.asset(
                                        "assets/images/va.png",
                                        width: 40.w,
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Radio<int>(
                                        value: 3,
                                        groupValue: selectedOption,
                                        activeColor: Colors
                                            .grey, // Change the active radio button color here
                                        fillColor: MaterialStateProperty.all(Colors
                                            .white), // Change the fill color when selected
                                        splashRadius:
                                            20, // Change the splash radius when clicked
                                        onChanged: (value) {
                                          setState(() {
                                            selectedOption = value!;
                                          });
                                        },
                                      ),
                                      const Text("e-wallet",
                                          style:
                                              TextStyle(color: Colors.white)),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Image.asset(
                                        "assets/images/e-wallet.png",
                                        width: 40.w,
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Radio<int>(
                                        value: 4,
                                        groupValue: selectedOption,
                                        activeColor: Colors
                                            .grey, // Change the active radio button color here
                                        fillColor: MaterialStateProperty.all(Colors
                                            .white), // Change the fill color when selected
                                        splashRadius:
                                            20, // Change the splash radius when clicked
                                        onChanged: (value) {
                                          setState(() {
                                            selectedOption = value!;
                                          });
                                        },
                                      ),
                                      const Text("QRis",
                                          style:
                                              TextStyle(color: Colors.white)),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Image.asset(
                                        "assets/images/qris.png",
                                        width: 10.w,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                  width: 40.w,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromRGBO(
                                              114, 162, 138, 1),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                          )),
                                      onPressed: () async {
                                        Get.toNamed("/front-screen/allpromo",
                                            arguments: [
                                              {"first": localData}
                                            ]);
                                      },
                                      child: const Text("TOP UP")),
                                )),
                          ],
                        )))),
            bottomNavigationBar: Expatnav(data: localData)));
  }
}
