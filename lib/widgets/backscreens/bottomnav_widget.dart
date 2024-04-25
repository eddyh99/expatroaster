import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Expatnav extends StatelessWidget {
  const Expatnav({super.key, this.pos});
  final pos;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: pos,
        backgroundColor: const Color.fromRGBO(30, 30, 30, 1),
        selectedItemColor: Colors.greenAccent,
        unselectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: "Scan"),
          BottomNavigationBarItem(icon: Icon(Icons.coffee), label: "Menu"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        onTap: (int i) => {
              if (i == 0)
                {Get.toNamed("/front-screen/home")}
              else if (i == 1)
                {Get.toNamed("/front-screen/qrcode")}
              else if (i == 2)
                {Get.toNamed("/front-screen/profile")}
              else if (i == 3)
                {Get.toNamed("/front-screen/profile")}
            });
  }
}
