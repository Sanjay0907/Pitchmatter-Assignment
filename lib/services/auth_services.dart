// ignore_for_file: use_build_context_synchronously, no_leading_underscores_for_local_identifiers

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pitchmatter_assignment/screens/user_dashboard.dart';
import 'package:pitchmatter_assignment/widgets/toast_widget.dart';

class MobileAuthServices {
  static bool checkAuthentication() {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user != null) {
      return true;
    }
    return false;
  }

  Future<User?> signUp(
      {required String email,
      required String password,
      required BuildContext context}) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      log("Attempting login: $email / $password");
      await _auth
          .createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      )
          .then((userCredential) async {
        await signIn(
          email: email,
          password: password,
          context: context,
        );
      }).onError((error, stackTrace) {ToastService.sendScaffoldAlert(
        msg: error.toString(),
        toastStatus: 'ERROR',
        context: context,
      );});
    } on FirebaseAuthException catch (e) {
ToastService.sendScaffoldAlert(
        msg: e.toString(),
        toastStatus: 'ERROR',
        context: context,
      );
    }

    // }
  }

  Future<User?> signIn(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      log("Attempting login: $email / $password");
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      )
          .then((userCredential) {
        Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
            child: DashboardScreen(),
            type: PageTransitionType.rightToLeft,
          ),
          (route) => false,
        );
      }).onError((error, stackTrace) {
        ToastService.sendScaffoldAlert(
          msg: error.toString(),
          toastStatus: 'ERROR',
          context: context,
        );
        print("Login failed: $error");
      });
    } on FirebaseAuthException catch (e) {
      ToastService.sendScaffoldAlert(
        msg: e.message.toString(),
        toastStatus: 'ERROR',
        context: context,
      );
      // }
    }
  }
}
