import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Expatnav extends StatelessWidget {
  const Expatnav({super.key, this.number});

  final number;

  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
        style: TabStyle.react,
        activeColor: Colors.white,
        // cornerRadius: 20,
        backgroundColor: const Color.fromRGBO(30, 30, 30, 1),
        items: const [
          TabItem(title: 'Home', icon: Icons.home),
          TabItem(title: 'Scan', icon: Icons.qr_code),
          TabItem(title: 'Menu', icon: Icons.coffee),
          TabItem(title: 'Profile', icon: Icons.person),
          // TabItem(title: 'ProfileMe', icon: Icons.person),
        ],
        initialActiveIndex: number,
        onTap: (int i) => {
              if (i == 0)
                {Get.toNamed("/front-screen/home")}
              else if (i == 1)
                {Get.toNamed("/front-screen/qrcode")}
              else if (i == 2)
                {Get.toNamed("/front-screen/list_outlet")}
              else if (i == 3)
                {Get.toNamed("/front-screen/profile")}
              // else if (i == 4)
              //   {Get.toNamed("/front-screen/profile")}
            });
  }
}
