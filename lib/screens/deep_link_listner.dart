// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pitchmatter_assignment/common/common_function.dart';
import 'package:pitchmatter_assignment/screens/auth/login_screen.dart';
import 'package:pitchmatter_assignment/screens/user_dashboard.dart';
import 'package:pitchmatter_assignment/screens/user_details.dart';
import 'package:pitchmatter_assignment/services/auth_services.dart';

class DeepLinkListner extends StatefulWidget {
  const DeepLinkListner({super.key, required this.child});
  final Widget child;

  @override
  State<DeepLinkListner> createState() => _DeepLinkListnerState();
}

class _DeepLinkListnerState extends State<DeepLinkListner> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final appLinks = AppLinks();
    final sub = appLinks.uriLinkStream.listen((uri) {
      log('URI: $uri');
      CommonFunction commonFunction = CommonFunction();
      int? id = commonFunction.extractIdFromUri(uri.toString());
      log(id.toString());
      bool userIsAuthenticated = MobileAuthServices.checkAuthentication();
      if ((id != null) && (userIsAuthenticated == true)) {
        Navigator.push(
          context,
          PageTransition(
            child: UserDetailScreen(
              userId: id,isDeepLink: true,
            ),
            type: PageTransitionType.rightToLeft,
          ),
        );
      }else if ((id == null) && (userIsAuthenticated == true)){
        Navigator.push(
          context,
          PageTransition(
            child: DashboardScreen(),
            type: PageTransitionType.rightToLeft,
          ),
        );
      }else if(userIsAuthenticated==false){
        Navigator.push(
          context,
          PageTransition(
            child: LoginScreen(
            ),
            type: PageTransitionType.rightToLeft,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
