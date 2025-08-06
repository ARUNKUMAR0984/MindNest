import 'package:flutter/material.dart';
import 'sections/navbar.dart';
import 'sections/hero_section.dart';
import 'sections/services_section.dart';
import 'sections/projects_section.dart';
import 'sections/contact_section.dart';
import 'sections/footer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ak MindNest Studio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Arial',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Column(
        children: [Navbar(
                servicesKey: _servicesKey,
                projectsKey: _projectsKey,
                contactKey: _contactKey,
              ),Expanded(child:  SingleChildScrollView(
          child: Column(
            children: [
              
              const HeroSection(),
              KeyedSubtree(key: _servicesKey, child: const ServicesSection()),
              KeyedSubtree(key: _projectsKey, child: const ProjectsSection()),
              KeyedSubtree(key: _contactKey, child: const ContactSection()),
              const Footer(),
            ],
          ),
        ),)]
          
        ),
        

    );
  }
}
