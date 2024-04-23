import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/log_in/log_in_page.dart';
import 'package:chat_app/services/helper/FirebaseHelper.dart';
import 'package:chat_app/model/freezedusermodel.dart';
import 'package:chat_app/pages/home_page.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  User? currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser != null) {
    // Logged In
    UserModel? user = await FirebaseHelper.getUserModelById(currentUser.uid);
    if (user != null) {
      runApp(ProviderScope(
        child: MyAppLoggedIn(
          firebaseUser: currentUser,
          user: user,
        ),
      ));
    } else {
      runApp(const ProviderScope(child: MyApp()));
    }
  } else {
    // Not logged in
    runApp(const ProviderScope(child: MyApp()));
  }
}

// Not Logged In
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

// Already Logged In
class MyAppLoggedIn extends StatelessWidget {
  final UserModel user;
  final User firebaseUser;

  const MyAppLoggedIn(
      {Key? key, required this.user, required this.firebaseUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final currentUser = FirebaseAuth.instance.currentUser;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(user, firebaseUser),
    );
  }
}
