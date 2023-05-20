import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:plan_app/pages/login_or_register_pages/auth_page.dart';
import 'package:plan_app/providers/filtro_providers.dart';
import 'package:plan_app/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FiltroProviders()),
        ChangeNotifierProvider(create: (_) => UserProvider())
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthPage(),
      ),
    );
  }
}
