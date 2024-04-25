import 'package:expatroasters/utils/extensions.dart';
import 'package:expatroasters/utils/functions.dart';
import 'package:expatroasters/widgets/backscreens/shimmer_widget.dart';
import 'package:flutter/material.dart';

class AsyncTextWidget extends StatelessWidget {
  final String pref;
  final String field;
  const AsyncTextWidget({super.key, required this.pref, required this.field});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: readPrefStr(pref),
      builder: (ctx, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data as dynamic;
          return Text(
            data[field].isEmpty ? "00" : data[field],
            style: const TextStyle(
              color: Color.fromRGBO(114, 162, 138, 1),
            ),
          );
        } else {
          return ShimmerWidget(tinggi: 1.h, lebar: 5.w);
        }
      },
    );
  }
}
