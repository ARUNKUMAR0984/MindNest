import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'sections.dart';
import 'dart:math' as math;

class TestimonialsSection extends StatefulWidget {
  const TestimonialsSection({super.key});

  @override
  State<TestimonialsSection> createState() => _TestimonialsSectionState();
}

class _TestimonialsSectionState extends State<TestimonialsSection>
    with TickerProviderStateMixin {
  late AnimationController _headerController;
  late AnimationController _backgroundController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  late List<AnimationController> _cardControllers;
  late List<Animation<double>> _cardAnimations;
  
  int hoveredCard = -1;
  int selectedCard = 1; // Middle card selected by default

  final List<TestimonialItem> _testimonials = [
    TestimonialItem(
      review: "MindNest transformed our entire digital ecosystem. Their technical expertise combined with creative vision delivered results beyond our expectations. The team's dedication and professionalism made the entire process seamless.",
      name: "Sarah Johnson",
      role: "CEO, TechStart Innovation",
      company: "TechStart",
      avatar: "S",
      rating: 5,
      gradient: const LinearGradient(
        colors: [Color(0xFF4A90E2), Color(0xFF357ABD)],
      ),
      bgColor: Color(0xFF4A90E2),
    ),
    TestimonialItem(
      review: "Working with MindNest was a game-changer for our business. Their agile approach and constant communication kept us informed throughout. The final product exceeded all our requirements and launched on time.",
      name: "Michael Chen",
      role: "Founder & CTO",
      company: "GrowthCorp Solutions",
      avatar: "M",
      rating: 5,
      gradient: const LinearGradient(
        colors: [Color(0xFF2ECC71), Color(0xFF27AE60)],
      ),
      bgColor: Color(0xFF2ECC71),
    ),
    TestimonialItem(
      review: "The website redesign by MindNest increased our organic traffic by 300% and conversion rates by 150%. Their attention to user experience and modern design principles truly sets them apart from the competition.",
      name: "Emma Davis",
      role: "Marketing Director",
      company: "Digital Growth Co",
      avatar: "E",
      rating: 5,
      gradient: const LinearGradient(
        colors: [Color(0xFFF39C12), Color(0xFFE67E22)],
      ),
      bgColor: Color(0xFFF39C12),
    ),
    TestimonialItem(
      review: "MindNest delivered a robust, scalable solution that handles our enterprise needs perfectly. Their post-launch support and proactive monitoring have been exceptional. Highly recommended for serious projects.",
      name: "David Rodriguez",
      role: "VP of Technology",
      company: "Enterprise Systems Inc",
      avatar: "D",
      rating: 5,
      gradient: const LinearGradient(
        colors: [Color(0xFFE74C3C), Color(0xFFC0392B)],
      ),
      bgColor: Color(0xFFE74C3C),
    ),
    TestimonialItem(
      review: "The mobile app they developed for us has over 100k downloads and maintains a 4.8-star rating. MindNest's innovative approach and cutting-edge technology implementation made all the difference.",
      name: "Lisa Thompson",
      role: "Product Manager",
      company: "InnovateTech",
      avatar: "L",
      rating: 5,
      gradient: const LinearGradient(
        colors: [Color(0xFF9B59B6), Color(0xFF8E44AD)],
      ),
      bgColor: Color(0xFF9B59B6),
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
      duration: const Duration(seconds: 20),
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
      _testimonials.length,
      (index) => AnimationController(
        duration: Duration(milliseconds: 600 + (index * 200)),
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
      await Future.delayed(Duration(milliseconds: 150 + (i * 100)));
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
    final isTablet = MediaQuery.of(context).size.width < 1024;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 80 : 120,
        horizontal: isMobile ? 20 : 50,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFFF8FAFC),
            Colors.white,
            const Color(0xFFF0F4FF),
          ],
          stops: const [0.0, 0.3, 1.0],
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
                  painter: TestimonialPatternPainter(_backgroundController.value),
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
                                    const Color(0xFF2ECC71).withOpacity(0.1),
                                    const Color(0xFF27AE60).withOpacity(0.05),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                  color: const Color(0xFF2ECC71).withOpacity(0.3),
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
                                    "Client Stories",
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF2ECC71),
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                            ShaderMask(
                              shaderCallback: (bounds) => const LinearGradient(
                                colors: [Color(0xFF2ECC71), Color(0xFF4A90E2)],
                              ).createShader(bounds),
                              child: Text(
                                "Trusted by Industry\nLeaders Worldwide",
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
                              "Real results from real partnerships. Discover how we've helped\nbusinesses transform their digital presence and achieve success.",
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

              // Stats Row
              AnimatedBuilder(
                animation: _fadeAnimation,
                builder: (context, child) {
                  return Opacity(
                    opacity: _fadeAnimation.value,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 60),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildStatItem("500+", "Happy Clients", Icons.people_rounded),
                          _buildStatItem("4.9/5", "Average Rating", Icons.star_rounded),
                          _buildStatItem("98%", "Success Rate", Icons.trending_up_rounded),
                        ],
                      ),
                    ),
                  );
                },
              ),

              // Testimonials Carousel
              if (isMobile)
                _buildMobileTestimonials()
              else
                _buildDesktopTestimonials(isTablet),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String number, String label, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFF4A90E2).withOpacity(0.1),
                const Color(0xFF2ECC71).withOpacity(0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFF4A90E2).withOpacity(0.2),
            ),
          ),
          child: Icon(
            icon,
            size: 24,
            color: const Color(0xFF4A90E2),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          number,
          style: GoogleFonts.inter(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF2C3E50),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            color: const Color(0xFF6b7280),
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildDesktopTestimonials(bool isTablet) {
    return Column(
      children: [
        // Main featured testimonial
        AnimatedBuilder(
          animation: _cardAnimations[selectedCard],
          builder: (context, child) {
            return Transform.scale(
              scale: 0.8 + (0.2 * _cardAnimations[selectedCard].value),
              child: Opacity(
                opacity: _cardAnimations[selectedCard].value,
                child: _buildFeaturedTestimonialCard(_testimonials[selectedCard]),
              ),
            );
          },
        ),
        
        const SizedBox(height: 40),
        
        // Thumbnail selector
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_testimonials.length, (index) {
            return AnimatedBuilder(
              animation: _cardAnimations[index],
              builder: (context, child) {
                return Transform.scale(
                  scale: 0.8 + (0.2 * _cardAnimations[index].value),
                  child: Opacity(
                    opacity: _cardAnimations[index].value,
                    child: _buildTestimonialThumbnail(_testimonials[index], index),
                  ),
                );
              },
            );
          }),
        ),
      ],
    );
  }

  Widget _buildMobileTestimonials() {
    return Column(
      children: List.generate(_testimonials.length, (index) {
        return AnimatedBuilder(
          animation: _cardAnimations[index],
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, 30 * (1 - _cardAnimations[index].value)),
              child: Opacity(
                opacity: _cardAnimations[index].value,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 24),
                  child: _buildTestimonialCard(_testimonials[index], index),
                ),
              ),
            );
          },
        );
      }),
    );
  }

  Widget _buildFeaturedTestimonialCard(TestimonialItem testimonial) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 800),
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            const Color(0xFFF8FAFC),
          ],
        ),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: testimonial.bgColor.withOpacity(0.2),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: testimonial.bgColor.withOpacity(0.1),
            blurRadius: 40,
            offset: const Offset(0, 20),
            spreadRadius: 5,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Quote icon
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: testimonial.gradient,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: testimonial.bgColor.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Icon(
              Icons.format_quote,
              size: 32,
              color: Colors.white,
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Review text
          Text(
            testimonial.review,
            style: GoogleFonts.inter(
              fontSize: 18,
              color: const Color(0xFF4b5563),
              fontStyle: FontStyle.italic,
              height: 1.8,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 32),
          
          // Rating
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return Icon(
                Icons.star_rounded,
                color: Colors.amber[400],
                size: 20,
              );
            }),
          ),
          
          const SizedBox(height: 24),
          
          // Author info
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  gradient: testimonial.gradient,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: testimonial.bgColor.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    testimonial.avatar,
                    style: GoogleFonts.inter(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    testimonial.name,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF2C3E50),
                    ),
                  ),
                  Text(
                    testimonial.role,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: const Color(0xFF6b7280),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    testimonial.company,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: testimonial.bgColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonialThumbnail(TestimonialItem testimonial, int index) {
    final isSelected = selectedCard == index;
    
    return GestureDetector(
      onTap: () => setState(() => selectedCard = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: EdgeInsets.all(isSelected ? 20 : 16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected 
                ? testimonial.bgColor.withOpacity(0.5)
                : Colors.transparent,
            width: 2,
          ),
          boxShadow: isSelected ? [
            BoxShadow(
              color: testimonial.bgColor.withOpacity(0.2),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ] : null,
        ),
        child: Column(
          children: [
            Container(
              width: isSelected ? 50 : 40,
              height: isSelected ? 50 : 40,
              decoration: BoxDecoration(
                gradient: testimonial.gradient,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: testimonial.bgColor.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  testimonial.avatar,
                  style: GoogleFonts.inter(
                    fontSize: isSelected ? 20 : 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            if (isSelected) ...[
              const SizedBox(height: 12),
              Text(
                testimonial.name,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF2C3E50),
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                testimonial.company,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: testimonial.bgColor,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTestimonialCard(TestimonialItem testimonial, int index) {
    final isHovered = hoveredCard == index;

    return MouseRegion(
      onEnter: (_) => setState(() => hoveredCard = index),
      onExit: (_) => setState(() => hoveredCard = -1),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isHovered 
                ? testimonial.bgColor.withOpacity(0.3)
                : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: isHovered 
                  ? testimonial.bgColor.withOpacity(0.15)
                  : Colors.black.withOpacity(0.05),
              blurRadius: isHovered ? 25 : 15,
              offset: Offset(0, isHovered ? 15 : 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with avatar and rating
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: testimonial.gradient,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: testimonial.bgColor.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      testimonial.avatar,
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        testimonial.name,
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF2C3E50),
                        ),
                      ),
                      Text(
                        testimonial.role,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: const Color(0xFF6b7280),
                        ),
                      ),
                      Text(
                        testimonial.company,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: testimonial.bgColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(5, (index) {
                    return Icon(
                      Icons.star_rounded,
                      color: Colors.amber[400],
                      size: 16,
                    );
                  }),
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // Review text
            Text(
              '"${testimonial.review}"',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: const Color(0xFF4b5563),
                fontStyle: FontStyle.italic,
                height: 1.7,
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Quote icon
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: testimonial.bgColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.format_quote,
                  size: 20,
                  color: testimonial.bgColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TestimonialItem {
  final String review;
  final String name;
  final String role;
  final String company;
  final String avatar;
  final int rating;
  final LinearGradient gradient;
  final Color bgColor;

  TestimonialItem({
    required this.review,
    required this.name,
    required this.role,
    required this.company,
    required this.avatar,
    required this.rating,
    required this.gradient,
    required this.bgColor,
  });
}

class TestimonialPatternPainter extends CustomPainter {
  final double animationValue;

  TestimonialPatternPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF4A90E2).withOpacity(0.03)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Create floating testimonial bubbles
    for (int i = 0; i < 8; i++) {
      final x = (size.width / 8) * i + 
          (30 * math.sin(animationValue * 2 * math.pi + i));
      final y = (size.height / 4) + 
          (20 * math.cos(animationValue * 2 * math.pi + i * 0.7));
      
      // Draw quote bubbles
      final bubblePath = Path();
      bubblePath.addRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(center: Offset(x, y), width: 40, height: 25),
          const Radius.circular(15),
        ),
      );
      canvas.drawPath(bubblePath, paint);
      
      // Draw small tail
      final tailPath = Path();
      tailPath.moveTo(x - 5, y + 12);
      tailPath.lineTo(x - 10, y + 20);
      tailPath.lineTo(x + 5, y + 12);
      canvas.drawPath(tailPath, paint);
    }
  }

  @override
  bool shouldRepaint(TestimonialPatternPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}

// Add this import at the to