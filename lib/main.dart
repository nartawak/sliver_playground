import 'package:flutter/material.dart';
import 'package:sliver_playground/screens/home.dart';

void main() {
  runApp(const SliverPlaygroundApp());
}

class SliverPlaygroundApp extends StatelessWidget {
  const SliverPlaygroundApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PLay with Sliver',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}
