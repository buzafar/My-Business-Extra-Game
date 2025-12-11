
// here we initialize all the services like supabase when the app is launched

import 'package:supabase_flutter/supabase_flutter.dart';

class Inits {
  static Future initSupabase() async {
    await Supabase.initialize(url: 'https://csktohchkexpgswyeiwi.supabase.co',
      anonKey: 'sb_publishable_eTCHYeQRQw6YpfhTLYvHJQ_oavMb3qC',);
  }
}