import 'package:expatroasters/view/frontscreen/about_view.dart';
import 'package:expatroasters/view/frontscreen/all_menu.dart';
import 'package:expatroasters/view/frontscreen/benefit_view.dart';
import 'package:expatroasters/view/frontscreen/settings/pilihsettings_view.dart';
import 'package:expatroasters/view/frontscreen/signup/complete_view.dart';
import 'package:expatroasters/view/frontscreen/signup/confirmation_view.dart';
import 'package:expatroasters/view/frontscreen/signup/createpin_view.dart';
import 'package:expatroasters/view/frontscreen/history/detail_history_order.dart';
import 'package:expatroasters/view/frontscreen/signin/enterpin_view.dart';
import 'package:expatroasters/view/frontscreen/forgot_password/enterotp_view.dart';
import 'package:expatroasters/view/frontscreen/forgot_password/forgotpass_view.dart';
import 'package:expatroasters/view/frontscreen/forgot_password/sendemail_view.dart';
import 'package:expatroasters/view/frontscreen/getstarted_view.dart';
import 'package:expatroasters/view/frontscreen/home_view.dart';
import 'package:expatroasters/view/frontscreen/list_outlet.dart';
import 'package:expatroasters/view/frontscreen/orderdetail_view.dart';
import 'package:expatroasters/view/frontscreen/order_view.dart';
import 'package:expatroasters/view/frontscreen/history/history_view.dart';
import 'package:expatroasters/view/frontscreen/profile_view.dart';
import 'package:expatroasters/view/frontscreen/promotion_view.dart';
import 'package:expatroasters/view/frontscreen/qrcode_view.dart';
import 'package:expatroasters/view/frontscreen/settings/setting_confirmpin.dart';
import 'package:expatroasters/view/frontscreen/settings/setting_newpin.dart';
import 'package:expatroasters/view/frontscreen/settings/setting_password.dart';
import 'package:expatroasters/view/frontscreen/settings/setting_view.dart';
import 'package:expatroasters/view/frontscreen/signin/signin_view.dart';
import 'package:expatroasters/view/frontscreen/signup/signup_view.dart';
import 'package:expatroasters/view/frontscreen/single_outlet.dart';
import 'package:expatroasters/view/frontscreen/single_promo.dart';
import 'package:expatroasters/view/frontscreen/term_view.dart';
import 'package:expatroasters/view/frontscreen/topup_view.dart';
import 'package:expatroasters/view/frontscreen/webviewexample.dart';
import 'package:expatroasters/view/landing_view.dart';
import 'package:expatroasters/view/splashscreen.dart';
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
  const MyApp({super.key});

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
            name: '/front-screen/termcondition',
            page: () => const TermView(),
            transition: Transition.noTransition,
          ),
          GetPage(
            name: '/front-screen/register',
            page: () => const SignupView(),
            transition: Transition.leftToRight,
          ),
          GetPage(
            name: '/front-screen/confirm',
            page: () => const ConfirmationView(),
            transition: Transition.noTransition,
          ),
          GetPage(
            name: '/front-screen/createpin',
            page: () => const PinView(),
            transition: Transition.noTransition,
          ),
          GetPage(
            name: '/front-screen/enterpin',
            page: () => const EnterpinView(),
            transition: Transition.noTransition,
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
            transition: Transition.noTransition,
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
            transition: Transition.noTransition,
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
            transition: Transition.noTransition,
          ),
          GetPage(
            name: '/front-screen/pilihSettings',
            page: () => const PilihSettingsView(),
            transition: Transition.rightToLeft,
          ),
          GetPage(
            name: '/front-screen/settingPassword',
            page: () => const SettingPasswordView(),
            transition: Transition.noTransition,
          ),
          GetPage(
            name: '/front-screen/settingNewPin',
            page: () => const SettingNewPinView(),
            transition: Transition.noTransition,
          ),
          GetPage(
            name: '/front-screen/settingConfirmPin',
            page: () => const SettingConfirmPinView(),
            transition: Transition.noTransition,
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
          GetPage(
            name: '/front-screen/list_outlet',
            page: () => const ListOutlet(),
            transition: Transition.fadeIn,
          ),
          GetPage(
            name: '/front-screen/orderdetail',
            page: () => const OrderDetailView(),
            transition: Transition.fadeIn,
          ),
          GetPage(
            name: '/front-screen/order',
            page: () => const OrderView(),
            transition: Transition.fadeIn,
          ),
          GetPage(
            name: '/front-screen/webview',
            page: () => const WebViewExample(),
            transition: Transition.fadeIn,
          ),
          GetPage(
            name: '/front-screen/history',
            page: () => const HistoryView(),
            transition: Transition.fadeIn,
          ),
          GetPage(
            name: '/front-screen/historyorder',
            page: () => const DetailHistoryOrder(),
            transition: Transition.fadeIn,
          ),
          GetPage(
            name: '/front-screen/sendemail_forgot',
            page: () => const SendemailView(),
            transition: Transition.noTransition,
          ),
          GetPage(
            name: '/front-screen/enterotp_forgot',
            page: () => const EnterotpView(),
            transition: Transition.rightToLeft,
          ),
          GetPage(
            name: '/front-screen/password_forgot',
            page: () => const ForgotpassView(),
            transition: Transition.rightToLeft,
          ),
        ]);
  }
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

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
