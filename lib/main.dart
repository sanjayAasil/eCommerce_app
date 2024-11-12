import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecommerce_app/common/global.dart';
import 'package:ecommerce_app/service/network_connectivity_service.dart';
import 'package:ecommerce_app/view/home/home_page.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ConnectivityService().init();

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const HomePage(),
      navigatorKey: navigatorKey,
    );
  }
}
