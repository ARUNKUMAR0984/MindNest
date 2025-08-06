import 'package:flutter/material.dart';
import 'dart:math' as math;

class ServicesSection extends StatefulWidget {
  const ServicesSection({super.key});

  @override
  State<ServicesSection> createState() => _ServicesSectionState();
}

class _ServicesSectionState extends State<ServicesSection>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _parallaxController;
  late List<Animation<double>> _cardAnimations;
  late List<Animation<Offset>> _slideAnimations;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _parallaxController = AnimationController(
      duration: const Duration(seconds: 25),
      vsync: this,
    )..repeat();

    _cardAnimations = List.generate(6, (index) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            index * 0.1,
            0.5 + (index * 0.1),
            curve: Curves.elasticOut,
          ),
        ),
      );
    });

    _slideAnimations = List.generate(6, (index) {
      return Tween<Offset>(
        begin: const Offset(0, 0.5),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            index * 0.1,
            0.5 + (index * 0.1),
            curve: Curves.easeOutBack,
          ),
        ),
      );
    });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _parallaxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final services = [
      {
        'icon': Icons.phone_android,
        'title': 'Flutter App Development',
        'subtitle': 'Cross-Platform Excellence',
        'description': 'Create stunning mobile applications with native performance for both Android and iOS. Beautiful UI, seamless UX, and scalable architecture.',
        'features': ['Native Performance', 'Cross-Platform', 'Custom UI/UX', 'Scalable Architecture'],
        'color': const Color(0xFF8B5CF6),
   
        'duration': '4-8 weeks',
        'highlights': ['Material Design 3', 'iOS Human Interface', 'State Management', 'Performance Optimization'],
        'category': 'Development',
      },
      {
        'icon': Icons.rocket_launch,
        'title': 'MVP Development',
        'subtitle': 'Launch Fast, Scale Smart',
        'description': 'Rapid prototyping and MVP development for startups. Get your innovative ideas to market quickly with core features that matter most.',
        'features': ['Quick Launch', 'Core Features', 'Market Ready', 'Investor Ready'],
        'color': const Color(0xFFF59E0B),
       
        'duration': '2-4 weeks',
        'highlights': ['Agile Development', 'User Feedback Loop', 'Iterative Design', 'Cost Effective'],
        'category': 'Strategy',
      },
      {
        'icon': Icons.cloud_sync,
        'title': 'Backend Integration',
        'subtitle': 'Seamless Data Flow',
        'description': 'Robust backend integration with Firebase, Supabase, REST APIs, and custom solutions. Real-time data sync and secure authentication.',
        'features': ['Firebase/Supabase', 'REST APIs', 'Real-time Data', 'Authentication'],
        'color': const Color(0xFF10B981),
       
        'duration': '1-3 weeks',
        'highlights': ['Real-time Sync', 'Secure APIs', 'Database Design', 'Cloud Functions'],
        'category': 'Integration',
      },
      {
        'icon': Icons.design_services,
        'title': 'UI/UX Design',
        'subtitle': 'Design That Converts',
        'description': 'Modern, intuitive interface design that prioritizes user experience. Research-driven design following the latest principles and trends.',
        'features': ['Modern Design', 'User Research', 'Responsive', 'Accessibility'],
        'color': const Color(0xFFEF4444),
        
        'duration': '2-4 weeks',
        'highlights': ['User Research', 'Wireframing', 'Prototyping', 'Design System'],
        'category': 'Design',
      },
      {
        'icon': Icons.monetization_on,
        'title': 'App Monetization',
        'subtitle': 'Revenue Optimization',
        'description': 'Implement effective monetization strategies including AdMob, in-app purchases, subscriptions, and premium features for maximum ROI.',
        'features': ['AdMob Integration', 'In-App Purchases', 'Subscriptions', 'Analytics'],
        'color': const Color(0xFF3B82F6),
       
        'duration': '1-2 weeks',
        'highlights': ['Revenue Analytics', 'User Retention', 'Payment Gateways'],
        'category': 'Monetization',
      },
      {
        'icon': Icons.support_agent,
        'title': 'Maintenance & Support',
        'subtitle': '24/7 Peace of Mind',
        'description': 'Comprehensive app maintenance, regular updates, bug fixes, performance monitoring, and feature enhancements to keep your app competitive.',
        'features': ['Bug Fixes', 'Performance Monitoring', '24/7 Support', 'Feature Updates'],
        'color': const Color(0xFF6366F1),
        
        'duration': 'Ongoing',
        'highlights': ['Proactive Monitoring', 'Priority Support', 'Regular Updates', 'Performance Reports'],
        'category': 'Support',
      },
    ];

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
                child: Column(
                  children: [
                    // Enhanced section header
                    _buildEnhancedSectionHeader(),
                    const SizedBox(height: 80),
                    
                    // Services grid
                    _buildEnhancedServicesGrid(services),
                    
                    const SizedBox(height: 80),
                    
                    // Process section
                    _buildProcessSection(),
                    
                    const SizedBox(height: 80),
                    
                    // Enhanced call to action
                    _buildEnhancedCallToAction(),
                  ],
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
            painter: ServiceBackgroundPainter(_parallaxController.value),
          ),
        );
      },
    );
  }

  Widget _buildEnhancedSectionHeader() {
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
                Icons.star,
                size: 16,
                color: const Color(0xFF8B5CF6),
              ),
              const SizedBox(width: 8),
              Text(
                'PREMIUM SERVICES',
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
              const Color(0xFF6B7280),
              const Color(0xFF8B5CF6),
            ],
          ).createShader(bounds),
          child: Text(
            'Elevate Your Business\nWith Expert Solutions',
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: -1.5,
              height: 1.1,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          constraints: const BoxConstraints(maxWidth: 700),
          child: Text(
            'From concept to deployment, I deliver end-to-end Flutter development services that transform your vision into powerful, scalable mobile applications that drive business growth.',
            style: TextStyle(
              fontSize: 18,
              color: const Color(0xFF6B7280),
              height: 1.6,
              letterSpacing: 0.3,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 32),
        
        // Trust indicators
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey[200]!),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTrustItem(Icons.verified, '1+ Years Experience'),
              Container(
                width: 1,
                height: 20,
                color: Colors.grey[300],
                margin: const EdgeInsets.symmetric(horizontal: 20),
              ),
              _buildTrustItem(Icons.star, '4.8★ Client Rating'),
              Container(
                width: 1,
                height: 20,
                color: Colors.grey[300],
                margin: const EdgeInsets.symmetric(horizontal: 20),
              ),
              _buildTrustItem(Icons.speed, '48hr Response Time'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTrustItem(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 16,
          color: const Color(0xFF10B981),
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF374151),
          ),
        ),
      ],
    );
  }

  Widget _buildEnhancedServicesGrid(List<Map<String, dynamic>> services) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Wrap(
          spacing: 24,
          runSpacing: 24,
          alignment: WrapAlignment.center,
          children: services.asMap().entries.map((entry) {
            final index = entry.key;
            final service = entry.value;
            return SlideTransition(
              position: _slideAnimations[index],
              child: Transform.scale(
                scale: _cardAnimations[index].value,
                child: EnhancedServiceCard(
                  service: service,
                  index: index,
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildProcessSection() {
    final processSteps = [
      {
        'step': '01',
        'title': 'Discovery & Planning',
        'description': 'We analyze your requirements, target audience, and business goals to create a comprehensive project roadmap.',
        'icon': Icons.search,
        'color': const Color(0xFF8B5CF6),
      },
      {
        'step': '02',
        'title': 'Design & Prototype',
        'description': 'Create wireframes, mockups, and interactive prototypes to visualize your app before development begins.',
        'icon': Icons.design_services,
        'color': const Color(0xFFF59E0B),
      },
      {
        'step': '03',
        'title': 'Development & Testing',
        'description': 'Build your app with clean, maintainable code and rigorous testing to ensure quality and performance.',
        'icon': Icons.code,
        'color': const Color(0xFF10B981),
      },
      {
        'step': '04',
        'title': 'Launch & Support',
        'description': 'Deploy your app to stores and provide ongoing maintenance, updates, and feature enhancements.',
        'icon': Icons.rocket_launch,
        'color': const Color(0xFFEF4444),
      },
    ];

    return Container(
      padding: const EdgeInsets.all(60),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white,
            const Color(0xFFF8FAFC),
          ],
        ),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 40,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.timeline,
                color: const Color(0xFF8B5CF6),
                size: 28,
              ),
              const SizedBox(width: 12),
              Text(
                'My Development Process',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF374151),
                  letterSpacing: -0.8,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'A streamlined approach that ensures quality, efficiency, and your complete satisfaction',
            style: TextStyle(
              fontSize: 16,
              color: const Color(0xFF6B7280),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),
          Wrap(
            spacing: 30,
            runSpacing: 30,
            alignment: WrapAlignment.center,
            children: processSteps.map((step) {
              return Container(
                width: 280,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: (step['color'] as Color).withOpacity(0.2)),
                  boxShadow: [
                    BoxShadow(
                      color: (step['color'] as Color).withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            step['color'] as Color,
                            (step['color'] as Color).withOpacity(0.8),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        step['icon'] as IconData,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      step['step'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: step['color'] as Color,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      step['title'] as String,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF374151),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      step['description'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        color: const Color(0xFF6B7280),
                        height: 1.5,
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
          Icon(
            Icons.rocket_launch,
            color: Colors.white,
            size: 48,
          ),
          const SizedBox(height: 20),
          Text(
            'Ready to Transform Your Ideas?',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: -0.8,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Container(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Text(
              'Let\'s discuss your project and create something extraordinary together. Get a free consultation and project estimate.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withOpacity(0.9),
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCTAButton(
                'Get Free Quote',
                Icons.calculate,
                isPrimary: false,
              ),
              const SizedBox(width: 20),
              _buildCTAButton(
                'Start Project',
                Icons.arrow_forward,
                isPrimary: true,
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '💬 Usually responds within 2 hours',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCTAButton(String label, IconData icon, {required bool isPrimary}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isPrimary ? Colors.white : Colors.transparent,
          border: isPrimary ? null : Border.all(color: Colors.white, width: 2),
          borderRadius: BorderRadius.circular(30),
          boxShadow: isPrimary ? [
            BoxShadow(
              color: Colors.white.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ] : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              // Handle button tap - open email or contact form
            },
            borderRadius: BorderRadius.circular(30),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    color: isPrimary ? const Color(0xFF8B5CF6) : Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    label,
                    style: TextStyle(
                      color: isPrimary ? const Color(0xFF8B5CF6) : Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EnhancedServiceCard extends StatefulWidget {
  final Map<String, dynamic> service;
  final int index;

  const EnhancedServiceCard({
    super.key,
    required this.service,
    required this.index,
  });

  @override
  State<EnhancedServiceCard> createState() => _EnhancedServiceCardState();
}

class _EnhancedServiceCardState extends State<EnhancedServiceCard>
    with SingleTickerProviderStateMixin {
  bool isHovered = false;
  late AnimationController _hoverController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;
  late Animation<double> _rotationAnimation;

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
    _elevationAnimation = Tween<double>(begin: 12.0, end: 30.0).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeOut),
    );
    _rotationAnimation = Tween<double>(begin: 0.0, end: 0.02).animate(
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
            child: Transform.rotate(
              angle: _rotationAnimation.value,
              child: Container(
                width: 380,
                height: 480,
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
                    color: widget.service['color'].withOpacity(0.2),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: widget.service['color'].withOpacity(0.15),
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
                child: Stack(
                  children: [
                    // Background gradient overlay
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      height: 120,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              widget.service['color'].withOpacity(0.1),
                              widget.service['color'].withOpacity(0.05),
                            ],
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                        ),
                      ),
                    ),
                    
                    // Category badge
                    Positioned(
                      top: 20,
                      right: 20,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: widget.service['color'].withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: widget.service['color'].withOpacity(0.3),
                          ),
                        ),
                        child: Text(
                          widget.service['category'],
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: widget.service['color'],
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Icon with enhanced styling
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  widget.service['color'],
                                  widget.service['color'].withOpacity(0.8),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: widget.service['color'].withOpacity(0.3),
                                  blurRadius: 15,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Icon(
                              widget.service['icon'],
                              color: Colors.white,
                              size: 36,
                            ),
                          ),
                          
                          const SizedBox(height: 24),
                          
                          // Title and subtitle
                          Text(
                            widget.service['title'],
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              color: const Color(0xFF374151),
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.service['subtitle'],
                            style: TextStyle(
                              fontSize: 14,
                              color: widget.service['color'],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          
                          const SizedBox(height: 16),
                          
                          // Description
                          Text(
                            widget.service['description'],
                            style: TextStyle(
                              fontSize: 14,
                              color: const Color(0xFF6B7280),
                              height: 1.5,
                              letterSpacing: 0.1,
                            ),
                          ),
                          
                          const SizedBox(height: 20),
                          
                          // Key highlights
                          Text(
                            'Key Highlights',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF374151),
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: widget.service['highlights'].map<Widget>((highlight) {
                              return Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: widget.service['color'].withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: widget.service['color'].withOpacity(0.2),
                                  ),
                                ),
                               child: Text(
                                  highlight,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: widget.service['color'],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          
                          const Spacer(),
                          
                          // Pricing and duration
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                             
                                  
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'Timeline',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: const Color(0xFF6B7280),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    widget.service['duration'],
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF374151),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          
                          const SizedBox(height: 20),
                          
                          // Action button
                          SizedBox(
                            width: double.infinity,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              decoration: BoxDecoration(
                                gradient: isHovered
                                    ? LinearGradient(
                                        colors: [
                                          widget.service['color'],
                                          widget.service['color'].withOpacity(0.8),
                                        ],
                                      )
                                    : LinearGradient(
                                        colors: [
                                          widget.service['color'].withOpacity(0.1),
                                          widget.service['color'].withOpacity(0.05),
                                        ],
                                      ),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: widget.service['color'].withOpacity(isHovered ? 0.8 : 0.3),
                                  width: 1.5,
                                ),
                                boxShadow: isHovered
                                    ? [
                                        BoxShadow(
                                          color: widget.service['color'].withOpacity(0.3),
                                          blurRadius: 15,
                                          offset: const Offset(0, 8),
                                        ),
                                      ]
                                    : null,
                              ),
                              
                            ),
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
    );
  }
}

class ServiceBackgroundPainter extends CustomPainter {
  final double animation;

  ServiceBackgroundPainter(this.animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill;

    // Create animated gradient circles
    final circles = [
      {
        'x': size.width * 0.1 + math.sin(animation * 2 * math.pi) * 50,
        'y': size.height * 0.2 + math.cos(animation * 2 * math.pi) * 30,
        'radius': 120.0,
        'color': const Color(0xFF8B5CF6).withOpacity(0.03),
      },
      {
        'x': size.width * 0.8 + math.cos(animation * 2 * math.pi + 1) * 60,
        'y': size.height * 0.6 + math.sin(animation * 2 * math.pi + 1) * 40,
        'radius': 180.0,
        'color': const Color(0xFF10B981).withOpacity(0.02),
      },
      {
        'x': size.width * 0.5 + math.sin(animation * 2 * math.pi + 2) * 40,
        'y': size.height * 0.8 + math.cos(animation * 2 * math.pi + 2) * 50,
        'radius': 150.0,
        'color': const Color(0xFFF59E0B).withOpacity(0.025),
      },
      {
        'x': size.width * 0.2 + math.cos(animation * 2 * math.pi + 3) * 70,
        'y': size.height * 0.4 + math.sin(animation * 2 * math.pi + 3) * 35,
        'radius': 100.0,
        'color': const Color(0xFFEF4444).withOpacity(0.02),
      },
    ];

    for (final circle in circles) {
      paint.color = circle['color'] as Color;
      canvas.drawCircle(
        Offset(circle['x'] as double, circle['y'] as double),
        circle['radius'] as double,
        paint,
      );
    }

    // Add subtle geometric patterns
    paint.color = const Color(0xFF8B5CF6).withOpacity(0.01);
    paint.strokeWidth = 1;
    paint.style = PaintingStyle.stroke;

    final path = Path();
    for (int i = 0; i < 5; i++) {
      final x = size.width * (0.2 + i * 0.2) + math.sin(animation * 2 * math.pi + i) * 20;
      final y = size.height * 0.1 + math.cos(animation * 2 * math.pi + i) * 15;
      
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(ServiceBackgroundPainter oldDelegate) {
    return oldDelegate.animation != animation;
  }
}