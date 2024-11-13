import 'package:ecommerce_app/service/firebase_auth.dart';
import 'package:ecommerce_app/view/auth/login_page.dart';
import 'package:ecommerce_app/view/home/product_body.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'cart_body.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController pageController = PageController(initialPage: 0);
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _selectedIndex == 0 ? const Text('eCommerce App') : const Text('Cart Details'),
        actions: [
          if (FirebaseAuth.instance.currentUser != null)
            TextButton(
                onPressed: () {
                  FirebaseAuthManager().signOut();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginPage()));
                },
                child: const Text('Logout'))
        ],
      ),
      body: PageView(
        onPageChanged: _onHomePageSelected,
        controller: pageController,
        children: const [
          ProductBody(),
          CartBody(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        indicatorColor: Colors.blue,
        onDestinationSelected: _onHomePageSelected,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.shopping_cart), label: 'Cart')
        ],
      ),
    );
  }

  _onHomePageSelected(int index) {
    _selectedIndex = index;
    pageController.jumpToPage(index);
    setState(() {});
  }
}
