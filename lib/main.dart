import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecommerce_app/common/global.dart';
import 'package:ecommerce_app/provider/dataManager.dart';
import 'package:ecommerce_app/service/network_connectivity_service.dart';
import 'package:ecommerce_app/view/auth/login_page.dart';
import 'package:ecommerce_app/view/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ConnectivityService().init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (ConnectivityService().connectionStatus.contains(ConnectivityResult.none)) {
    print('No internet connection...main() returned');
    return;
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    DataManager dataManager = DataManager();
    return ChangeNotifierProvider(
      create: (context) => dataManager,
      builder: (context, dataManager) {
        context.watch<DataManager>();
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(primaryColor: Colors.blue),
          home: FirebaseAuth.instance.currentUser == null ? const LoginPage() : const HomePage(),
          navigatorKey: navigatorKey,
        );
      },
    );
  }
}
