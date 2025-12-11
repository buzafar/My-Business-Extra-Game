import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_business_extra/inits.dart';
import 'package:my_business_extra/my_material_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Inits.initSupabase();

  runApp( ProviderScope(child: MyMaterialApp()));
}

