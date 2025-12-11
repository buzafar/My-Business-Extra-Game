import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_business_extra/launch_screen.dart';
import 'package:my_business_extra/router/app_router.dart';

class MyMaterialApp extends StatelessWidget {
  MyMaterialApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
      theme: ThemeData(colorSchemeSeed: Colors.green, textTheme: GoogleFonts.poppinsTextTheme()),
    );
  }
}
