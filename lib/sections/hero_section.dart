import 'package:flutter/material.dart';
<<<<<<< HEAD
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
=======
import 'package:url_launcher/url_launcher.dart';
import 'dart:math' as math;

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});
>>>>>>> 6c41c54 (Second Commit)

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
<<<<<<< HEAD
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
=======
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _parallaxController;
  late AnimationController _pulseController;
  
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _pulseAnimation;
  late List<Animation<double>> _skillCardAnimations;
  late List<Animation<Offset>> _skillSlideAnimations;

  @override
  void initState() {
    super.initState();
    
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _parallaxController = AnimationController(
      duration: const Duration(seconds: 30),
      vsync: this,
    )..repeat();
    
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOutCubic),
    );
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.4),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOutBack));
    
    _pulseAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Staggered animations for skill cards
    _skillCardAnimations = List.generate(6, (index) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _fadeController,
          curve: Interval(
            0.3 + (index * 0.1),
            0.8 + (index * 0.1),
            curve: Curves.elasticOut,
          ),
        ),
      );
    });

    _skillSlideAnimations = List.generate(6, (index) {
      return Tween<Offset>(
        begin: const Offset(0, 0.5),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _fadeController,
          curve: Interval(
            0.3 + (index * 0.1),
            0.8 + (index * 0.1),
            curve: Curves.easeOutBack,
          ),
        ),
      );
    });

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _parallaxController.dispose();
    _pulseController.dispose();
>>>>>>> 6c41c54 (Second Commit)
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
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
=======
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFF8FAFC),
            Colors.white,
            const Color(0xFFF1F5F9),
            const Color(0xFFF8FAFC),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Animated background elements
          _buildAnimatedBackground(),
          
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 120, horizontal: 24),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1400),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Column(
                      children: [
                        // Enhanced hero header
                        _buildEnhancedHeroHeader(),
                        
                        const SizedBox(height: 60),
                        
                        // Enhanced introduction card
                        _buildEnhancedIntroCard(),
                        
                        const SizedBox(height: 80),
                        
                        // Skills section with enhanced design
                        _buildEnhancedSkillsSection(),
                        
                        const SizedBox(height: 80),
                        
                        // Stats section
                        _buildStatsSection(),
                        
                        const SizedBox(height: 80),
                        
                        // Enhanced call to action
                        _buildEnhancedCallToAction(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedBackground() {
    return AnimatedBuilder(
      animation: _parallaxController,
      builder: (context, child) {
        return Positioned.fill(
          child: CustomPaint(
            painter: HeroBackgroundPainter(_parallaxController.value),
          ),
        );
      },
    );
  }

  Widget _buildEnhancedHeroHeader() {
    return Column(
      children: [
        // Status badge
        AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF10B981).withOpacity(0.1 + _pulseAnimation.value * 0.05),
                    const Color(0xFF059669).withOpacity(0.05 + _pulseAnimation.value * 0.03),
                  ],
                ),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: const Color(0xFF10B981).withOpacity(0.3 + _pulseAnimation.value * 0.2),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF10B981).withOpacity(0.1 + _pulseAnimation.value * 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'AVAILABLE FOR PROJECTS',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF10B981),
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        
        const SizedBox(height: 32),
        
        // Main heading with enhanced gradient
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF374151),
              const Color(0xFF6B7280),
              const Color(0xFF8B5CF6),
              const Color(0xFF6366F1),
            ],
            stops: [0.0, 0.3, 0.7, 1.0],
          ).createShader(bounds),
          child: Text(
            "Hi, I'm Arunkumar",
            style: TextStyle(
              fontSize: 64,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: -2,
              height: 1.1,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        
        const SizedBox(height: 20),
        
        // Enhanced subtitle with gradient background
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFF8B5CF6).withOpacity(0.08),
                const Color(0xFF6366F1).withOpacity(0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: const Color(0xFF8B5CF6).withOpacity(0.2),
              width: 1,
            ),
          ),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
                height: 1.3,
              ),
              children: [
                TextSpan(
                  text: 'Flutter Developer',
                  style: TextStyle(color: const Color(0xFF8B5CF6)),
                ),
                TextSpan(
                  text: ' & ',
                  style: TextStyle(color: const Color(0xFF6B7280)),
                ),
                TextSpan(
                  text: 'Apppreneur',
                  style: TextStyle(color: const Color(0xFF6366F1)),
                ),
                TextSpan(
                  text: '\nat ',
                  style: TextStyle(color: const Color(0xFF6B7280)),
                ),
                TextSpan(
                  text: 'AK MindNest Studio',
                  style: TextStyle(color: const Color(0xFF374151)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEnhancedIntroCard() {
    return Container(
      padding: const EdgeInsets.all(50),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            const Color(0xFFFAFAFA),
          ],
        ),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8B5CF6).withOpacity(0.08),
            blurRadius: 40,
            offset: const Offset(0, 20),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Quote icon
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF8B5CF6),
                  const Color(0xFF6366F1),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF8B5CF6).withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Icon(
              Icons.format_quote,
              color: Colors.white,
              size: 32,
            ),
          ),
          
          const SizedBox(height: 32),
          
          Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Text(
              "I'm a passionate Flutter and MERN stack developer with a strong foundation in mobile app development, UI/UX design, and data visualization. I specialize in building fast, scalable, and user-friendly apps that are already live on the Google Play Store. My goal is to turn ideas into pixel-perfect apps that users love.",
              style: TextStyle(
                fontSize: 18,
                color: const Color(0xFF374151),
                height: 1.7,
                letterSpacing: 0.3,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Key highlights row
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFF8B5CF6).withOpacity(0.1)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildHighlightItem(Icons.apps, 'Live Apps', 'on Play Store'),
                Container(width: 1, height: 40, color: Colors.grey[300]),
                _buildHighlightItem(Icons.code, 'Full Stack', 'Development'),
                Container(width: 1, height: 40, color: Colors.grey[300]),
                _buildHighlightItem(Icons.design_services, 'UI/UX', 'Design'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHighlightItem(IconData icon, String title, String subtitle) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFF8B5CF6).withOpacity(0.1),
                const Color(0xFF6366F1).withOpacity(0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: const Color(0xFF8B5CF6),
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF374151),
          ),
        ),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 12,
            color: const Color(0xFF6B7280),
>>>>>>> 6c41c54 (Second Commit)
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

<<<<<<< HEAD
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
=======
  Widget _buildEnhancedSkillsSection() {
    final skills = [
      {
        'icon': Icons.code,
        'title': 'Languages & Tools',
        'subtitle': 'Dart, Flutter, Firebase, Supabase, SQLite',
        'color': const Color(0xFF8B5CF6),
        'category': 'Technical',
      },
      {
        'icon': Icons.phone_android,
        'title': 'Published Apps',
        'subtitle': '2048 Game, PomoPro, DocForge',
        'color': const Color(0xFF10B981),
        'category': 'Portfolio',
      },
      {
        'icon': Icons.psychology,
        'title': 'Focus Areas',
        'subtitle': 'Productivity tools, Student platforms, PDF utilities',
        'color': const Color(0xFFF59E0B),
        'category': 'Expertise',
      },
      {
        'icon': Icons.rocket_launch,
        'title': 'Current Project',
        'subtitle': 'DocForge PDF Utility & Notes Sharing App',
        'color': const Color(0xFFEF4444),
        'category': 'Active',
      },
      {
        'icon': Icons.monetization_on,
        'title': 'Monetization',
        'subtitle': 'Google AdMob, In-app Ads',
        'color': const Color(0xFF3B82F6),
        'category': 'Revenue',
      },
      {
        'icon': Icons.handshake,
        'title': 'Availability',
        'subtitle': 'Open to Freelance Projects & Collaborations',
        'color': const Color(0xFF6366F1),
        'category': 'Status',
      },
    ];

    return Column(
      children: [
        // Section header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFF8B5CF6).withOpacity(0.1),
                const Color(0xFF6366F1).withOpacity(0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: const Color(0xFF8B5CF6).withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.star,
                size: 16,
                color: const Color(0xFF8B5CF6),
              ),
              const SizedBox(width: 8),
              Text(
                'MY EXPERTISE',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF8B5CF6),
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 24),
        
        Column(
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [

    // Gradient Title
    ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [
          Color(0xFF374151),
          Color(0xFF8B5CF6),
        ],
      ).createShader(bounds),
      child: const Text(
        "Skills & Expertise",
        style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.w900,
          color: Colors.white, // Required for ShaderMask to apply gradient
          letterSpacing: -1,
        ),
        textAlign: TextAlign.center,
      ),
    ),

    const SizedBox(height: 20),

    // Description Text
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 700),
        child: const Text(
          'A comprehensive skill set focused on delivering exceptional mobile experiences and scalable solutions.',
          style: TextStyle(
            fontSize: 18,
            color: Color(0xFF4B5563),
            height: 1.8,
            letterSpacing: 0.3,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ),

    const SizedBox(height: 48),

    // Skills Grid Without Animation
LayoutBuilder(
  builder: (context, constraints) {
    int crossAxisCount = 3;

    if (constraints.maxWidth < 600) {
      crossAxisCount = 1;
    } else if (constraints.maxWidth < 900) {
      crossAxisCount = 2;
    }

    return Container(
    
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: skills.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 10,
          mainAxisSpacing: 15,
          childAspectRatio: 1.2, // Adjust this for card width/height ratio
        ),
        itemBuilder: (context, index) {
          final skill = skills[index];
          return EnhancedSkillCard(skill: skill, index: index);
        },
      ),
    );
  },
)
,



    const SizedBox(height: 80),
  ],
)

      ],
    );
  }

  Widget _buildStatsSection() {
    final stats = [
      {'number': '1+', 'label': 'Years Experience', 'icon': Icons.timeline},
      {'number': '3+', 'label': 'Published Apps', 'icon': Icons.mobile_friendly},
      {'number': '100%', 'label': 'Client Satisfaction', 'icon': Icons.sentiment_very_satisfied},
      {'number': '24/7', 'label': 'Support Available', 'icon': Icons.support_agent},
    ];

    return Container(
      padding: const EdgeInsets.all(50),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF8B5CF6),
            const Color(0xFF6366F1),
            const Color(0xFF3B82F6),
          ],
        ),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8B5CF6).withOpacity(0.4),
            blurRadius: 40,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Delivering Excellence',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: -0.8,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: 40,
            runSpacing: 30,
            alignment: WrapAlignment.center,
            children: stats.map((stat) {
              return Container(
                width: 200,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      stat['icon'] as IconData,
                      color: Colors.white,
                      size: 32,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      stat['number'] as String,
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      stat['label'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.9),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedCallToAction() {
    final buttons = [
      {
        'label': 'Visit My GitHub',
        'url': 'https://github.com/ARUNKUMAR0984',
        'icon': Icons.code,
        'isPrimary': true,
        'color': const Color(0xFF374151),
      },
      {
        'label': 'My Apps',
        'url': 'https://play.google.com/store/apps/developer?id=AK+MindNest+Studio',
        'icon': Icons.phone_android,
        'isPrimary': false,
        'color': const Color(0xFF10B981),
      },
      {
        'label': 'Connect on LinkedIn',
        'url': 'https://linkedin.com/in/arunkumar-s-8388a3252',
        'icon': Icons.business,
        'isPrimary': false,
        'color': const Color(0xFF3B82F6),
      },
      {
        'label': 'Contact Me',
        'url': 'mailto:arunkumars97462@gmail.com',
        'icon': Icons.email,
        'isPrimary': true,
        'color': const Color(0xFF8B5CF6),
      },
    ];

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFF8B5CF6).withOpacity(0.1),
                const Color(0xFF6366F1).withOpacity(0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: const Color(0xFF8B5CF6).withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.rocket_launch,
                size: 16,
                color: const Color(0xFF8B5CF6),
              ),
              const SizedBox(width: 8),
              Text(
                'LET\'S CONNECT',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF8B5CF6),
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 24),
        
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [
              const Color(0xFF374151),
              const Color(0xFF8B5CF6),
            ],
          ).createShader(bounds),
          child: Text(
            "Let's Work Together",
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: -1,
            ),
          ),
        ),
        
        const SizedBox(height: 16),
        
        Container(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Text(
            'Ready to bring your app idea to life? Let\'s discuss your project and create something amazing together.',
            style: TextStyle(
              fontSize: 16,
              color: const Color(0xFF6B7280),
              height: 1.6,
              letterSpacing: 0.2,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        
        const SizedBox(height: 40),
        
        Wrap(
          spacing: 20,
          runSpacing: 20,
          alignment: WrapAlignment.center,
          children: buttons.map((button) => EnhancedActionButton(button: button)).toList(),
        ),
        
        const SizedBox(height: 32),
        
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF10B981).withOpacity(0.1),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: const Color(0xFF10B981).withOpacity(0.2),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.schedule,
                size: 16,
                color: const Color(0xFF10B981),
              ),
              const SizedBox(width: 8),
              Text(
                'Usually responds within 2-4 hours',
                style: TextStyle(
                  fontSize: 14,
                  color: const Color(0xFF10B981),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}

class EnhancedSkillCard extends StatefulWidget {
  final Map<String, dynamic> skill;
  final int index;

  const EnhancedSkillCard({
    super.key,
    required this.skill,
    required this.index,
  });

  @override
  State<EnhancedSkillCard> createState() => _EnhancedSkillCardState();
}

class _EnhancedSkillCardState extends State<EnhancedSkillCard>
    with SingleTickerProviderStateMixin {
  bool isHovered = false;
  late AnimationController _hoverController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeOut),
    );
    _elevationAnimation = Tween<double>(begin: 12.0, end: 25.0).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => isHovered = true);
        _hoverController.forward();
      },
      onExit: (_) {
        setState(() => isHovered = false);
        _hoverController.reverse();
      },
      child: AnimatedBuilder(
        animation: _hoverController,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: 340,
              height: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white,
                    const Color(0xFFFAFAFA),
                  ],
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: widget.skill['color'].withOpacity(0.2),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: widget.skill['color'].withOpacity(0.15),
                    blurRadius: _elevationAnimation.value,
                    offset: const Offset(0, 12),
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: widget.skill['color'].withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: widget.skill['color'].withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        widget.skill['category'],
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: widget.skill['color'],
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Icon with enhanced styling
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            widget.skill['color'].withOpacity(0.15),
                            widget.skill['color'].withOpacity(0.05),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: widget.skill['color'].withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        widget.skill['icon'],
                        size: 40,
                        color: widget.skill['color'],
                      ),
                    ),
                    
            SizedBox(height: 16),
                    
                    // Title and subtitle
                    Text(
                      widget.skill['title'],
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF374151),
                        letterSpacing: -0.2,
                      ),
                    ),
                    
                    const SizedBox(height: 8),
                    const SizedBox(height: 16),
                    
                    Text(
                      widget.skill['subtitle'],
                      style: TextStyle(
                        fontSize: 20,
                        color: const Color(0xFF6B7280),
                        height: 1.4,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Hover indicator
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: 3,
                      width: isHovered ? 60 : 30,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            widget.skill['color'],
                            widget.skill['color'].withOpacity(0.5),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
>>>>>>> 6c41c54 (Second Commit)
      ),
    );
  }
}

<<<<<<< HEAD
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
=======
class EnhancedActionButton extends StatefulWidget {
  final Map<String, dynamic> button;

  const EnhancedActionButton({
    super.key,
    required this.button,
  });

  @override
  State<EnhancedActionButton> createState() => _EnhancedActionButtonState();
}

class _EnhancedActionButtonState extends State<EnhancedActionButton>
    with SingleTickerProviderStateMixin {
  bool isHovered = false;
  late AnimationController _hoverController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeOut),
    );
    _elevationAnimation = Tween<double>(begin: 8.0, end: 16.0).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isPrimary = widget.button['isPrimary'] as bool;
    final color = widget.button['color'] as Color;

    return MouseRegion(
      onEnter: (_) {
        setState(() => isHovered = true);
        _hoverController.forward();
      },
      onExit: (_) {
        setState(() => isHovered = false);
        _hoverController.reverse();
      },
      child: AnimatedBuilder(
        animation: _hoverController,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: GestureDetector(
              onTap: () => _launchUrl(widget.button['url'] as String),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                decoration: BoxDecoration(
                  gradient: isPrimary
                      ? LinearGradient(
                          colors: [
                            color,
                            color.withOpacity(0.8),
                          ],
                        )
                      : null,
                  color: isPrimary ? null : Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: isPrimary ? Colors.transparent : color.withOpacity(0.3),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(isPrimary ? 0.3 : 0.1),
                      blurRadius: _elevationAnimation.value,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      widget.button['icon'] as IconData,
                      size: 20,
                      color: isPrimary ? Colors.white : color,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      widget.button['label'] as String,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isPrimary ? Colors.white : color,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}

class HeroBackgroundPainter extends CustomPainter {
  final double animationValue;

  HeroBackgroundPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color(0xFF8B5CF6).withOpacity(0.02);

    // Create floating geometric shapes
    for (int i = 0; i < 15; i++) {
      final offset = Offset(
        (size.width * 0.1 * i) + (math.sin(animationValue * 2 * math.pi + i) * 50),
        (size.height * 0.2 * (i % 3)) + (math.cos(animationValue * 2 * math.pi + i) * 30),
      );

      if (i % 3 == 0) {
        // Draw circles
        paint.color = const Color(0xFF8B5CF6).withOpacity(0.03);
        canvas.drawCircle(offset, 20 + (math.sin(animationValue * math.pi + i) * 5), paint);
      } else if (i % 3 == 1) {
        // Draw rectangles
        paint.color = const Color(0xFF6366F1).withOpacity(0.02);
        final rect = Rect.fromCenter(
          center: offset,
          width: 30 + (math.cos(animationValue * math.pi + i) * 8),
          height: 30 + (math.sin(animationValue * math.pi + i) * 8),
        );
        canvas.drawRRect(
          RRect.fromRectAndRadius(rect, const Radius.circular(8)),
          paint,
        );
      } else {
        // Draw triangles
        paint.color = const Color(0xFF10B981).withOpacity(0.025);
        final path = Path();
        final radius = 15 + (math.sin(animationValue * math.pi + i) * 3);
        path.moveTo(offset.dx, offset.dy - radius);
        path.lineTo(offset.dx - radius, offset.dy + radius);
        path.lineTo(offset.dx + radius, offset.dy + radius);
        path.close();
        canvas.drawPath(path, paint);
      }
    }

    // Draw gradient overlay lines
    final linePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = const Color(0xFF8B5CF6).withOpacity(0.1);

    for (int i = 0; i < 5; i++) {
      final startY = size.height * 0.2 * i + (math.sin(animationValue * math.pi + i) * 20);
      final endY = startY + 100;
      
      canvas.drawLine(
        Offset(size.width * 0.1 + (i * 50), startY),
        Offset(size.width * 0.9 - (i * 30), endY),
        linePaint,
>>>>>>> 6c41c54 (Second Commit)
      );
    }
  }

  @override
<<<<<<< HEAD
  bool shouldRepaint(CustomPainter oldDelegate) => false;
=======
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
>>>>>>> 6c41c54 (Second Commit)
}