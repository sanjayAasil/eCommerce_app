import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void showCommonToast(String title) {
  if (navigatorKey.currentState != null) {
    BuildContext context = navigatorKey.currentState!.context;

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(title)));
    }
  }
}
