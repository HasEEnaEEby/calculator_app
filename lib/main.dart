import 'package:flutter/material.dart';
import 'screens/calculator_app.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator Application ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CalculatorView(),  
      debugShowCheckedModeBanner: false,
    );
  }
}
