import 'package:expatroasters/widgets/frontscreens/background_widget.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BackgroundWithImage(
        image: const AssetImage("assets/images/background.png"),
        child: Container(),
      ),
    );
  }
}
