import 'package:dog_app/providers/rescue_list_provider.dart';
import 'package:dog_app/providers/user_provider.dart';
import 'package:dog_app/screens/signin_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dog_app/providers/adoption_list_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => RescueListProvider()),
    ChangeNotifierProvider(create: (context) => AdoptionListProvider()),
    ChangeNotifierProvider(create: (context) => UserProvider())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dog App',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 103, 156, 166))),
      home: const SignInScreen(),
    );
  }
}
