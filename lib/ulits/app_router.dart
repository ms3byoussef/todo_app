// ignore_for_file: body_might_complete_normally_nullable

import 'package:flutter/material.dart';

import '../ui/home_screen/home_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}
