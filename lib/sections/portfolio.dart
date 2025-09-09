import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Cta_Section.dart';
import 'PortFolio_section.dart';
import 'Pricing.dart';
import 'Why_chose_us.dart';
import 'contact_section.dart';
import 'custom_app.dart';
import 'footer.dart';
import 'hero_section.dart';
import 'services_section.dart';
import 'stats.dart';
import 'testimonal.dart';

class PortfolioWebsite extends StatefulWidget {
  const PortfolioWebsite({super.key});

  @override
  State<PortfolioWebsite> createState() => _PortfolioWebsiteState();
}

class _PortfolioWebsiteState extends State<PortfolioWebsite> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  final ScrollController _scrollController = ScrollController();
  
  // Global keys for each section
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _portfolioKey = GlobalKey();
  final GlobalKey _pricingKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(GlobalKey key) {
    if (key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: CustomAppBar(
        isMobile: isMobile,
        onAboutPressed: () => _scrollToSection(_aboutKey),
        onServicesPressed: () => _scrollToSection(_servicesKey),
        onPortfolioPressed: () => _scrollToSection(_portfolioKey),
        onPricingPressed: () => _scrollToSection(_pricingKey),
        onContactPressed: () => _scrollToSection(_contactKey),
      ),
      drawer: isMobile ? CustomDrawer(
        onAboutPressed: () {
          Navigator.pop(context);
          _scrollToSection(_aboutKey);
        },
        onServicesPressed: () {
          Navigator.pop(context);
          _scrollToSection(_servicesKey);
        },
        onPortfolioPressed: () {
          Navigator.pop(context);
          _scrollToSection(_portfolioKey);
        },
        onPricingPressed: () {
          Navigator.pop(context);
          _scrollToSection(_pricingKey);
        },
        onContactPressed: () {
          Navigator.pop(context);
          _scrollToSection(_contactKey);
        },
      ) : null,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            HeroSection(
              fadeAnimation: _fadeAnimation,
              onGetStartedPressed: () => _scrollToSection(_contactKey),
              onViewPortfolioPressed: () => _scrollToSection(_portfolioKey),
            ),
            const StatsSection(),
            ServicesSection(key: _servicesKey),
            WhyChooseUsSection(key: _aboutKey),
            PortfolioSection(key: _portfolioKey),
            const TestimonialsSection(),
            PricingSection(
              key: _pricingKey,
              onGetStartedPressed: () => _scrollToSection(_contactKey),
            ),
            CTASection(
              onStartProjectPressed: () => _scrollToSection(_contactKey),
              onScheduleCallPressed: () => _scrollToSection(_contactKey),
            ),
            ContactSection(key: _contactKey),
            const FooterSection(),
          ],
        ),
      ),
    );
  }
}