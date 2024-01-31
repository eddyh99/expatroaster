import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double tinggi;
  final double lebar;
  const ShimmerWidget({Key? key, required this.tinggi, required this.lebar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: Colors.grey[100]!,
      baseColor: Colors.grey[500]!,
      child: Container(
        height: tinggi,
        width: lebar,
        decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
