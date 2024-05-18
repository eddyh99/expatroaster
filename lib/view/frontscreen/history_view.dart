import 'package:flutter/material.dart';
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

  late String _startDate = DateFormat('dd MMMM yyyy').format(DateTime.now());
  late String _endDate = DateFormat('dd MMMM yyyy').format(DateTime.now());

  void selectionSubmit(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      _startDate =
          DateFormat('dd MMMM yyyy').format(args.value.startDate).toString();
      _endDate = DateFormat('dd MMMM yyyy')
          .format(args.value.endDate ?? args.value.startDate)
          .toString();
    });
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
                              "250".toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.w800,
                                fontFamily: GoogleFonts.inter().fontFamily,
                              ),
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
                            Text("$_startDate - $_endDate"),
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
                                          114, 162, 138, 1)),
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
                                          114, 162, 138, 1)),
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
                              child: Text(
                                "TEST1",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Container(
                              child: Text(
                                "TEST2",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Container(
                              child: Text(
                                "TEST3",
                                style: TextStyle(color: Colors.white),
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
