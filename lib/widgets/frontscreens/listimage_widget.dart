import 'package:flutter/material.dart';

class ListimageView extends StatelessWidget {
  final NetworkImage image;
  final Widget child;

  const ListimageView({Key? key, required this.image, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(1),
        child: FractionallySizedBox(
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
        ));
  }
}
