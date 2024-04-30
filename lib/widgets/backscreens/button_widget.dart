import 'package:expatroasters/utils/extensions.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String name;
  final String text;
  final String boxsize;
  final dynamic onTap;
  const ButtonWidget(
      {super.key,
      required this.name,
      required this.text,
      required this.boxsize,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (name == 'btnPrimaryLigth')
          SizedBox(
            width: double.parse(boxsize).w,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color.fromRGBO(132, 173, 153, 1),
                    Color.fromRGBO(132, 173, 153, 1),
                    Color.fromRGBO(132, 173, 153, 1),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(999.0),
                ),
                border:
                    Border.all(color: const Color.fromARGB(255, 219, 219, 219)),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(141, 190, 165, 0.3),
                    spreadRadius: 4,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: GestureDetector(
                  onTap: onTap,
                  child: Text(
                    text,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      letterSpacing: 0.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          )
        else if (name == 'btnSecondary')
          SizedBox(
            width: double.parse(boxsize).w,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color.fromRGBO(25, 25, 25, 1),
                    Color.fromRGBO(12, 12, 12, 1),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(999.0),
                ),
                border: Border.all(
                  style: BorderStyle.solid,
                  width: 0.5,
                  color: const Color.fromARGB(255, 219, 219, 219),
                ),
              ),
              child: Center(
                child: GestureDetector(
                  onTap: onTap,
                  child: Text(
                    text,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      letterSpacing: 0.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          )
      ],
    );
  }
}
