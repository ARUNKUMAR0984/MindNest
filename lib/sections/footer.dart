import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

class FooterSection extends StatefulWidget {
  const FooterSection({super.key});

  @override
  State<FooterSection> createState() => _FooterSectionState();
}

class _FooterSectionState extends State<FooterSection>
    with TickerProviderStateMixin {
  late AnimationController _backgroundController;
  late AnimationController _floatingController;
  late AnimationController _mainController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  int hoveredSocialIndex = -1;
  int hoveredLinkIndex = -1;

  final List<FooterLink> footerLinks = [
    FooterLink("Services", ["Web Development", "Mobile Apps", "UI/UX Design", "Consulting"]),
    FooterLink("Company", ["About Us", "Our Team", "Careers", "Blog"]),
    FooterLink("Support", ["Documentation", "Help Center", "Contact", "FAQ"]),
    FooterLink("Legal", ["Privacy Policy", "Terms of Service", "Cookie Policy", "GDPR"]),
  ];

  final List<SocialItem> socialItems = [
    SocialItem(
      icon: Icons.work_outline_rounded,
      label: "LinkedIn",
      color: Color(0xFF0077b5),
      gradient: LinearGradient(colors: [Color(0xFF0077b5), Color(0xFF005885)]),
    ),
    SocialItem(
      icon: Icons.code_rounded,
      label: "GitHub",
      color: Color(0xFF333333),
      gradient: LinearGradient(colors: [Color(0xFF333333), Color(0xFF1a1a1a)]),
    ),
    SocialItem(
      icon: Icons.alternate_email_rounded,
      label: "Twitter",
      color: Color(0xFF1da1f2),
      gradient: LinearGradient(colors: [Color(0xFF1da1f2), Color(0xFF0d8bd9)]),
    ),
    SocialItem(
      icon: Icons.language_rounded,
      label: "Website",
      color: Color(0xFF667eea),
      gradient: LinearGradient(colors: [Color(0xFF667eea), Color(0xFF764ba2)]),
    ),
    SocialItem(
      icon: Icons.email_outlined,
      label: "Email",
      color: Color(0xFF10b981),
      gradient: LinearGradient(colors: [Color(0xFF10b981), Color(0xFF059669)]),
    ),
  ];

  @override
  void initState() {
    super.initState();
    
    _backgroundController = AnimationController(
      duration: const Duration(seconds: 30),
      vsync: this,
    )..repeat();

    _floatingController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: true);

    _mainController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: Curves.easeOut,
    ));

    _slideAnimation = Tween<double>(
      begin: 30.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: Curves.easeOutQuart,
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
    _backgroundController.dispose();
    _floatingController.dispose();
    _mainController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF1a1a1a),
            Color(0xFF0f0f0f),
            Color(0xFF000000),
          ],
          stops: [0.0, 0.7, 1.0],
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
                  painter: FooterPatternPainter(_backgroundController.value),
                );
              },
            ),
          ),

          // Floating elements
          ...List.generate(12, (index) {
            return AnimatedBuilder(
              animation: _floatingController,
              builder: (context, child) {
                final offset = 10 * math.sin(_floatingController.value * 2 * math.pi + index * 0.5);
                return Positioned(
                  left: (screenWidth / 12) * index,
                  top: 20 + offset,
                  child: Container(
                    width: 3,
                    height: 3,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              },
            );
          }),

          // Main content
          AnimatedBuilder(
            animation: _fadeAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _slideAnimation.value),
                child: Opacity(
                  opacity: _fadeAnimation.value,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: isMobile ? 60 : 80,
                      horizontal: isMobile ? 20 : 50,
                    ),
                    child: Column(
                      children: [
                        // Main footer content
                        if (isMobile)
                          _buildMobileFooter()
                        else
                          _buildDesktopFooter(),

                        SizedBox(height: isMobile ? 40 : 60),

                        // Divider with gradient
                        Container(
                          height: 1,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                Color(0xFF667eea),
                                Color(0xFF8b5cf6),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: isMobile ? 30 : 40),

                        // Bottom section
                        _buildBottomSection(isMobile),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopFooter() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Logo and company info (40% width)
        Expanded(
          flex: 2,
          child: _buildCompanyInfo(),
        ),

        const SizedBox(width: 60),

        // Links sections (60% width)
        Expanded(
          flex: 3,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: footerLinks.asMap().entries.map((entry) {
              return Expanded(
                child: Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: _buildLinkSection(entry.value, entry.key),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileFooter() {
    return Column(
      children: [
        _buildCompanyInfo(),
        const SizedBox(height: 40),
        Wrap(
          spacing: 40,
          runSpacing: 30,
          children: footerLinks.asMap().entries.map((entry) {
            return SizedBox(
              width: 140,
              child: _buildLinkSection(entry.value, entry.key),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCompanyInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Logo and brand
        Row(
  mainAxisSize: MainAxisSize.min,
  children: [
    // Logo (clean, no gradient)
    Container(
  padding: const EdgeInsets.all(8),
  decoration: BoxDecoration(
    color: Colors.white, // White background
    borderRadius: BorderRadius.circular(8),
  ),
  child: Image.asset(
    'assets/MindNest.png',
    height: 80,
    width: 80,
    fit: BoxFit.contain,
  ),
),

    const SizedBox(width: 16),

    // Brand name + tagline
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
  text: TextSpan(
    children: [
      TextSpan(
        text: "Mind",
        style: GoogleFonts.raleway(
          fontSize: 28,
          fontWeight: FontWeight.w800,
          color: Color(0xff408dc3), // First color
          letterSpacing: -0.5,
        ),
      ),
      TextSpan(
        text: "Nest",
        style: GoogleFonts.raleway(
          fontSize: 28,
          fontWeight: FontWeight.w800,
          color: Color.fromARGB(255, 134, 134, 134), // Second color
          letterSpacing: -0.5,
        ),
      ),
    ],
  ),
),
        Text(
          "Development Studio",
          style: GoogleFonts.inter(
            fontSize: 12,
            color: Colors.grey[400],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  ],
),


        const SizedBox(height: 20),

        // Description
        Text(
          "Transforming ideas into exceptional digital experiences through innovative web and mobile app development.",
          style: GoogleFonts.inter(
            fontSize: 14,
            color: Colors.grey[400],
            height: 1.5,
          ),
          maxLines: 3,
        ),

        const SizedBox(height: 24),

        // Contact info
        _buildContactItem(Icons.location_on_outlined, "Coimbatore, Tamil Nadu, India"),
        _buildContactItem(Icons.email_outlined, "hello@mindnest.dev"),
        _buildContactItem(Icons.phone_outlined, "+91 98765 43210"),

        const SizedBox(height: 30),

        // Social media
        Text(
          "Follow us",
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: socialItems.asMap().entries.map((entry) {
            return _buildSocialButton(entry.value, entry.key);
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: Colors.grey[500],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.inter(
                fontSize: 13,
                color: Colors.grey[400],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLinkSection(FooterLink linkSection, int sectionIndex) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          linkSection.title,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        ...linkSection.links.asMap().entries.map((entry) {
          final linkIndex = sectionIndex * 100 + entry.key; // Unique index
          final isHovered = hoveredLinkIndex == linkIndex;
          
          return MouseRegion(
            onEnter: (_) => setState(() => hoveredLinkIndex = linkIndex),
            onExit: (_) => setState(() => hoveredLinkIndex = -1),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(bottom: 8),
              child: InkWell(
                onTap: () {}, // Add navigation logic
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: isHovered ? const Color(0xFF667eea) : Colors.grey[400]!,
                    fontWeight: isHovered ? FontWeight.w500 : FontWeight.w400,
                  ),
                  child: Text(entry.value),
                ),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildSocialButton(SocialItem item, int index) {
    final isHovered = hoveredSocialIndex == index;

    return MouseRegion(
      onEnter: (_) => setState(() => hoveredSocialIndex = index),
      onExit: (_) => setState(() => hoveredSocialIndex = -1),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..scale(isHovered ? 1.1 : 1.0),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: isHovered ? item.gradient : null,
            color: isHovered ? null : item.color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isHovered ? Colors.transparent : item.color.withOpacity(0.3),
            ),
            boxShadow: isHovered ? [
              BoxShadow(
                color: item.color.withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ] : null,
          ),
          child: Icon(
            item.icon,
            size: 18,
            color: isHovered ? Colors.white : item.color,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSection(bool isMobile) {
    return Column(
      children: [
        if (isMobile)
          Column(
            children: [
              _buildCopyright(),
              const SizedBox(height: 16),
              _buildBottomLinks(),
            ],
          )
        else
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCopyright(),
              _buildBottomLinks(),
            ],
          ),

        const SizedBox(height: 20),

        // Made with love
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Made with",
              style: GoogleFonts.inter(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(width: 6),
            const Icon(
              Icons.favorite,
              size: 14,
              color: Color(0xFFEF4444),
            ),
            const SizedBox(width: 6),
            Text(
              "in India",
              style: GoogleFonts.inter(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCopyright() {
    return Text(
      "© ${DateTime.now().year} MindNest. All rights reserved.",
      style: GoogleFonts.inter(
        fontSize: 12,
        color: Colors.grey[500],
      ),
    );
  }

  Widget _buildBottomLinks() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildBottomLink("Privacy"),
        const SizedBox(width: 20),
        _buildBottomLink("Terms"),
        const SizedBox(width: 20),
        _buildBottomLink("Cookies"),
      ],
    );
  }

  Widget _buildBottomLink(String text) {
    return InkWell(
      onTap: () {}, // Add navigation logic
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 12,
          color: Colors.grey[400],
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}

class FooterLink {
  final String title;
  final List<String> links;

  FooterLink(this.title, this.links);
}

class SocialItem {
  final IconData icon;
  final String label;
  final Color color;
  final LinearGradient gradient;

  SocialItem({
    required this.icon,
    required this.label,
    required this.color,
    required this.gradient,
  });
}

class FooterPatternPainter extends CustomPainter {
  final double animationValue;

  FooterPatternPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;

    // Create constellation-like pattern
    for (int i = 0; i < 20; i++) {
      final x = (size.width / 20) * i + 
          (30 * math.sin(animationValue * 2 * math.pi + i * 0.4));
      final y = (size.height / 4) + 
          (20 * math.cos(animationValue * 1.5 * math.pi + i * 0.7));
      
      paint.color = Colors.white.withOpacity(0.03);
      
      // Draw small dots
      canvas.drawCircle(
        Offset(x, y),
        1.5,
        Paint()..color = Colors.white.withOpacity(0.1),
      );
      
      // Connect some dots with lines
      if (i < 19) {
        final nextX = (size.width / 20) * (i + 1) + 
            (30 * math.sin(animationValue * 2 * math.pi + (i + 1) * 0.4));
        final nextY = (size.height / 4) + 
            (20 * math.cos(animationValue * 1.5 * math.pi + (i + 1) * 0.7));
        
        if ((nextX - x).abs() < 100 && (nextY - y).abs() < 50) {
          canvas.drawLine(
            Offset(x, y),
            Offset(nextX, nextY),
            paint,
          );
        }
      }
    }

    // Add some geometric shapes
    paint.color = Colors.white.withOpacity(0.02);
    for (int i = 0; i < 8; i++) {
      final centerX = (size.width / 8) * i + 
          (25 * math.cos(animationValue * 1.8 * math.pi + i * 0.6));
      final centerY = size.height * 0.7 + 
          (15 * math.sin(animationValue * 2.2 * math.pi + i * 0.9));
      
      // Draw hexagons
      _drawHexagon(canvas, Offset(centerX, centerY), 8, paint);
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
=======

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey[200],
      child: const Text(
        "© 2025 Ak MindNest Studio | Built with Flutter Web",
        textAlign: TextAlign.center,
      ),
    );
  }
>>>>>>> 6c41c54 (Second Commit)
}