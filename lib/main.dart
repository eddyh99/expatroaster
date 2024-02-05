import 'package:expatroaster/view/frontscreen/about_view.dart';
import 'package:expatroaster/view/frontscreen/all_menu.dart';
import 'package:expatroaster/view/frontscreen/benefit_view.dart';
import 'package:expatroaster/view/frontscreen/complete_view.dart';
import 'package:expatroaster/view/frontscreen/getstarted_view.dart';
import 'package:expatroaster/view/frontscreen/home_view.dart';
import 'package:expatroaster/view/frontscreen/profile_view.dart';
import 'package:expatroaster/view/frontscreen/promotion_view.dart';
import 'package:expatroaster/view/frontscreen/qrcode_view.dart';
import 'package:expatroaster/view/frontscreen/setting_view.dart';
import 'package:expatroaster/view/frontscreen/signin_view.dart';
import 'package:expatroaster/view/frontscreen/signup_view.dart';
import 'package:expatroaster/view/frontscreen/single_outlet.dart';
import 'package:expatroaster/view/frontscreen/single_promo.dart';
import 'package:expatroaster/view/frontscreen/topup_view.dart';
import 'package:expatroaster/view/landing_view.dart';
import 'package:expatroaster/view/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class NoGlowScrollBehavior extends MaterialScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Expats. Roaster',
        scrollBehavior: NoGlowScrollBehavior(),
        initialRoute: '/',
        smartManagement: SmartManagement.full,
        theme: ThemeData(
          textTheme: GoogleFonts.interTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        getPages: [
          GetPage(
            name: '/',
            page: () => const MainApp(),
          ),
          GetPage(
            name: '/front-screen/landing',
            page: () => const LandingView(),
            transition: Transition.fadeIn,
          ),
          GetPage(
            name: '/front-screen/getstarted',
            page: () => const GetstartedView(),
            transition: Transition.leftToRight,
          ),
          GetPage(
            name: '/front-screen/register',
            page: () => const SignupView(),
            transition: Transition.leftToRight,
          ),
          GetPage(
            name: '/front-screen/signin',
            page: () => const SigninView(),
            transition: Transition.rightToLeft,
          ),
          GetPage(
            name: '/front-screen/home',
            page: () => const HomeView(),
            transition: Transition.noTransition,
          ),
          GetPage(
            name: '/front-screen/profile',
            page: () => const ProfileView(),
            transition: Transition.fadeIn,
          ),
          GetPage(
            name: '/front-screen/about',
            page: () => const AboutView(),
            transition: Transition.leftToRight,
          ),
          GetPage(
            name: '/front-screen/benefit',
            page: () => const BenefitView(),
            transition: Transition.leftToRight,
          ),
          GetPage(
            name: '/front-screen/qrcode',
            page: () => const QrcodeView(),
            transition: Transition.leftToRight,
          ),
          GetPage(
            name: '/front-screen/singleoutlet',
            page: () => const SingleoutletView(),
            transition: Transition.leftToRight,
          ),
          GetPage(
            name: '/front-screen/allpromo',
            page: () => const PromotionView(),
            transition: Transition.noTransition,
          ),
          GetPage(
            name: '/front-screen/singlePromo',
            page: () => const SinglepromoView(),
            transition: Transition.leftToRight,
          ),
          GetPage(
            name: '/front-screen/completeregister',
            page: () => const CompleteView(),
            transition: Transition.leftToRight,
          ),
          GetPage(
            name: '/front-screen/settings',
            page: () => const SettingView(),
            transition: Transition.rightToLeft,
          ),
          GetPage(
            name: '/front-screen/topup',
            page: () => const TopupView(),
            transition: Transition.rightToLeft,
          ),
          GetPage(
            name: '/front-screen/allmenu',
            page: () => const AllMenu(),
            transition: Transition.fadeIn,
          ),
        ]);
  }
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Future.delayed(const Duration(seconds: 3), () {
        Get.offNamed('/front-screen/landing');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashScreen(),
    );
  }
}
