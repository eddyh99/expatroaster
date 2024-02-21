import 'package:expatroasters/utils/extensions.dart';
import 'package:flutter/material.dart';

class AlertTile extends StatelessWidget {
  const AlertTile({
    Key? key,
    this.leading,
    this.leadingTitle,
    this.trailingTitle,
    this.subtitle,
  }) : super(key: key);

  final Widget? leading;
  final String? leadingTitle;
  final String? trailingTitle;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: leadingTitle,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 10.sp),
            ),
            const TextSpan(text: " "),
            TextSpan(
              text: trailingTitle,
              style: TextStyle(fontSize: 10.sp),
            ),
          ],
        ),
      ),
      subtitle: Text(
        subtitle ?? "",
        style: TextStyle(fontSize: 10.sp),
      ),
    );
  }
}
