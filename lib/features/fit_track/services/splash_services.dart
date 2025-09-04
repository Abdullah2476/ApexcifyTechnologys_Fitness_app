import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_track/features/fit_track/presentations/bottomNavigation/NavigationBar.dart';
import 'package:fit_track/features/fit_track/presentations/welcome/welcome.dart';
import 'package:flutter/material.dart';

import 'dart:async';

class SplashServices {
  void islogin(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      Timer(
        Duration(seconds: 3),
        () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return MyNavigationBar();
            },
          ),
        ),
      );
    } else {
      Timer(
        Duration(seconds: 3),
        () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return Welcome();
            },
          ),
        ),
      );
    }
  }
}
