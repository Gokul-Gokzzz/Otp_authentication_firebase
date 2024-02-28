import 'package:authentication/controller/auth_provider.dart';
import 'package:authentication/service/firebase_options.dart';
import 'package:authentication/view/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        ChangeNotifierProvider(
          create: (context) => AuthenProvider(),
        ),
      ],
      child:
          MaterialApp(debugShowCheckedModeBanner: false, home: WelcomeScreen()),
    );
  }
}
