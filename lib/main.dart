import 'package:flutter/material.dart';

void main() {
  runApp(const RentallApp());
}

class RentallApp extends StatelessWidget {
  const RentallApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rentall',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Rentall')),
        body: const Center(child: Text('Hello, World!')),
      ),
    );
  }
}
