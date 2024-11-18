import 'package:flutter/material.dart';
import 'package:searchbar/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // Set HomePage as the starting screen
      home: const HomePage(),
      debugShowCheckedModeBanner: false, // Disable the debug banner
    );
  }
}
