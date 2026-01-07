import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_business_extra/components/top_info_bar.dart';
import 'package:my_business_extra/router/app_router.dart';
import 'package:my_business_extra/services/user_service.dart';

import 'global_state_providers/current_user_provider.dart';

// Modular.setNavigatorKey(myNavigatorKey);

class MyMaterialApp extends StatelessWidget {
  MyMaterialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return MaterialApp.router(
          builder: (context, child) {
            return Stack(children: [child!, TopInfoBar()]);
          },
          routerConfig: ref.read(appRouterProvider).config(),
          theme: ThemeData(
            colorSchemeSeed: Colors.green,
            textTheme: GoogleFonts.poppinsTextTheme(),
          ),
        );
      },
    );
  }
}
