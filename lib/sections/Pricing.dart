import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;
import 'sections.dart';

class PricingSection extends StatefulWidget {
  final VoidCallback onGetStartedPressed;

  const PricingSection({
    super.key,
    required this.onGetStartedPressed,
  });

  @override
  State<PricingSection> createState() => _PricingSectionState();
}

class _PricingSectionState extends State<PricingSection>
    with TickerProviderStateMixin {
  late AnimationController _headerController;
  late AnimationController _backgroundController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  late List<AnimationController> _cardControllers;
  late List<Animation<double>> _cardAnimations;
  
  int hoveredCard = -1;
  bool isAnnual = true;

  final List<PricingPlan> _plans = [
    PricingPlan(
      name: "Starter",
      subtitle: "Perfect for small businesses and startups",
      monthlyPrice: 35000,
      annualPrice: 25000,
      originalPrice: 40000,
      features: [
        PricingFeature("Responsive Website (5 pages)", true),
        PricingFeature("Mobile Optimized Design", true),
        PricingFeature("Basic SEO Setup", true),
        PricingFeature("Contact Forms", true),
        PricingFeature("Google Analytics", true),
        PricingFeature("2 Weeks Delivery", true),
        PricingFeature("3 Months Support", true),
        PricingFeature("Source Code", false),
        PricingFeature("Advanced SEO", false),
      ],
      gradient: const LinearGradient(
        colors: [Color(0xFF10b981), Color(0xFF059669)],
      ),
      bgColor: const Color(0xFF10b981),
      popular: false,
      icon: Icons.rocket_launch_rounded,
    ),
    PricingPlan(
      name: "Professional",
      subtitle: "Ideal for growing businesses with bigger goals",
      monthlyPrice: 95000,
      annualPrice: 75000,
      originalPrice: 120000,
      features: [
        PricingFeature("Custom Web Application", true),
        PricingFeature("Mobile App (iOS/Android)", true),
        PricingFeature("Admin Dashboard", true),
        PricingFeature("API Integration", true),
        PricingFeature("Advanced SEO", true),
        PricingFeature("6-8 Weeks Delivery", true),
        PricingFeature("6 Months Support", true),
        PricingFeature("Source Code Included", true),
        PricingFeature("Priority Support", true),
      ],
      gradient: const LinearGradient(
        colors: [Color(0xFF667eea), Color(0xFF764ba2)],
      ),
      bgColor: const Color(0xFF667eea),
      popular: true,
      icon: Icons.stars_rounded,
    ),
    PricingPlan(
      name: "Enterprise",
      subtitle: "For large-scale projects and enterprise needs",
      monthlyPrice: 0, // Custom pricing
      annualPrice: 0,
      originalPrice: 0,
      features: [
        PricingFeature("Full-Scale Development", true),
        PricingFeature("Custom Architecture", true),
        PricingFeature("Advanced Features", true),
        PricingFeature("Third-party Integrations", true),
        PricingFeature("Dedicated Team", true),
        PricingFeature("Flexible Timeline", true),
        PricingFeature("12 Months Support", true),
        PricingFeature("24/7 Priority Support", true),
        PricingFeature("Custom Training", true),
      ],
      gradient: const LinearGradient(
        colors: [Color(0xFF8b5cf6), Color(0xFF7c3aed)],
      ),
      bgColor: const Color(0xFF8b5cf6),
      popular: false,
      icon: Icons.business_center_rounded,
    ),
  ];

  @override
  void initState() {
    super.initState();
    
    _headerController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _backgroundController = AnimationController(
      duration: const Duration(seconds: 25),
      vsync: this,
    )..repeat();

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _headerController,
      curve: Curves.easeOut,
    ));

    _slideAnimation = Tween<double>(
      begin: 50.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _headerController,
      curve: Curves.easeOutQuart,
    ));

    _cardControllers = List.generate(
      _plans.length,
      (index) => AnimationController(
        duration: Duration(milliseconds: 800 + (index * 200)),
        vsync: this,
      ),
    );

    _cardAnimations = _cardControllers.map((controller) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeOutBack),
      );
    }).toList();

    _startAnimations();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _headerController.forward();
    
    // Start card animations
    for (int i = 0; i < _cardControllers.length; i++) {
      await Future.delayed(Duration(milliseconds: 200 + (i * 150)));
      if (mounted) {
        _cardControllers[i].forward();
      }
    }
  }

  @override
  void dispose() {
    _headerController.dispose();
    _backgroundController.dispose();
    for (var controller in _cardControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 80 : 120,
        horizontal: isMobile ? 20 : 50,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Color(0xFFF8FAFC),
            Color(0xFFF0F4FF),
          ],
          stops: [0.0, 0.6, 1.0],
        ),
      ),
      child: Stack(
        children: [
          // Animated background pattern
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _backgroundController,
              builder: (context, child) {
                return CustomPaint(
                  painter: PricingPatternPainter(_backgroundController.value),
                );
              },
            ),
          ),
          
          Column(
            children: [
              // Enhanced Section Header
              AnimatedBuilder(
                animation: _fadeAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, _slideAnimation.value),
                    child: Opacity(
                      opacity: _fadeAnimation.value,
                      child: Container(
                        margin: EdgeInsets.only(bottom: isMobile ? 60 : 80),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    const Color(0xFF667eea).withOpacity(0.1),
                                    const Color(0xFF8b5cf6).withOpacity(0.05),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                  color: const Color(0xFF667eea).withOpacity(0.3),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF00FF88),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "Transparent Pricing",
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF667eea),
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                            ShaderMask(
                              shaderCallback: (bounds) => const LinearGradient(
                                colors: [Color(0xFF667eea), Color(0xFF8b5cf6)],
                              ).createShader(bounds),
                              child: Text(
                                "Choose Your Perfect\nDevelopment Plan",
                                style: GoogleFonts.inter(
                                  fontSize: isMobile ? 32 : 48,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                  height: 1.1,
                                  letterSpacing: -0.5,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "Flexible pricing options designed to grow with your business.\nNo hidden fees, no surprises - just transparent value.",
                              style: GoogleFonts.inter(
                                fontSize: isMobile ? 16 : 18,
                                color: const Color(0xFF6b7280),
                                height: 1.6,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),

              // Billing Toggle
              AnimatedBuilder(
                animation: _fadeAnimation,
                builder: (context, child) {
                  return Opacity(
                    opacity: _fadeAnimation.value,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 50),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: const Color(0xFFE2E8F0),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildToggleButton("Monthly", !isAnnual),
                            _buildToggleButton("Annual", isAnnual),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),

              // Discount Banner
              if (isAnnual)
                AnimatedBuilder(
                  animation: _fadeAnimation,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _fadeAnimation.value,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 40),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF10b981), Color(0xFF059669)],
                          ),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF10b981).withOpacity(0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.local_offer_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "Save up to 30% with Annual Plans!",
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

              // Pricing Cards
              if (isMobile)
                _buildMobilePricing()
              else
                _buildDesktopPricing(),
                
              // Additional Info
              const SizedBox(height: 60),
              AnimatedBuilder(
                animation: _fadeAnimation,
                builder: (context, child) {
                  return Opacity(
                    opacity: _fadeAnimation.value,
                    child: Container(
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.white,
                            const Color(0xFFF8FAFC),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFFE2E8F0),
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "All plans include:",
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF2C3E50),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Wrap(
                            spacing: 30,
                            runSpacing: 15,
                            alignment: WrapAlignment.center,
                            children: [
                              _buildIncludedFeature(Icons.security_rounded, "Enterprise Security"),
                              _buildIncludedFeature(Icons.speed_rounded, "Lightning Fast"),
                              _buildIncludedFeature(Icons.support_agent_rounded, "24/7 Support"),
                              _buildIncludedFeature(Icons.update_rounded, "Free Updates"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton(String text, bool isSelected) {
    return GestureDetector(
      onTap: () => setState(() => isAnnual = text == "Annual"),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
          boxShadow: isSelected ? [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ] : null,
        ),
        child: Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isSelected ? const Color(0xFF667eea) : const Color(0xFF6b7280),
          ),
        ),
      ),
    );
  }

  Widget _buildIncludedFeature(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: const Color(0xFF667eea).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 16,
            color: const Color(0xFF667eea),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: const Color(0xFF4b5563),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopPricing() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(_plans.length, (index) {
        return AnimatedBuilder(
          animation: _cardAnimations[index],
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, 30 * (1 - _cardAnimations[index].value)),
              child: Transform.scale(
                scale: 0.8 + (0.2 * _cardAnimations[index].value),
                child: Opacity(
                  opacity: _cardAnimations[index].value,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: _buildPricingCard(_plans[index], index),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }

  Widget _buildMobilePricing() {
    return Column(
      children: List.generate(_plans.length, (index) {
        return AnimatedBuilder(
          animation: _cardAnimations[index],
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, 30 * (1 - _cardAnimations[index].value)),
              child: Opacity(
                opacity: _cardAnimations[index].value,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 30),
                  child: _buildPricingCard(_plans[index], index),
                ),
              ),
            );
          },
        );
      }),
    );
  }

  Widget _buildPricingCard(PricingPlan plan, int index) {
    final isHovered = hoveredCard == index;
    final currentPrice = isAnnual ? plan.annualPrice : plan.monthlyPrice;
    final isCustom = plan.name == "Enterprise";

    return MouseRegion(
      onEnter: (_) => setState(() => hoveredCard = index),
      onExit: (_) => setState(() => hoveredCard = -1),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 350,
        decoration: BoxDecoration(
          gradient: isHovered || plan.popular ? LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              plan.bgColor.withOpacity(0.02),
            ],
          ) : const LinearGradient(
            colors: [Colors.white, Colors.white],
          ),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: plan.popular || isHovered 
                ? plan.bgColor.withOpacity(0.5)
                : const Color(0xFFE2E8F0),
            width: plan.popular ? 3 : 2,
          ),
          boxShadow: [
            BoxShadow(
              color: (isHovered || plan.popular) 
                  ? plan.bgColor.withOpacity(0.15)
                  : Colors.black.withOpacity(0.05),
              blurRadius: (isHovered || plan.popular) ? 30 : 15,
              offset: Offset(0, (isHovered || plan.popular) ? 20 : 10),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Popular badge
            if (plan.popular)
              Positioned(
                top: -2,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    gradient: plan.gradient,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(27),
                      topRight: Radius.circular(27),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: Colors.white,
                        size: 16,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "MOST POPULAR",
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            Padding(
              padding: EdgeInsets.only(
                top: plan.popular ? 50 : 30,
                left: 30,
                right: 30,
                bottom: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Plan header
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: plan.gradient,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: plan.bgColor.withOpacity(0.3),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Icon(
                          plan.icon,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              plan.name,
                              style: GoogleFonts.inter(
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF2C3E50),
                              ),
                            ),
                            Text(
                              plan.subtitle,
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: const Color(0xFF6b7280),
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // Pricing
                  if (isCustom)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Custom",
                          style: GoogleFonts.inter(
                            fontSize: 40,
                            fontWeight: FontWeight.w800,
                            color: plan.bgColor,
                          ),
                        ),
                        Text(
                          "Let's discuss your needs",
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: const Color(0xFF6b7280),
                          ),
                        ),
                      ],
                    )
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "₹${(currentPrice / 1000).toStringAsFixed(0)}K",
                              style: GoogleFonts.inter(
                                fontSize: 40,
                                fontWeight: FontWeight.w800,
                                color: plan.bgColor,
                              ),
                            ),
                            if (isAnnual && plan.originalPrice > 0) ...[
                              const SizedBox(width: 12),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF10b981),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  "SAVE ${(((plan.originalPrice - currentPrice) / plan.originalPrice) * 100).toInt()}%",
                                  style: GoogleFonts.inter(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        if (isAnnual && plan.originalPrice > 0)
                          Text(
                            "₹${(plan.originalPrice / 1000).toStringAsFixed(0)}K",
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              color: const Color(0xFF6b7280),
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                      ],
                    ),

                  const SizedBox(height: 30),

                  // Features
                  Column(
                    children: plan.features.map((feature) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                color: feature.included 
                                    ? plan.bgColor.withOpacity(0.2)
                                    : const Color(0xFFF1F5F9),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                feature.included 
                                    ? Icons.check_rounded
                                    : Icons.close_rounded,
                                color: feature.included 
                                    ? plan.bgColor
                                    : const Color(0xFF9CA3AF),
                                size: 16,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                feature.name,
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: feature.included 
                                      ? const Color(0xFF374151)
                                      : const Color(0xFF9CA3AF),
                                  fontWeight: feature.included 
                                      ? FontWeight.w500
                                      : FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 30),

                  // CTA Button
                  Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: plan.gradient,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: plan.bgColor.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: widget.onGetStartedPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text(
                        isCustom ? "Contact Us" : "Get Started",
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PricingPlan {
  final String name;
  final String subtitle;
  final int monthlyPrice;
  final int annualPrice;
  final int originalPrice;
  final List<PricingFeature> features;
  final LinearGradient gradient;
  final Color bgColor;
  final bool popular;
  final IconData icon;

  PricingPlan({
    required this.name,
    required this.subtitle,
    required this.monthlyPrice,
    required this.annualPrice,
    required this.originalPrice,
    required this.features,
    required this.gradient,
    required this.bgColor,
    required this.popular,
    required this.icon,
  });
}

class PricingFeature {
  final String name;
  final bool included;

  PricingFeature(this.name, this.included);
}
class PricingPatternPainter extends CustomPainter {
  final double animationValue;

  PricingPatternPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF667eea).withOpacity(0.03)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Create floating currency symbols
    const symbols = ['₹', '\$', '€', '£'];
    
    for (int i = 0; i < 12; i++) {
      final x = (size.width / 12) * i + 
          (40 * math.sin(animationValue * 2 * math.pi + i * 0.8));
      final y = (size.height / 3) + 
          (30 * math.cos(animationValue * 1.5 * math.pi + i * 1.2));
      
      // Draw symbol background (circles where text could be placed)
      canvas.drawCircle(
        Offset(x, y),
        15,
        paint,
      );
    }

    // Add some diagonal lines
    paint.strokeWidth = 0.5;
    for (int i = 0; i < 8; i++) {
      final startX = i * (size.width / 8);
      final startY = 50 + (20 * math.sin(animationValue * math.pi + i));
      final endX = startX + 100;
      final endY = startY + 50;
      
      canvas.drawLine(
        Offset(startX, startY),
        Offset(endX, endY),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
