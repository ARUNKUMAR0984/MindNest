import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'sections.dart';

class WhyChooseUsSection extends StatefulWidget {
  const WhyChooseUsSection({super.key});

  @override
  State<WhyChooseUsSection> createState() => _WhyChooseUsSectionState();
}

class _WhyChooseUsSectionState extends State<WhyChooseUsSection>
    with TickerProviderStateMixin {
  late AnimationController _leftController;
  late AnimationController _rightController;
  late Animation<double> _leftSlideAnimation;
  late Animation<double> _rightSlideAnimation;
  late Animation<double> _fadeAnimation;
  late List<AnimationController> _featureControllers;
  late List<Animation<double>> _featureAnimations;

  int hoveredFeature = -1;

  final List<FeatureItem> _features = [
    FeatureItem(
      icon: Icons.speed_rounded,
      title: "Lightning Fast Delivery",
      description: "Agile development methodology ensures rapid deployment without compromising on quality or security standards.",
      gradient: const LinearGradient(
        colors: [Color(0xFF4A90E2), Color(0xFF357ABD)],
      ),
    ),
    FeatureItem(
      icon: Icons.security_rounded,
      title: "Enterprise Security",
      description: "Built with industry-leading security practices, GDPR compliance, and scalable cloud architecture.",
      gradient: const LinearGradient(
        colors: [Color(0xFF2ECC71), Color(0xFF27AE60)],
      ),
    ),
    FeatureItem(
      icon: Icons.support_agent_rounded,
      title: "24/7 Expert Support",
      description: "Dedicated support team available round-the-clock with guaranteed response times and proactive monitoring.",
      gradient: const LinearGradient(
        colors: [Color(0xFFF39C12), Color(0xFFE67E22)],
      ),
    ),
    FeatureItem(
      icon: Icons.trending_up_rounded,
      title: "Proven Track Record",
      description: "98% client satisfaction rate with 50+ successful projects delivered across various industries and scales.",
      gradient: const LinearGradient(
        colors: [Color(0xFFE74C3C), Color(0xFFC0392B)],
      ),
    ),
    FeatureItem(
      icon: Icons.psychology_rounded,
      title: "Innovation Focused",
      description: "Cutting-edge technologies and creative solutions that keep your business ahead of the competition.",
      gradient: const LinearGradient(
        colors: [Color(0xFF9B59B6), Color(0xFF8E44AD)],
      ),
    ),
    FeatureItem(
      icon: Icons.handshake_rounded,
      title: "Partnership Approach",
      description: "We become an extension of your team, providing strategic guidance and long-term technology partnership.",
      gradient: const LinearGradient(
        colors: [Color(0xFF1ABC9C), Color(0xFF16A085)],
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    
    _leftController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _rightController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _leftSlideAnimation = Tween<double>(
      begin: -100.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _leftController,
      curve: Curves.easeOutQuart,
    ));

    _rightSlideAnimation = Tween<double>(
      begin: 100.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _rightController,
      curve: Curves.easeOutQuart,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _leftController,
      curve: Curves.easeOut,
    ));

    _featureControllers = List.generate(
      _features.length,
      (index) => AnimationController(
        duration: Duration(milliseconds: 400 + (index * 100)),
        vsync: this,
      ),
    );

    _featureAnimations = _featureControllers.map((controller) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeOutBack),
      );
    }).toList();

    _startAnimations();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _leftController.forward();
    
    await Future.delayed(const Duration(milliseconds: 300));
    _rightController.forward();
    
    // Start feature animations
    for (int i = 0; i < _featureControllers.length; i++) {
      await Future.delayed(Duration(milliseconds: 100 + (i * 150)));
      if (mounted) {
        _featureControllers[i].forward();
      }
    }
  }

  @override
  void dispose() {
    _leftController.dispose();
    _rightController.dispose();
    for (var controller in _featureControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final isTablet = MediaQuery.of(context).size.width < 1024;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 80 : 120,
        horizontal: isMobile ? 20 : 50,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFF8FAFC),
            Colors.white,
            const Color(0xFFF0F4FF),
          ],
          stops: const [0.0, 0.5, 1.0],
        ),
      ),
      child: Column(
        children: [
          // Enhanced Section Header
          AnimatedBuilder(
            animation: _fadeAnimation,
            builder: (context, child) {
              return Opacity(
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
                              const Color(0xFF4A90E2).withOpacity(0.1),
                              const Color(0xFF2C3E50).withOpacity(0.05),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: const Color(0xFF4A90E2).withOpacity(0.3),
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
                              "Why Choose MindNest",
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF4A90E2),
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [Color(0xFF4A90E2), Color(0xFF2C3E50)],
                        ).createShader(bounds),
                        child: Text(
                          "Excellence in Every\nPixel & Line of Code",
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
                        "We don't just build software, we craft digital experiences that\ntransform businesses and create lasting partnerships.",
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
              );
            },
          ),

          // Main Content
          if (isMobile)
            _buildMobileLayout()
          else
            _buildDesktopLayout(isTablet),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(bool isTablet) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left Visual Section
        Expanded(
          flex: isTablet ? 1 : 1,
          child: AnimatedBuilder(
            animation: _leftSlideAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(_leftSlideAnimation.value, 0),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: _buildVisualSection(),
                ),
              );
            },
          ),
        ),

        const SizedBox(width: 60),

        // Right Features Column
        Expanded(
          flex: isTablet ? 1 : 1,
          child: AnimatedBuilder(
            animation: _rightSlideAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(_rightSlideAnimation.value, 0),
                child: _buildFeaturesGrid(false),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildVisualSection(),
        const SizedBox(height: 60),
        _buildFeaturesGrid(true),
      ],
    );
  }

  Widget _buildVisualSection() {
    return Container(
      height: 500,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF4A90E2), Color(0xFF357ABD), Color(0xFF2C3E50)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4A90E2).withOpacity(0.3),
            blurRadius: 40,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background pattern
          Positioned.fill(
            child: CustomPaint(
              painter: WhyChooseUsPatternPainter(),
            ),
          ),
          
          // Central content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Main icon with glow effect
                Container(
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.2),
                        blurRadius: 30,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.rocket_launch_rounded,
                    size: 80,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),
                
                // Statistics row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatChip("50+", "Projects"),
                    _buildStatChip("98%", "Success Rate"),
                    _buildStatChip("24/7", "Support"),
                  ],
                ),
                const SizedBox(height: 40),
                
                // Testimonial quote
                Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "\"MindNest transformed our digital presence completely. Their expertise and dedication is unmatched.\"",
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          color: Colors.white.withOpacity(0.9),
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          return Icon(
                            Icons.star,
                            size: 16,
                            color: Colors.amber[300],
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatChip(String number, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
        ),
      ),
      child: Column(
        children: [
          Text(
            number,
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 11,
              color: Colors.white.withOpacity(0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesGrid(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(_features.length, (index) {
        return AnimatedBuilder(
          animation: _featureAnimations[index],
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(30 * (1 - _featureAnimations[index].value), 0),
              child: Opacity(
                opacity: _featureAnimations[index].value,
                child: Transform.scale(
                  scale: 0.8 + (0.2 * _featureAnimations[index].value),
                  child: _buildFeatureItem(_features[index], index),
                ),
              ),
            );
          },
        );
      }),
    );
  }

  Widget _buildFeatureItem(FeatureItem feature, int index) {
    final isHovered = hoveredFeature == index;

    return MouseRegion(
      onEnter: (_) => setState(() => hoveredFeature = index),
      onExit: (_) => setState(() => hoveredFeature = -1),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: 24),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isHovered ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isHovered 
                ? const Color(0xFF4A90E2).withOpacity(0.3)
                : Colors.transparent,
            width: 1.5,
          ),
          boxShadow: isHovered ? [
            BoxShadow(
              color: const Color(0xFF4A90E2).withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ] : null,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon with gradient background
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: feature.gradient,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: feature.gradient.colors.first.withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Icon(
                feature.icon,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 20),
            
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    feature.title,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF2C3E50),
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    feature.description,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: const Color(0xFF6b7280),
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
            
            // Arrow indicator
            if (isHovered)
              Icon(
                Icons.arrow_forward,
                size: 20,
                color: const Color(0xFF4A90E2),
              ),
          ],
        ),
      ),
    );
  }
}

class FeatureItem {
  final IconData icon;
  final String title;
  final String description;
  final LinearGradient gradient;

  FeatureItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.gradient,
  });
}

class WhyChooseUsPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Draw circuit-like patterns
    const double spacing = 40;
    
    // Horizontal lines
    for (double y = spacing; y < size.height; y += spacing) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }
    
    // Vertical lines
    for (double x = spacing; x < size.width; x += spacing) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint,
      );
    }

    // Add some circles at intersections
    paint.style = PaintingStyle.fill;
    for (double x = spacing; x < size.width; x += spacing * 2) {
      for (double y = spacing; y < size.height; y += spacing * 2) {
        canvas.drawCircle(
          Offset(x, y),
          3,
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}