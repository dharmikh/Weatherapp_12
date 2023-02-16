import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp_12/Screen/Provider/HomeProvider.dart';
import 'package:weatherapp_12/Screen/view/HomeScree.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => HomeProvider(),
    child: Sizer(
      builder: (context, orientation, deviceType) => MaterialApp(
        debugShowCheckedModeBanner: false,
        // initialRoute: '/',
        routes: {
          '/': (context) => HomeScreen(),
        },
      ),
    ),
  ));
}
