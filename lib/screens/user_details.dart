// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pitchmatter_assignment/model/user_model.dart';
import 'package:pitchmatter_assignment/provider/user_provider.dart';
import 'package:pitchmatter_assignment/services/share_services.dart';
import 'package:pitchmatter_assignment/screens/sign_in_logic.dart';
import 'package:pitchmatter_assignment/utils/colors.dart';
import 'package:pitchmatter_assignment/widgets/toast_widget.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class UserDetailScreen extends StatefulWidget {
  const UserDetailScreen({
    super.key,
    required this.userId,
    required this.isDeepLink,
  });
  final int userId;
  final bool isDeepLink;

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getUser();
    });
  }

  late UserModel? userData;
  late String profileLink;
  getUser() async {
    profileLink =
        'sanjay://pitchmatterassignment.com/user!?id=${widget.userId}';
    if (context.read<UserProvider>().users.isEmpty) {
      await context.read<UserProvider>().loadUsers();
      setState(() {
        userData = context.read<UserProvider>().getUserById(widget.userId);
      });
      if (userData == null) {
        ToastService.sendScaffoldAlert(
          msg: 'Opps! User not found',
          toastStatus: 'ERROR',
          context: context,
        );
        Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
            child: SignInLogic(),
            type: PageTransitionType.rightToLeft,
          ),
          (route) => false,
        );
      } else {
        setState(() {
          userData = context.read<UserProvider>().getUserById(widget.userId);
          // profileLink =
          //     'flutter://www.pitchmatter-assignment.com/user!?id=${widget.userId}';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (didPop) {
            return;
          } else {
            Navigator.pushAndRemoveUntil(
              context,
              PageTransition(
                  child: SignInLogic(), type: PageTransitionType.rightToLeft),
              (context) => false,
            );
          }
        },
        child: Consumer<UserProvider>(builder: (context, userProvider, child) {
          if (userProvider.users.isEmpty) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: primary,
                leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back,
                    color: white,
                  ),
                ),
                centerTitle: true,
                automaticallyImplyLeading: false,
                title: Text(
                  'User',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: white,
                      overflow: TextOverflow.ellipsis),
                ),
              ),
              body: Center(
                child: CircularProgressIndicator(
                  color: primary,
                ),
              ),
            );
          } else {
            UserModel user = userProvider.getUserById(widget.userId)!;
            double height = MediaQuery.of(context).size.height;
            double width = MediaQuery.of(context).size.width;
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: primary,
                  leading: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_back,
                      color: white,
                    ),
                  ),
                  centerTitle: true,
                  automaticallyImplyLeading: false,
                  title: Text(
                    user.name,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: white,
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
                body: ListView(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.05,
                    vertical: height * 0.02,
                  ),
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.03,
                        vertical: height * 0.02,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                          color: primary),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FittedBox(
                            child: Text(
                              user.name,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: white,
                                  ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/images/svg/envelope.svg',
                                color: white.withOpacity(0.7),
                                height: height * 0.02,
                                semanticsLabel: 'Dart Logo',
                              ),
                              SizedBox(
                                width: width * 0.02,
                              ),
                              Text(
                                user.email,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: white.withOpacity(0.7),
                                    ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/images/svg/phone-call.svg',
                                color: white.withOpacity(0.7),
                                height: height * 0.02,
                                semanticsLabel: 'Dart Logo',
                              ),
                              SizedBox(
                                width: width * 0.02,
                              ),
                              Text(
                                user.phone!,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: white.withOpacity(0.7),
                                    ),
                              ),
                            ],
                          ),
                          // Text(
                          //   user.phone!,
                          //   style: Theme.of(context)
                          //       .textTheme
                          //       .titleMedium!
                          //       .copyWith(
                          //         fontWeight: FontWeight.bold,
                          //         color: white.withOpacity(0.7),
                          //       ),
                          // ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.05),
                            child: Divider(
                              color: white,
                              thickness: 2,
                            ),
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Company: ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: white.withOpacity(0.7),
                                      ),
                                ),
                                TextSpan(
                                  text: user.company!.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: white,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            user.company!.catchPhrase ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: white,
                                ),
                          ),
                          Text(
                            user.company!.bs ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: white,
                                ),
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.1),
                            child: Divider(
                              color: white.withOpacity(0.5),
                              thickness: 2,
                            ),
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Address: ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: white.withOpacity(0.7),
                                      ),
                                ),
                                TextSpan(
                                  text:
                                      '${user.address!.city}, ${user.address!.street}, ${user.address!.suite}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: white,
                                      ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.05,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SocialWidget(
                                  onTap: () => shareQRCode(
                                    context: context,
                                    name: user.name,
                                    company: user.company!.name,
                                    email: user.email,
                                    phone: user.phone!,
                                    profileUrl: profileLink,
                                  ),
                                  assetLocation: 'assets/images/svg/qr.svg',
                                ),
                                SocialWidget(
                                  onTap: () => launchWebsite(
                                      context: context, url: user.website!),
                                  assetLocation:
                                      'assets/images/svg/site-alt.svg',
                                ),
                                SocialWidget(
                                  onTap: () => openMap(
                                      latitude: double.parse(
                                        user.address!.geo!.lat!,
                                      ),
                                      longitude: double.parse(
                                        user.address!.geo!.lng!,
                                      ),
                                      context: context),
                                  assetLocation:
                                      'assets/images/svg/map-marker.svg',
                                ),
                                SocialWidget(
                                  onTap: () => shareProfileLink(profileLink),
                                  assetLocation: 'assets/images/svg/share.svg',
                                ),
                                // SocialWidget(
                                //   onTap: () {
                                //     log('Hello');
                                //   },
                                //   assetLocation: 'assets/images/svg/qr.svg',
                                // ),
                              ])
                        ],
                      ),
                    ),
                  ],
                )

                // Padding(
                //   padding: const EdgeInsets.all(16.0),
                //   child: ListView(
                //     children: [
                //       Text('Name: ${user!.name}'),
                //       Text('Username: ${user!.username}'),
                //       Text('Email: ${user!.email}'),
                //       Text('Phone: ${user!.phone}'),
                //       Text('Website: ${user!.website}'),
                //       Text('Company: ${user!.company!.name}'),
                //       Text('Catchphrase: ${user!.company!.catchPhrase}'),
                //       Text('Business: ${user!.company!.bs}'),
                //       Text(
                //           'Address: ${user!.address!.street}, ${user!.address!.suite}, ${user!.address!.city}, ${user!.address!.zipcode}'),
                //       Text(
                //           'Coordinates: ${user!.address!.geo!.lat}, ${user!.address!.geo!.lng}'),
                //       SizedBox(height: 20),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //         children: [
                //           ElevatedButton.icon(
                //             icon: Icon(Icons.qr_code),
                //             label: Text('QR Code'),
                //             onPressed: () =>
                //                 Share.share('QR Profile: $profileLink'),
                //           ),
                //           ElevatedButton.icon(
                //             icon: Icon(Icons.share),
                //             label: Text('Share Link'),
                //             onPressed: () => Share.share(profileLink),
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),

                );
          }
        }));
  }
}

class SocialWidget extends StatelessWidget {
  const SocialWidget({
    super.key,
    required this.assetLocation,
    required this.onTap,
  });
  final VoidCallback onTap;
  final String assetLocation;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: white,
        ),
        child: SvgPicture.asset(
          assetLocation,
          color: primary,
          height: height * 0.03,
          semanticsLabel: 'Dart Logo',
        ),
      ),
    );
  }
}
