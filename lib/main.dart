import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pitchmatter_assignment/screens/deep_link_listner.dart';
import 'package:pitchmatter_assignment/firebase_options.dart';
import 'package:pitchmatter_assignment/provider/user_provider.dart';
import 'package:pitchmatter_assignment/sign_in_logic.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()..loadUsers()),
      ],
      child: MaterialApp(
        title: 'Pitchmatter assignment',
        debugShowCheckedModeBanner: false,
        home: DeepLinkListner(child: SignInLogic()),
      ),
    );
  }
}
