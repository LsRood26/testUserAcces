import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_useracces/firebase_options.dart';
import 'package:test_useracces/providers/provider_login.dart';
import 'package:test_useracces/screens/home.dart';
import 'package:test_useracces/screens/login.dart';
import 'package:test_useracces/screens/register.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => ProviderLogin()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        /* home: LoginPage(), */
        routes: {
          '/': (context) => LoginPage(),
          '/register': (context) => RegisterPage(),
          '/homepage': (context) => HomePage(),
        });
  }
}
