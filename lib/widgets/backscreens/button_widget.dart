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
        if (name == 'btnPrimaryLight')
          GestureDetector(
            onTap: onTap,
            child: SizedBox(
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
                  border: Border.all(
                      color: const Color.fromARGB(255, 219, 219, 219)),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(141, 190, 165, 0.3),
                      spreadRadius: 4,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    text,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      letterSpacing: 0.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          )
        else if (name == 'btnSecondary')
          GestureDetector(
            onTap: onTap,
            child: SizedBox(
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
                  child: Text(
                    text,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      letterSpacing: 0.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          )
        else if (name == 'btnPrimaryGoogle')
          GestureDetector(
            onTap: onTap,
            child: SizedBox(
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
                  border: Border.all(
                      color: const Color.fromARGB(255, 219, 219, 219)),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(141, 190, 165, 0.3),
                      spreadRadius: 4,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/icon_google.png'),
                      SizedBox(
                        width: 2.w,
                      ),
                      Text(
                        text,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          letterSpacing: 0.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        else if (name == 'btnSecondaryEmail')
          GestureDetector(
            onTap: onTap,
            child: SizedBox(
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
                      width: 0.5,
                      color: const Color.fromARGB(255, 219, 219, 219)),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/icon_email.png'),
                      SizedBox(
                        width: 2.w,
                      ),
                      Text(
                        text,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          letterSpacing: 0.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        else if (name == 'btnSecondaryGoogle')
          GestureDetector(
            onTap: onTap,
            child: SizedBox(
              width: double.parse(boxsize).w,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromRGBO(25, 25, 25, 1),
                      Color.fromRGBO(25, 25, 25, 1),
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
                  // boxShadow: const [
                  //   BoxShadow(
                  //     color: Color.fromRGBO(141, 190, 165, 0.3),
                  //     spreadRadius: 4,
                  //     blurRadius: 10,
                  //     offset: Offset(0, 3),
                  //   ),
                  // ],
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/icon_google.png'),
                      SizedBox(
                        width: 2.w,
                      ),
                      Text(
                        text,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          letterSpacing: 0.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
      ],
    );
  }
}
