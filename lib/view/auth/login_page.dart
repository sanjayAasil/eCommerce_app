import 'package:ecommerce_app/view/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../common/global.dart';
import '../../service/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () async {
              setState(() => isLoading = true);
              await Future.delayed(const Duration(seconds: 2));
              showCommonToast('Welcome to eCommerce App');
              if (context.mounted) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              }
            },
            child: isLoading ? const SizedBox() : const Text('Skip >'),
          )
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        'Welcome to eCommerce',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 100.0),
                      child: Image.asset(
                        'assets/ecommerce.jpg',
                      ),
                    ),
                    InkWell(
                      onTap: _onSignInAnon,
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(40)),
                        padding: const EdgeInsets.all(10),
                        child: const Text('Sign in Anonymous'),
                      ),
                    ),
                    InkWell(
                      onTap: _onSignInWithGoogle,
                      child: Container(
                        decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(40)),
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Image.asset(
                                'assets/g_logo.png',
                                height: 25,
                                width: 25,
                              ),
                            ),
                            const Text('Sign in with google'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  void _onSignInWithGoogle() async {
    setState(() => isLoading = false);
    User? user = await FirebaseAuthManager().signInWithGoogle();
    setState(() => isLoading = false);
    if (user == null) {
      showCommonToast('Sign in with google failed');
    } else {
      showCommonToast('Welcome to eCommerce App');
      if (mounted) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomePage()));
      }
    }
  }

  void _onSignInAnon() async {
    setState(() => isLoading = true);
    User? user = await FirebaseAuthManager().signInAnonymous();
    setState(() => isLoading = false);
    if (user == null) {
      showCommonToast('Sign in with Anonymous failed');
    } else {
      showCommonToast('Welcome to eCommerce App');
      if (mounted) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomePage()));
      }
    }
  }
}
