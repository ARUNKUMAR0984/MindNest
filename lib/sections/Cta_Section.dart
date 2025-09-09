import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

class CTASection extends StatefulWidget {
  final VoidCallback onStartProjectPressed;
  final VoidCallback onScheduleCallPressed;

  const CTASection({
    super.key,
    required this.onStartProjectPressed,
    required this.onScheduleCallPressed,
  });

  @override
  State<CTASection> createState() => _CTASectionState();
}

class _CTASectionState extends State<CTASection>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _backgroundController;
  late AnimationController _floatingController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _scaleAnimation;
  
  bool isPrimaryHovered = false;
  bool isSecondaryHovered = false;

  @override
  void initState() {
    super.initState();
    
    _mainController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    
    _backgroundController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    _floatingController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
    ));

    _slideAnimation = Tween<double>(
      begin: 50.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.2, 1.0, curve: Curves.easeOutQuart),
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.4, 1.0, curve: Curves.easeOutBack),
    ));

    _startAnimation();
  }

  void _startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 200));
    if (mounted) {
      _mainController.forward();
    }
  }

  @override
  void dispose() {
    _mainController.dispose();
    _backgroundController.dispose();
    _floatingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 80 : 120,
        horizontal: isMobile ? 20 : 50,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF667eea),
            Color(0xFF764ba2),
            Color(0xFF8b5cf6),
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
                  painter: CTAPatternPainter(_backgroundController.value),
                );
              },
            ),
          ),

          // Floating elements
          ...List.generate(6, (index) {
            return AnimatedBuilder(
              animation: _floatingController,
              builder: (context, child) {
                final offset = 20 * math.sin(_floatingController.value * 2 * math.pi + index * 1.0);
                return Positioned(
                  left: (screenWidth / 6) * index,
                  top: 40 + offset,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0.1),
                          Colors.white.withOpacity(0.05),
                        ],
                      ),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                      ),
                    ),
                  ),
                );
              },
            );
          }),

          // Main content
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: AnimatedBuilder(
                animation: _mainController,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, _slideAnimation.value),
                    child: Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Opacity(
                        opacity: _fadeAnimation.value,
                        child: Column(
                          children: [
                            // Badge
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.white.withOpacity(0.2),
                                    Colors.white.withOpacity(0.1),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.3),
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
                                    "Let's Build Together",
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 30),

                            // Main heading
                            ShaderMask(
                              shaderCallback: (bounds) => const LinearGradient(
                                colors: [Colors.white, Color(0xFFF0F4FF)],
                              ).createShader(bounds),
                              child: Text(
                                isMobile 
                                    ? "Ready to Transform\nYour Ideas?"
                                    : "Ready to Transform Your Ideas\nInto Digital Reality?",
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

                            const SizedBox(height: 20),

                            // Subtitle
                            Text(
                              "Join hundreds of satisfied clients who trusted us with their digital transformation.\nLet's discuss your project and bring your vision to life.",
                              style: GoogleFonts.inter(
                                fontSize: isMobile ? 16 : 18,
                                color: Colors.white.withOpacity(0.9),
                                height: 1.6,
                              ),
                              textAlign: TextAlign.center,
                            ),

                            const SizedBox(height: 50),

                            // Action buttons
                            if (isMobile)
                              Column(
                                children: [
                                  _buildPrimaryButton(),
                                  const SizedBox(height: 20),
                                  _buildSecondaryButton(),
                                ],
                              )
                            else
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildPrimaryButton(),
                                  const SizedBox(width: 24),
                                  _buildSecondaryButton(),
                                ],
                              ),

                            const SizedBox(height: 40),

                            // Trust indicators
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.white.withOpacity(0.1),
                                    Colors.white.withOpacity(0.05),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.2),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "Trusted by Industry Leaders",
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white.withOpacity(0.9),
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Wrap(
                                    spacing: 30,
                                    runSpacing: 15,
                                    alignment: WrapAlignment.center,
                                    children: [
                                      _buildTrustItem(Icons.speed_rounded, "Fast Delivery"),
                                      _buildTrustItem(Icons.security_rounded, "Secure & Scalable"),
                                      _buildTrustItem(Icons.support_agent_rounded, "24/7 Support"),
                                      _buildTrustItem(Icons.verified_rounded, "Quality Assured"),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrimaryButton() {
    return MouseRegion(
      onEnter: (_) => setState(() => isPrimaryHovered = true),
      onExit: (_) => setState(() => isPrimaryHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..scale(isPrimaryHovered ? 1.05 : 1.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.white, Color(0xFFF8FAFC)],
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: isPrimaryHovered ? 25 : 15,
                offset: Offset(0, isPrimaryHovered ? 15 : 8),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: widget.onStartProjectPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: const Color(0xFF667eea),
              shadowColor: Colors.transparent,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.rocket_launch_rounded, size: 20),
                const SizedBox(width: 12),
                Text(
                  "Start Your Project",
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSecondaryButton() {
    return MouseRegion(
      onEnter: (_) => setState(() => isSecondaryHovered = true),
      onExit: (_) => setState(() => isSecondaryHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..scale(isSecondaryHovered ? 1.05 : 1.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.1),
                Colors.white.withOpacity(0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.1),
                blurRadius: isSecondaryHovered ? 25 : 15,
                offset: Offset(0, isSecondaryHovered ? 15 : 8),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: widget.onScheduleCallPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
              shadowColor: Colors.transparent,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.calendar_today_rounded, size: 18),
                const SizedBox(width: 12),
                Text(
                  "Schedule Call",
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTrustItem(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 16,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: Colors.white.withOpacity(0.9),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class CTAPatternPainter extends CustomPainter {
  final double animationValue;

  CTAPatternPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Create floating geometric shapes
    for (int i = 0; i < 15; i++) {
      final x = (size.width / 15) * i + 
          (30 * math.sin(animationValue * 2 * math.pi + i * 0.6));
      final y = (size.height / 4) + 
          (25 * math.cos(animationValue * 1.8 * math.pi + i * 0.9));
      
      // Draw circles
      canvas.drawCircle(
        Offset(x, y),
        8 + (5 * math.sin(animationValue * 3 * math.pi + i)),
        paint,
      );
    }

    // Add diagonal grid pattern
    paint.strokeWidth = 0.5;
    paint.color = Colors.white.withOpacity(0.05);
    
    for (int i = 0; i < 10; i++) {
      final startX = i * (size.width / 10);
      final startY = 30 + (15 * math.sin(animationValue * math.pi + i * 0.5));
      final endX = startX + 80;
      final endY = startY + 60;
      
      canvas.drawLine(
        Offset(startX, startY),
        Offset(endX, endY),
        paint,
      );
    }

    // Add some hexagonal shapes
    paint.style = PaintingStyle.stroke;
    paint.color = Colors.white.withOpacity(0.08);
    paint.strokeWidth = 2;
    
    for (int i = 0; i < 5; i++) {
      final centerX = (size.width / 5) * i + 
          (40 * math.sin(animationValue * 1.5 * math.pi + i));
      final centerY = size.height * 0.7 + 
          (20 * math.cos(animationValue * 2 * math.pi + i * 1.3));
      
      _drawHexagon(canvas, Offset(centerX, centerY), 20, paint);
    }
  }

  void _drawHexagon(Canvas canvas, Offset center, double radius, Paint paint) {
    final path = Path();
    for (int i = 0; i < 6; i++) {
      final angle = (math.pi / 3) * i;
      final x = center.dx + radius * math.cos(angle);
      final y = center.dy + radius * math.sin(angle);
      
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}