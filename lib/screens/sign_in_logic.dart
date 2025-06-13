// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pitchmatter_assignment/screens/auth/login_screen.dart';
import 'package:pitchmatter_assignment/screens/user_dashboard.dart';
import 'package:pitchmatter_assignment/services/auth_services.dart';
import 'package:pitchmatter_assignment/utils/colors.dart';

class SignInLogic extends StatefulWidget {
  static const String id = 'SignInLogicScreen';
  const SignInLogic({super.key});

  @override
  State<SignInLogic> createState() => _SignInLogicState();
}

class _SignInLogicState extends State<SignInLogic> {
  checkAuthentication() {
    bool userIsAuthenticated = MobileAuthServices.checkAuthentication();
    userIsAuthenticated
        // ? checkUser()
        ? Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
              child: DashboardScreen(),
              type: PageTransitionType.rightToLeft,
            ),
            (route) => false,
          )
        : Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
                child: const LoginScreen(),
                type: PageTransitionType.rightToLeft),
            (route) => false);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkAuthentication();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: Center(
          child: Text(
        'PITCHMATTER',
        style: Theme.of(context).textTheme.displayMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: white,
            ),
      )),
    );
  }
}
