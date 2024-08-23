import 'package:expatroasters/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class IconsosmedWidget extends StatefulWidget {
  const IconsosmedWidget({super.key});

  @override
  State<IconsosmedWidget> createState() {
    return _IconsosmedWidget();
  }
}

class _IconsosmedWidget extends State<IconsosmedWidget> {
  dynamic resultData;
  final List<dynamic> imglst = [];

  Future<void> _launchInWebViewOrVC(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 5.h,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                _launchInWebViewOrVC(
                    Uri.parse('https://www.tiktok.com/@expatroasters'));
              },
              child: SvgPicture.asset('assets/images/fb.svg'),
            ),
            SizedBox(
              width: 2.w,
            ),
            GestureDetector(
              onTap: () {
                _launchInWebViewOrVC(
                    Uri.parse('https://www.instagram.com/expatroasters'));
              },
              child: SvgPicture.asset('assets/images/ig.svg'),
            ),
            SizedBox(
              width: 2.w,
            ),
            GestureDetector(
              onTap: () {
                _launchInWebViewOrVC(
                    Uri.parse('https://www.tiktok.com/@expatroasters'));
              },
              child: SvgPicture.asset('assets/images/tt.svg'),
            ),
            SizedBox(
              width: 2.w,
            ),
            GestureDetector(
              onTap: () {
                _launchInWebViewOrVC(
                    Uri.parse('https://id.pinterest.com/expatscoffee'));
              },
              child: SvgPicture.asset('assets/images/pt.svg'),
            ),
            SizedBox(
              width: 2.w,
            ),
            GestureDetector(
              onTap: () {
                _launchInWebViewOrVC(
                    Uri.parse('https://www.youtube.com/@expatroasters'));
              },
              child: SvgPicture.asset('assets/images/yt.svg'),
            ),
          ],
        ),
      ),
    );
  }
}
