import 'package:flutter/material.dart';

import 'package:figure_ui_flutter/config/constants/size_config.dart';
import 'package:figure_ui_flutter/consts.dart';

import 'package:figure_ui_flutter/presentation/screens/home/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, scaffoldBackgroundColor: bgColor),
      home: const HomeScreen(),
    );
  }
}
