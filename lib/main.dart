import 'package:flutter/material.dart';
import 'package:flutter_assignment/Providers/HeadlinesProvider.dart';
import 'package:flutter_assignment/Screens/HeadlinesScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => HeadlinesProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HeadlinesScreen(),
    );
  }
}
