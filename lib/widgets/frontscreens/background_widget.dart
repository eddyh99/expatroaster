import 'package:flutter/material.dart';

class BackgroundWithImage extends StatelessWidget {
  final AssetImage image;
  final Widget child;

  const BackgroundWithImage(
      {Key? key, required this.image, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 1.0,
      widthFactor: 1.0,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            image: image,
            fit: BoxFit.cover,
          ),
        ),
        child: child,
      ),
    );
  }
}
