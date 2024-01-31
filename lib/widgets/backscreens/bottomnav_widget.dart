import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Expatnav extends StatelessWidget {
  final data;
  const Expatnav({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
        style: TabStyle.fixed,
        activeColor: Colors.white,
        cornerRadius: 20,
        backgroundColor: const Color.fromRGBO(30, 30, 30, 1),
        items: const [
          TabItem(title: 'Home', icon: Icons.home),
          TabItem(title: 'Scan', icon: Icons.qr_code),
          TabItem(title: 'Profile', icon: Icons.person),
        ],
        initialActiveIndex: 1,
        onTap: (int i) => {
              if (i == 0)
                {
                  Get.toNamed("/front-screen/home", arguments: [
                    {"first": data}
                  ])
                }
              else if (i == 1)
                {
                  Get.toNamed("/front-screen/qrcode", arguments: [
                    {"first": data}
                  ])
                }
              else if (i == 2)
                {
                  Get.toNamed("/front-screen/profile", arguments: [
                    {"first": data}
                  ])
                }
            });
  }
}
