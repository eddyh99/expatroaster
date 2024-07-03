import 'package:expatroasters/utils/extensions.dart';
import 'package:expatroasters/widgets/backscreens/bottomnav_widget.dart';
import 'package:expatroasters/widgets/backscreens/outlet_widget.dart';
import 'package:flutter/material.dart';

class AboutView extends StatefulWidget {
  const AboutView({super.key});

  @override
  State<AboutView> createState() {
    return _AboutViewState();
  }
}

class _AboutViewState extends State<AboutView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.black,
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: SingleChildScrollView(
                child: Column(
              children: [
                SizedBox(
                    width: 100.w,
                    height: 40.h,
                    child: const DecoratedBox(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/about.png"),
                            fit: BoxFit.cover),
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.fromLTRB(5.h, 5.h, 5.h, 0),
                  child: SizedBox(
                    width: 100.w,
                    // height: 45.h,
                    child: const Text(
                      'Expat. Roasters is a specialty coffee producer driven by desire to produce an exceptional, unpretentious brew, from the ground up. As residents of "the island", Expat. Roasters works closely and respectfully with Balinese farmers and producers to source finest local product to compliment their nomadic collections of beans around the globe.Expat. Roasters strive to foster the burgeoning coffee & barista community of Indonesia. Introducing the culture of making a good brew across the island, our mission is to give access to education and training to coffee professionals and coffee lovers!',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                SizedBox(height: 34.h, width: 100.w, child: const OutletView()),
                SizedBox(
                  height: 5.h,
                )
              ],
            )),
            bottomNavigationBar: const Expatnav(
              number: 3,
            )));
  }
}
