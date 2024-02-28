import 'package:authentication/controller/auth_provider.dart';
import 'package:authentication/view/home_screen.dart';
import 'package:authentication/view/reg_screen.dart';
import 'package:authentication/view/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthenProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/login.png',
                height: 300,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "𝐋𝐞𝐭'𝐬 𝐠𝐞𝐭 𝐬𝐭𝐚𝐫𝐭𝐞𝐝",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "𝐍𝐞𝐯𝐞𝐫 𝐚 𝐛𝐞𝐭𝐭𝐞𝐫 𝐭𝐢𝐦𝐞 𝐭𝐡𝐞𝐧 𝐧𝐨𝐰 𝐭𝐨 𝐬𝐭𝐚𝐫𝐭",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black38),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: CustomButton(
                  onPressed: () {
                    authProvider.isSignedIn == true
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()))
                        : Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterPage(),
                            ));
                  },
                  text: "Get Started",
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
