import 'package:authentication/controller/auth_provider.dart';
import 'package:authentication/view/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final authenProvider = Provider.of<AuthenProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        centerTitle: true,
        title: const Text('Auth'),
        actions: [
          IconButton(
            onPressed: () {
              authenProvider.userSignOut().then(
                    (value) => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WelcomeScreen(),
                      ),
                    ),
                  );
            },
            icon: const Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.purple,
              backgroundImage:
                  NetworkImage(authenProvider.userModel.profilePic),
              radius: 50,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(authenProvider.userModel.name),
            Text(authenProvider.userModel.phoneNumber),
            Text(authenProvider.userModel.email),
            Text(authenProvider.userModel.bio),
          ],
        ),
      ),
    );
  }
}
