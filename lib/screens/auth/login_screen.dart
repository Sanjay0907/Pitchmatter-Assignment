// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pitchmatter_assignment/screens/auth/signup_screen.dart';
import 'package:pitchmatter_assignment/screens/user_dashboard.dart';
import 'package:pitchmatter_assignment/services/auth_services.dart';
import 'package:pitchmatter_assignment/utils/colors.dart';
import 'package:pitchmatter_assignment/widgets/toast_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showPassword = false;
  bool isRememberMe = true;

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    return emailRegex.hasMatch(email);
  }

  void handleLogin() async {
    bool validEmail = isValidEmail(emailController.text);
    log(validEmail.toString());

    if (emailController.text.isEmpty) {
      ToastService.sendScaffoldAlert(
        msg: 'Enter email',
        toastStatus: 'ERROR',
        context: context,
      );
    } else if (validEmail == false) {
      ToastService.sendScaffoldAlert(
        msg: 'Invalid email',
        toastStatus: 'ERROR',
        context: context,
      );
    } else if (passwordController.text.isEmpty) {
      ToastService.sendScaffoldAlert(
        msg: 'Enter password',
        toastStatus: 'ERROR',
        context: context,
      );
    } else {
      MobileAuthServices mobileAuthServices = MobileAuthServices();
      final user = await mobileAuthServices.signIn(
        email: emailController.text,
        password: passwordController.text,
        context: context,
      );

      // if (user != null) {
      //   Navigator.pushAndRemoveUntil(
      //     context,
      //     PageTransition(
      //         child: DashboardScreen(), type: PageTransitionType.rightToLeft),
      //     (route) => false,
      //   );
      // } else {
      //   ToastService.sendScaffoldAlert(
      //     msg: 'Error signing in',
      //     toastStatus: 'ERROR',
      //     context: context,
      //   );
      //   print('Authentication failed');
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: height,
            width: width,
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.03,
              vertical: height * 0.02,
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/images/signup/login_screen.jpg',
                  ),
                  fit: BoxFit.cover),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.38,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sign in',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                    ),
                    SizedBox(height: height * 0.01),
                    Container(
                      height: height * 0.005,
                      color: primary,
                      width: width * 0.2,
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    SignUpTextField(
                      title: 'Email',
                      hint: 'demo@email.com',
                      controller: emailController,
                      inputType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    SignUpTextField(
                      title: 'Password',
                      inputType: TextInputType.visiblePassword,
                      hint: 'enter your password',
                      iconData: Icons.key,
                      controller: passwordController,
                      obscureText: showPassword,
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                        child: Icon(
                          !showPassword
                              ? Icons.visibility_off_outlined
                              : Icons.remove_red_eye_outlined,
                          color: grey,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Transform.scale(
                              scale: 1.2, // Slightly smaller checkbox
                              child: Checkbox(
                                value: isRememberMe,
                                onChanged: (value) {
                                  setState(() {
                                    isRememberMe = value!;
                                  });
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                side: BorderSide(color: primary),
                                activeColor: primary,
                                visualDensity:
                                    VisualDensity.compact, // Minimizes padding
                                materialTapTargetSize: MaterialTapTargetSize
                                    .shrinkWrap, // Removes extra tap space
                              ),
                            ),
                            // Checkbox(
                            //   value: isRememberMe,
                            //   onChanged: (value) {
                            //     setState(() {
                            //       isRememberMe = value!;
                            //     });
                            //   },
                            //   shape: RoundedRectangleBorder(
                            //     borderRadius: BorderRadius.circular(5),
                            //   ),
                            //   side: BorderSide(color: primary),
                            //   activeColor: primary,
                            // ),
                            const Text(
                              'Remember Me',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigate to Forgot Password screen
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => handleLogin(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              15,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: height * 0.015,
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Login',
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: white,
                                  ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Don\'t have an account? ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      // fontWeight: FontWeight.bold,
                                      color: textColor,
                                    ),
                              ),
                              TextSpan(
                                text: 'Sign up',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: primary,
                                    ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      PageTransition(
                                        child: SignUpScreen(),
                                        type: PageTransitionType.rightToLeft,
                                      ),
                                      (route) => false,
                                    );
                                  },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignUpTextField extends StatelessWidget {
  const SignUpTextField({
    super.key,
    required this.controller,
    required this.title,
    required this.hint,
    this.obscureText = false,
    this.iconData = Icons.email_outlined,
    this.suffixIcon,
    required this.inputType,
  });

  final TextEditingController controller;
  final String title;
  final String hint;
  final Widget? suffixIcon;
  final bool obscureText;
  final IconData iconData;
  final TextInputType inputType;
  // final String

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
        ),
        TextField(
          controller: controller,
          keyboardType: inputType,
          obscureText: obscureText,
          decoration: InputDecoration(
            prefixIcon: Icon(iconData, color: Colors.grey),
            suffixIcon: suffixIcon,
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: primary,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: primary, width: 2),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: primary),
            ),
          ),
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
