import 'package:flutter/material.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  _fetchData() async {}

  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }
}
