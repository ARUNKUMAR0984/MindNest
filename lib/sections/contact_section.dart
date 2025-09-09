import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;
import 'sections.dart';
=======
import 'package:url_launcher/url_launcher.dart';
>>>>>>> 6c41c54 (Second Commit)

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection>
    with TickerProviderStateMixin {
<<<<<<< HEAD
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  late AnimationController _mainController;
  late AnimationController _backgroundController;
  late AnimationController _floatingController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _scaleAnimation;
  late List<AnimationController> _itemControllers;
  late List<Animation<double>> _itemAnimations;

  bool isFormHovered = false;
  int hoveredContactIndex = -1;
  int hoveredSocialIndex = -1;

  final List<ContactInfo> contactItems = [
    ContactInfo(
      icon: Icons.email_rounded,
      title: "Email",
      value: "hello@mindnest.dev",
      subtitle: "Drop us a line anytime",
      color: Color(0xFF10b981),
    ),
    ContactInfo(
      icon: Icons.phone_rounded,
      title: "Phone",
      value: "+91 98765 43210",
      subtitle: "Mon to Fri 9am to 6pm",
      color: Color(0xFF667eea),
    ),
    ContactInfo(
      icon: Icons.location_on_rounded,
      title: "Location",
      value: "Coimbatore, Tamil Nadu",
      subtitle: "Come say hello",
      color: Color(0xFF8b5cf6),
    ),
  ];

  final List<SocialInfo> socialItems = [
    SocialInfo(icon: Icons.facebook_rounded, label: "Facebook", color: Color(0xFF1877f2)),
    SocialInfo(icon: Icons.alternate_email_rounded, label: "Twitter", color: Color(0xFF1da1f2)),
    SocialInfo(icon: Icons.work_outline_rounded, label: "LinkedIn", color: Color(0xFF0077b5)),
    SocialInfo(icon: Icons.code_rounded, label: "GitHub", color: Color(0xFF333)),
  ];
=======
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
>>>>>>> 6c41c54 (Second Commit)

  @override
  void initState() {
    super.initState();
<<<<<<< HEAD
    
    _mainController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    
    _backgroundController = AnimationController(
      duration: const Duration(seconds: 25),
      vsync: this,
    )..repeat();

    _floatingController = AnimationController(
      duration: const Duration(seconds: 4),
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

    _itemControllers = List.generate(
      contactItems.length + 1, // +1 for form
      (index) => AnimationController(
        duration: Duration(milliseconds: 600 + (index * 100)),
        vsync: this,
      ),
    );

    _itemAnimations = _itemControllers.map((controller) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeOutBack),
      );
    }).toList();

    _startAnimations();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (mounted) {
      _mainController.forward();
      
      for (int i = 0; i < _itemControllers.length; i++) {
        await Future.delayed(Duration(milliseconds: 150 + (i * 100)));
        if (mounted) {
          _itemControllers[i].forward();
        }
      }
    }
=======
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );

    _fadeController.forward();
>>>>>>> 6c41c54 (Second Commit)
  }

  @override
  void dispose() {
<<<<<<< HEAD
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    _mainController.dispose();
    _backgroundController.dispose();
    _floatingController.dispose();
    for (var controller in _itemControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Color(0xFF10b981),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_rounded, color: Colors.white, size: 16),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Message sent successfully! We\'ll get back to you soon.',
                  style: GoogleFonts.inter(fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.all(20),
        ),
      );
      
      _nameController.clear();
      _emailController.clear();
      _subjectController.clear();
      _messageController.clear();
    }
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
=======
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
>>>>>>> 6c41c54 (Second Commit)
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
<<<<<<< HEAD
            Color(0xFFF8FAFC),
            Color(0xFFF0F4FF),
            Colors.white,
          ],
          stops: [0.0, 0.5, 1.0],
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
                  painter: ContactPatternPainter(_backgroundController.value),
                );
              },
            ),
          ),

          // Floating elements
          ...List.generate(8, (index) {
            return AnimatedBuilder(
              animation: _floatingController,
              builder: (context, child) {
                final offset = 15 * math.sin(_floatingController.value * 2 * math.pi + index * 0.8);
                return Positioned(
                  left: (screenWidth / 8) * index,
                  top: 30 + offset,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          contactItems[index % contactItems.length].color.withOpacity(0.1),
                          contactItems[index % contactItems.length].color.withOpacity(0.05),
                        ],
                      ),
                      border: Border.all(
                        color: contactItems[index % contactItems.length].color.withOpacity(0.2),
                      ),
                    ),
                  ),
                );
              },
            );
          }),

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
                                    "We're Here to Help",
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
                                isMobile 
                                    ? "Let's Start a\nConversation"
                                    : "Let's Start a Conversation\nAbout Your Next Project",
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
                              "Have a project in mind? We'd love to hear about it.\nReach out and let's turn your ideas into reality.",
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

              // Contact Content
              if (isMobile)
                Column(
                  children: [
                    _buildContactInfo(),
                    const SizedBox(height: 50),
                    _buildContactForm(),
                  ],
                )
              else
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: _buildContactInfo(),
                    ),
                    const SizedBox(width: 80),
                    Expanded(
                      flex: 3,
                      child: _buildContactForm(),
                    ),
                  ],
                ),
            ],
          ),
        ],
=======
            Colors.grey[50]!,
            Colors.white,
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                children: [
                  // Section Header
                  _buildSectionHeader(),
                  
                  const SizedBox(height: 60),
                  
                  // Contact Cards Grid
                  _buildContactGrid(),
                  
                  const SizedBox(height: 50),
                  
                  // Contact Form Card
                  _buildContactForm(),
                  
                  const SizedBox(height: 40),
                  
                  // Social Links
                  _buildSocialLinks(),
                ],
              ),
            ),
          ),
        ),
>>>>>>> 6c41c54 (Second Commit)
      ),
    );
  }

<<<<<<< HEAD
  Widget _buildContactInfo() {
    return AnimatedBuilder(
      animation: _itemAnimations[0],
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(-30 * (1 - _itemAnimations[0].value), 0),
          child: Opacity(
            opacity: _itemAnimations[0].value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Get in touch",
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF2C3E50),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "We're here to help and answer any question you might have.",
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: const Color(0xFF6b7280),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 40),

                // Contact Items
                Column(
                  children: List.generate(contactItems.length, (index) {
                    return AnimatedBuilder(
                      animation: _itemAnimations[index + 1],
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(-20 * (1 - _itemAnimations[index + 1].value), 0),
                          child: Opacity(
                            opacity: _itemAnimations[index + 1].value,
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 24),
                              child: _buildContactItem(contactItems[index], index),
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),

                const SizedBox(height: 30),

                // Social Links
                Text(
                  "Follow us",
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF2C3E50),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
  children: List.generate(socialItems.length, (index) {
    return AnimatedBuilder(
      animation: _itemAnimations.last, // ✅ use the last animation safely
      builder: (context, child) {
        return Transform.scale(
          scale: _itemAnimations.last.value,
          child: Container(
            margin: const EdgeInsets.only(right: 16),
            child: _buildSocialButton(socialItems[index], index),
          ),
        );
      },
    );
  }),
),

              ],
            ),
          ),
=======
  Widget _buildSectionHeader() {
    return Column(
      children: [
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [
              const Color(0xFF374151),
              const Color(0xFF6B7280),
            ],
          ).createShader(bounds),
          child: Text(
            "Get In Touch",
            style: TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: -1,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "Let's discuss your next project or collaboration opportunity",
          style: TextStyle(
            fontSize: 18,
            color: const Color(0xFF6B7280),
            height: 1.5,
            letterSpacing: 0.3,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildContactGrid() {
    final contactMethods = [
      {
        'icon': Icons.email_outlined,
        'title': 'Email',
        'subtitle': 'arunkumars97462@gmail.com',
        'description': 'Send me an email and I\'ll respond within 24 hours',
        'url': 'mailto:arunkumars97462@gmail.com',
        'color': const Color(0xFF3B82F6),
      },
      {
        'icon': Icons.business_outlined,
        'title': 'LinkedIn',
        'subtitle': 'Professional Network',
        'description': 'Connect with me for professional opportunities',
        'url': 'https://linkedin.com/in/arunkumar-s-8388a3252',
        'color': const Color(0xFF0077B5),
      },
      {
        'icon': Icons.code_outlined,
        'title': 'GitHub',
        'subtitle': 'View My Work',
        'description': 'Check out my latest projects and contributions',
        'url': 'https://github.com/ARUNKUMAR0984',
        'color': const Color(0xFF24292E),
      },
      {
        'icon': Icons.phone_android_outlined,
        'title': 'Play Store',
        'subtitle': 'My Published Apps',
        'description': 'Explore apps I\'ve built and published',
        'url': 'https://play.google.com/store/apps/developer?id=AK+MindNest+Studio',
        'color': const Color(0xFF01875F),
      },
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > 768;
        return Wrap(
          spacing: 20,
          runSpacing: 20,
          alignment: WrapAlignment.center,
          children: contactMethods.map((method) => 
            _buildContactCard(method, isDesktop ? 280 : double.infinity)
          ).toList(),
>>>>>>> 6c41c54 (Second Commit)
        );
      },
    );
  }

<<<<<<< HEAD
  Widget _buildContactItem(ContactInfo item, int index) {
    final isHovered = hoveredContactIndex == index;

    return MouseRegion(
      onEnter: (_) => setState(() => hoveredContactIndex = index),
      onExit: (_) => setState(() => hoveredContactIndex = -1),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: isHovered
              ? LinearGradient(
                  colors: [
                    item.color.withOpacity(0.05),
                    item.color.withOpacity(0.02),
                  ],
                )
              : const LinearGradient(
                  colors: [Colors.transparent, Colors.transparent],
                ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isHovered 
                ? item.color.withOpacity(0.3)
                : Colors.transparent,
          ),
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [item.color, item.color.withOpacity(0.8)],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: item.color.withOpacity(isHovered ? 0.3 : 0.2),
                    blurRadius: isHovered ? 20 : 15,
                    offset: Offset(0, isHovered ? 8 : 5),
                  ),
                ],
              ),
              child: Icon(
                item.icon,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF2C3E50),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.value,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: item.color,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.subtitle,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: const Color(0xFF6b7280),
=======
  Widget _buildContactCard(Map<String, dynamic> method, double width) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: width == double.infinity ? null : width,
        constraints: width == double.infinity 
            ? const BoxConstraints(maxWidth: 400) 
            : null,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => _launchUrl(method['url']),
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey[200]!),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: method['color'].withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      method['icon'],
                      color: method['color'],
                      size: 28,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    method['title'],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF374151),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    method['subtitle'],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: method['color'],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    method['description'],
                    style: TextStyle(
                      fontSize: 14,
                      color: const Color(0xFF6B7280),
                      height: 1.5,
>>>>>>> 6c41c54 (Second Commit)
                    ),
                  ),
                ],
              ),
            ),
<<<<<<< HEAD
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton(SocialInfo item, int index) {
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
            gradient: isHovered
                ? LinearGradient(
                    colors: [item.color, item.color.withOpacity(0.8)],
                  )
                : LinearGradient(
                    colors: [
                      item.color.withOpacity(0.1),
                      item.color.withOpacity(0.05),
                    ],
                  ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: item.color.withOpacity(isHovered ? 1.0 : 0.3),
            ),
            boxShadow: [
              if (isHovered)
                BoxShadow(
                  color: item.color.withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
            ],
          ),
          child: Icon(
            item.icon,
            color: isHovered ? Colors.white : item.color,
            size: 20,
=======
>>>>>>> 6c41c54 (Second Commit)
          ),
        ),
      ),
    );
  }

  Widget _buildContactForm() {
<<<<<<< HEAD
    final formIndex = contactItems.length;

    return MouseRegion(
      onEnter: (_) => setState(() => isFormHovered = true),
      onExit: (_) => setState(() => isFormHovered = false),
      child: AnimatedBuilder(
        animation: _itemAnimations[formIndex],
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(30 * (1 - _itemAnimations[formIndex].value), 0),
            child: Opacity(
              opacity: _itemAnimations[formIndex].value,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
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
                    color: isFormHovered 
                        ? const Color(0xFF667eea).withOpacity(0.3)
                        : const Color(0xFFE2E8F0),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: isFormHovered
                          ? const Color(0xFF667eea).withOpacity(0.1)
                          : Colors.black.withOpacity(0.05),
                      blurRadius: isFormHovered ? 30 : 20,
                      offset: Offset(0, isFormHovered ? 15 : 10),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF667eea), Color(0xFF8b5cf6)],
                              ),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF667eea).withOpacity(0.3),
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.message_rounded,
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
                                  "Send us a message",
                                  style: GoogleFonts.inter(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w800,
                                    color: const Color(0xFF2C3E50),
                                  ),
                                ),
                                Text(
                                  "We'll respond within 24 hours",
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: const Color(0xFF6b7280),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 40),

                      Row(
                        children: [
                          Expanded(
                            child: _buildFormField(
                              "Name",
                              "John Doe",
                              _nameController,
                              Icons.person_outline_rounded,
                              validator: (value) => value?.isEmpty ?? true ? 'Name is required' : null,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: _buildFormField(
                              "Email",
                              "john@example.com",
                              _emailController,
                              Icons.email_outlined,
                              validator: (value) {
                                if (value?.isEmpty ?? true) return 'Email is required';
                                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)) {
                                  return 'Enter a valid email';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),

                      _buildFormField(
                        "Subject",
                        "Project Discussion",
                        _subjectController,
                        Icons.subject_rounded,
                        validator: (value) => value?.isEmpty ?? true ? 'Subject is required' : null,
                      ),

                      _buildFormField(
                        "Message",
                        "Tell us about your project...",
                        _messageController,
                        Icons.chat_bubble_outline_rounded,
                        maxLines: 5,
                        validator: (value) => value?.isEmpty ?? true ? 'Message is required' : null,
                      ),

                      const SizedBox(height: 40),

                      Container(
                        width: double.infinity,
                        height: 56,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF667eea), Color(0xFF8b5cf6)],
                          ),
                          borderRadius: BorderRadius.circular(28),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF667eea).withOpacity(0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: _handleSubmit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.white,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.send_rounded, size: 20),
                              const SizedBox(width: 12),
                              Text(
                                "Send Message",
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      Center(
                        child: Text(
                          "We respect your privacy and never share your information",
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: const Color(0xFF6b7280),
                          ),
                          textAlign: TextAlign.center,
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
    );
  }

  Widget _buildFormField(
    String label,
    String hint,
    TextEditingController controller,
    IconData icon, {
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF374151),
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            maxLines: maxLines,
            validator: validator,
            style: GoogleFonts.inter(
              fontSize: 15,
              color: const Color(0xFF374151),
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 15,
              ),
              prefixIcon: Container(
                margin: const EdgeInsets.all(12),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF667eea).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: const Color(0xFF667eea),
                  size: 18,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Color(0xFF667eea), width: 2),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Color(0xFFEF4444), width: 2),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Color(0xFFEF4444), width: 2),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: maxLines > 1 ? 16 : 16,
              ),
              filled: true,
              fillColor: const Color(0xFFF9FAFB),
            ),
=======
    return Container(
      constraints: const BoxConstraints(maxWidth: 600),
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
        border: Border.all(color: Colors.grey[100]!),
      ),
      child: Column(
        children: [
          Icon(
            Icons.mail_outline,
            size: 48,
            color: const Color(0xFF6B7280),
          ),
          const SizedBox(height: 20),
          Text(
            "Quick Contact",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF374151),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Ready to start your project? Let's discuss how I can help bring your ideas to life.",
            style: TextStyle(
              fontSize: 16,
              color: const Color(0xFF6B7280),
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          _buildPrimaryButton(
            label: "Send the Email",
            icon: Icons.send,
            onTap: () => _launchUrl('mailto:arunkumars97462@gmail.com?subject=Project Inquiry&body=Hi Arunkumar,%0D%0A%0D%0AI would like to discuss a project with you.%0D%0A%0D%0AProject Details:%0D%0A- %0D%0A- %0D%0A- %0D%0A%0D%0ABest regards,'),
>>>>>>> 6c41c54 (Second Commit)
          ),
        ],
      ),
    );
  }
<<<<<<< HEAD
}

class ContactInfo {
  final IconData icon;
  final String title;
  final String value;
  final String subtitle;
  final Color color;

  ContactInfo({
    required this.icon,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.color,
  });
}

class SocialInfo {
  final IconData icon;
  final String label;
  final Color color;

  SocialInfo({
    required this.icon,
    required this.label,
    required this.color,
  });
}

class ContactPatternPainter extends CustomPainter {
  final double animationValue;

  ContactPatternPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF667eea).withOpacity(0.05)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Draw floating circles with wave effect
    for (int i = 0; i < 12; i++) {
      final x = (size.width / 12) * i +
          (30 * math.sin(animationValue * 2 * math.pi + i * 0.8));
      final y = (size.height / 2) +
          (25 * math.cos(animationValue * 2 * math.pi + i * 1.2));

      canvas.drawCircle(Offset(x, y), 18, paint);
    }

    // Diagonal line grid
    paint.strokeWidth = 0.4;
    for (int i = 0; i < 6; i++) {
      final startX = i * (size.width / 6);
      final startY = 40 + (15 * math.sin(animationValue * math.pi + i));
      final endX = startX + 120;
      final endY = startY + 60;

      canvas.drawLine(
        Offset(startX, startY),
        Offset(endX, endY),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
=======



  Widget _buildSocialLinks() {
    final socialLinks = [
      {
        'icon': Icons.business,
        'url': 'https://linkedin.com/in/arunkumar-s-8388a3252',
        'label': 'LinkedIn',
      },
      {
        'icon': Icons.code,
        'url': 'https://github.com/ARUNKUMAR0984',
        'label': 'GitHub',
      },
      {
        'icon': Icons.phone_android,
        'url': 'https://play.google.com/store/apps/developer?id=AK+MindNest+Studio',
        'label': 'Play Store',
      },
    ];

    return Column(
      children: [
        Text(
          "Follow My Work",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF374151),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: socialLinks.map((link) => 
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: _buildSocialButton(link),
            )
          ).toList(),
        ),
      ],
    );
  }

  Widget _buildSocialButton(Map<String, dynamic> link) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _launchUrl(link['url']),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[200]!),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              link['icon'],
              color: const Color(0xFF6B7280),
              size: 24,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPrimaryButton({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF6B7280),
              const Color(0xFF4B5563),
            ],
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6B7280).withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(30),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    label,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
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

  Future<void> _launchUrl(String url) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }
}
>>>>>>> 6c41c54 (Second Commit)
