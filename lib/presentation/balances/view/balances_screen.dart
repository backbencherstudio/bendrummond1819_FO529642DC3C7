import 'package:flutter/material.dart';

class BalancesScreen extends StatefulWidget {
  const BalancesScreen({super.key});

  @override
  State<BalancesScreen> createState() => _BalancesScreenState();
}

class _BalancesScreenState extends State<BalancesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('balance screen')));
  }
}
