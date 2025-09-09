import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeroSection extends StatefulWidget {
  final Animation<double> fadeAnimation;
  final VoidCallback onGetStartedPressed;
  final VoidCallback onViewPortfolioPressed;

  const HeroSection({
    super.key,
    required this.fadeAnimation,
    required this.onGetStartedPressed,
    required this.onViewPortfolioPressed,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _floatingController;
  late Animation<double> _floatingAnimation;
  
  @override
  void initState() {
    super.initState();
    _floatingController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
    
    _floatingAnimation = Tween<double>(
      begin: 0.0,
      end: 15.0,
    ).animate(CurvedAnimation(
      parent: _floatingController,
      curve: Curves.easeInOut,
    ));
  }
  
  @override
  void dispose() {
    _floatingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final screenWidth = MediaQuery.of(context).size.width;

    return FadeTransition(
      opacity: widget.fadeAnimation,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 20 : 50,
          vertical: isMobile ? 80 : 120,
        ),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF4A90E2), // MindNest blue
              Color(0xFF357ABD), // Mid gradient
              Color(0xFF2C3E50), // MindNest dark
            ],
            stops: [0.0, 0.6, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Background geometric elements
            Positioned.fill(
              child: CustomPaint(
                painter: GeometricBackgroundPainter(),
              ),
            ),
            
            // Main content
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: isMobile ? 1 : 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Badge
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.3),
                                width: 1,
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
                                const SizedBox(width: 8),
                                Text(
                                  "Leading Development Agency",
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 32),
                          
                          // Main headline
                          RichText(
                            text: TextSpan(
                              style: GoogleFonts.inter(
                                fontSize: isMobile ? 36 : 54,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                height: 1.1,
                                letterSpacing: -0.5,
                              ),
                              children: [
                                const TextSpan(text: "Transform Ideas\ninto "),
                                TextSpan(
                                  text: "Digital Reality",
                                  style: TextStyle(
                                    foreground: Paint()
                                      ..shader = const LinearGradient(
                                        colors: [
                                          Color(0xFF00FF88),
                                          Color(0xFF00D4AA),
                                        ],
                                      ).createShader(
                                        const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
                                      ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          
                          // Subtitle
                          Text(
                            "We craft exceptional mobile applications and cutting-edge websites that drive business growth. From concept to launch, we deliver solutions that make an impact.",
                            style: GoogleFonts.inter(
                              fontSize: isMobile ? 16 : 18,
                              color: Colors.white.withOpacity(0.85),
                              height: 1.6,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 40),
                          
                          // Stats row
                          if (!isMobile)
                            Row(
                              children: [
                                _buildStatItem("50+", "Projects Delivered"),
                                const SizedBox(width: 40),
                                _buildStatItem("98%", "Client Satisfaction"),
                                const SizedBox(width: 40),
                                _buildStatItem("24/7", "Support"),
                              ],
                            ),
                          if (isMobile) ...[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildStatItem("50+", "Projects"),
                                _buildStatItem("98%", "Satisfaction"),
                                _buildStatItem("24/7", "Support"),
                              ],
                            ),
                          ],
                          const SizedBox(height: 40),
                          
                          // Action buttons
                          Wrap(
                            spacing: 16,
                            runSpacing: 16,
                            children: [
                              _buildPrimaryButton(
                                "Start Your Project",
                                widget.onGetStartedPressed,
                              ),
                              _buildSecondaryButton(
                                "View Our Work",
                                widget.onViewPortfolioPressed,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    if (!isMobile) ...[
                      const SizedBox(width: 80),
                      Expanded(
                        child: AnimatedBuilder(
                          animation: _floatingAnimation,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(0, _floatingAnimation.value),
                              child: Container(
                                height: 500,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      blurRadius: 40,
                                      offset: const Offset(0, 20),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Colors.white.withOpacity(0.1),
                                          Colors.white.withOpacity(0.05),
                                        ],
                                      ),
                                      border: Border.all(
                                        color: Colors.white.withOpacity(0.2),
                                        width: 1,
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        // Background pattern
                                        Positioned.fill(
                                          child: CustomPaint(
                                            painter: DevicePatternPainter(),
                                          ),
                                        ),
                                        
                                        // Central device mockup
                                        Center(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              // Phone mockup
                                              Container(
                                                width: 160,
                                                height: 280,
                                                decoration: BoxDecoration(
                                                  color: Colors.white.withOpacity(0.9),
                                                  borderRadius: BorderRadius.circular(25),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black.withOpacity(0.2),
                                                      blurRadius: 20,
                                                      offset: const Offset(0, 10),
                                                    ),
                                                  ],
                                                ),
                                                child: Column(
                                                  children: [
                                                    const SizedBox(height: 20),
                                                    // Status bar
                                                    Container(
                                                      width: 120,
                                                      height: 4,
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey[300],
                                                        borderRadius: BorderRadius.circular(2),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 20),
                                                    // Content area
                                                    Expanded(
                                                      child: Container(
                                                        margin: const EdgeInsets.symmetric(horizontal: 16),
                                                        decoration: BoxDecoration(
                                                          gradient: const LinearGradient(
                                                            colors: [Color(0xFF4A90E2), Color(0xFF2C3E50)],
                                                          ),
                                                          borderRadius: BorderRadius.circular(15),
                                                        ),
                                                        child: const Center(
                                                          child: Icon(
                                                            Icons.smartphone,
                                                            size: 60,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 20),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 30),
                                              
                                              // Laptop mockup
                                              Container(
                                                width: 200,
                                                height: 120,
                                                decoration: BoxDecoration(
                                                  color: Colors.white.withOpacity(0.9),
                                                  borderRadius: BorderRadius.circular(15),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black.withOpacity(0.1),
                                                      blurRadius: 15,
                                                      offset: const Offset(0, 5),
                                                    ),
                                                  ],
                                                ),
                                                child: Column(
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        margin: const EdgeInsets.all(8),
                                                        decoration: BoxDecoration(
                                                          gradient: const LinearGradient(
                                                            colors: [Color(0xFF4A90E2), Color(0xFF2C3E50)],
                                                          ),
                                                          borderRadius: BorderRadius.circular(8),
                                                        ),
                                                        child: const Center(
                                                          child: Icon(
                                                            Icons.laptop_mac,
                                                            size: 40,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 8,
                                                      width: 220,
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey[300],
                                                        borderRadius: const BorderRadius.only(
                                                          bottomLeft: Radius.circular(20),
                                                          bottomRight: Radius.circular(20),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ],
                ),
                
                if (isMobile) ...[
                  const SizedBox(height: 60),
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withOpacity(0.1),
                          Colors.white.withOpacity(0.05),
                        ],
                      ),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.devices,
                        size: 100,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String number, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          number,
          style: GoogleFonts.inter(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF00FF88),
          ),
        ),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            color: Colors.white.withOpacity(0.7),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildPrimaryButton(String text, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF2C3E50),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSecondaryButton(String text, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          side: BorderSide.none,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          text,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class GeometricBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Draw geometric patterns
    for (int i = 0; i < 5; i++) {
      final rect = Rect.fromLTWH(
        size.width * 0.1 + i * 50,
        size.height * 0.1 + i * 30,
        60,
        60,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(10)),
        paint,
      );
    }

    // Draw circles
    for (int i = 0; i < 3; i++) {
      canvas.drawCircle(
        Offset(size.width * 0.8 - i * 40, size.height * 0.2 + i * 50),
        20,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class DevicePatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..strokeWidth = 1;

    const double spacing = 30;
    
    // Draw diagonal lines
    for (double i = -size.height; i < size.width + size.height; i += spacing) {
      canvas.drawLine(
        Offset(i, 0),
        Offset(i + size.height, size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}