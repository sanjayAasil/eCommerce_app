import 'package:ecommerce_app/common/global.dart';
import 'package:ecommerce_app/service/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInAlertDialog extends StatefulWidget {
  const SignInAlertDialog({super.key});

  @override
  State<SignInAlertDialog> createState() => _SignInAlertDialogState();
}

class _SignInAlertDialogState extends State<SignInAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
          height: 200,
          width: 200,
          child: Column(
            children: [
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20.0, top: 10),
                    child: Text(
                      'SignIn Required',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(CupertinoIcons.xmark),
                  ),
                ],
              ),
              Column(
                children: [
                  InkWell(
                    onTap: _onTapAnonSignIn,
                    child: Container(
                      width: 180,
                      margin: const EdgeInsets.all(20),
                      decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(40)),
                      padding: const EdgeInsets.all(10),
                      child: const Center(child: Text('Sign in Anonymous')),
                    ),
                  ),
                  InkWell(
                    onTap: _onTapGoogleSignIn,
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
            ],
          )),
    );
  }

  void _onTapAnonSignIn() async {
    User? user = await FirebaseAuthManager().signInAnonymous();

    if (user == null) {
      showCommonToast('Failed to sign');
      return;
    }
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  void _onTapGoogleSignIn() async {
    User? user = await FirebaseAuthManager().signInWithGoogle();

    if (user == null) {
      showCommonToast('Failed to sign');
      return;
    }
    if (mounted) {
      Navigator.of(context).pop();
    }
  }
}
