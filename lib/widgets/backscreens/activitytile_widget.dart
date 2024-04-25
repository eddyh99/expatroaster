import 'package:flutter/material.dart';

class ActivityTile extends StatelessWidget {
  const ActivityTile({
    super.key,
    required this.titleText,
    required this.subtitleText,
    this.margin,
    this.padding,
    this.height,
    this.width,
  });

  final String titleText;
  final String subtitleText;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Container(
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
          ),
        ),
        child: ListTile(
          title: Text(
            titleText,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          subtitle: Text(
            subtitleText,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ),
    );
  }
}
