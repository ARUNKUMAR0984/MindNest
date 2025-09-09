import 'package:ak_mindnest_studio_website/sections/portfolio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MindNest - Professional App & Web Development',
      
      theme: ThemeData(
        textTheme: GoogleFonts.interTextTheme(),
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const PortfolioWebsite(),
    );
  }
}