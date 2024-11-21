import 'package:electronics_shop/constants.dart';
import 'package:electronics_shop/core/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});
  @override
  State<StatefulWidget> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    tempNavigate(context);
  }

  Future<void> tempNavigate(BuildContext context) async {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        context.go(AppRouter.controlFlow);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.kPrimaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: "logo",
              child: SizedBox(
                height: 200,
                width: 200,
                child: Lottie.asset(
                  'assets/splashAnimation.json',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 20,
                ),
                Text(
                  "CStore",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}




  //  Future<void> checkForInternetAndNavigate(BuildContext context) async {
  //   try {
  //     final response = await http
  //         .get(Uri.parse('https://www.google.com'))
  //         .timeout(const Duration(seconds: 10));

  //     if (response.statusCode == 200) {
  //       log('Connected to Internet: true');
  //       Future.delayed(const Duration(seconds: 4, milliseconds: 200), () {
  //         if (mounted) {
  //           Navigator.pushReplacementNamed(context, '/controlFlow');
  //         }
  //       });
  //     } else {
  //       throw const SocketException('Failed to load Google homepage');
  //     }
  //   } on SocketException catch (e) {
  //     log('SocketException: ${e.toString()}', name: 'Splash Screen');
  //     Future.delayed(const Duration(seconds: 4, milliseconds: 200), () {
  //       if (mounted) {
  //         Navigator.pushReplacementNamed(context, '/noInternet');
  //       }
  //     });
  //   } on TimeoutException catch (e) {
  //     log('TimeoutException: ${e.toString()}', name: 'Splash Screen');
  //     Future.delayed(const Duration(seconds: 4, milliseconds: 200), () {
  //       if (mounted) {
  //         Navigator.pushReplacementNamed(context, '/noInternet');
  //       }
  //     });
  //   } catch (e) {
  //     log('Exception: ${e.toString()}', name: 'Splash Screen');
  //     Future.delayed(const Duration(seconds: 4, milliseconds: 200), () {
  //       if (mounted) {
  //         Navigator.pushReplacementNamed(context, '/noInternet');
  //       }
  //     });
  //   }