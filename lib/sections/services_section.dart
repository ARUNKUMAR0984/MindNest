import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'sections.dart';

class ServicesSection extends StatefulWidget {
  const ServicesSection({super.key});

  @override
  State<ServicesSection> createState() => _ServicesSectionState();
}

class _ServicesSectionState extends State<ServicesSection>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;
  int hoveredIndex = -1;

  final List<ServiceItem> _services = [
    ServiceItem(
      icon: Icons.phone_android_rounded,
      title: "Mobile App Development",
      description: "Native iOS & Android apps with cutting-edge Flutter development for seamless cross-platform experiences.",
      technologies: ["Flutter", "React Native", "iOS", "Android"],
      gradient: const LinearGradient(
        colors: [Color(0xFF4A90E2), Color(0xFF357ABD)],
      ),
    ),
    ServiceItem(
      icon: Icons.web_rounded,
      title: "Web Development",
      description: "Modern, responsive websites and progressive web applications that deliver exceptional user experiences.",
      technologies: ["React", "Vue.js", "Node.js", "Next.js"],
      gradient: const LinearGradient(
        colors: [Color(0xFF2ECC71), Color(0xFF27AE60)],
      ),
    ),
    ServiceItem(
      icon: Icons.cloud_rounded,
      title: "Cloud Solutions",
      description: "Scalable cloud infrastructure, DevOps implementation, and deployment services for enterprise-grade applications.",
      technologies: ["AWS", "Google Cloud", "Azure", "DevOps"],
      gradient: const LinearGradient(
        colors: [Color(0xFFF39C12), Color(0xFFE67E22)],
      ),
    ),
    ServiceItem(
      icon: Icons.design_services_rounded,
      title: "UI/UX Design",
      description: "User-centered design methodology that transforms complex ideas into intuitive, conversion-focused interfaces.",
      technologies: ["Figma", "Adobe XD", "Prototyping", "User Research"],
      gradient: const LinearGradient(
        colors: [Color(0xFFE74C3C), Color(0xFFC0392B)],
      ),
    ),
    ServiceItem(
      icon: Icons.shopping_cart_rounded,
      title: "E-commerce Solutions",
      description: "Complete online stores with advanced payment integration, inventory management, and analytics dashboard.",
      technologies: ["Shopify Plus", "WooCommerce", "Stripe", "Analytics"],
      gradient: const LinearGradient(
        colors: [Color(0xFF9B59B6), Color(0xFF8E44AD)],
      ),
    ),
    ServiceItem(
      icon: Icons.support_agent_rounded,
      title: "Maintenance & Support",
      description: "Comprehensive 24/7 support, regular updates, performance monitoring, and security maintenance for peace of mind.",
      technologies: ["24/7 Support", "Security Updates", "Performance", "Backup"],
      gradient: const LinearGradient(
        colors: [Color(0xFF1ABC9C), Color(0xFF16A085)],
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      _services.length,
      (index) => AnimationController(
        duration: Duration(milliseconds: 600 + (index * 100)),
        vsync: this,
      ),
    );

    _animations = _controllers.map((controller) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeOutQuart),
      );
    }).toList();

    _startAnimations();
  }

  void _startAnimations() async {
    for (int i = 0; i < _controllers.length; i++) {
      await Future.delayed(Duration(milliseconds: i * 150));
      if (mounted) {
        _controllers[i].forward();
      }
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
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
            const Color(0xFFF8FAFE),
            Colors.white,
            const Color(0xFFF0F4FF),
          ],
          stops: const [0.0, 0.5, 1.0],
        ),
      ),
      child: Column(
        children: [
          // Enhanced Section Header
          Container(
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
                          color: Color(0xFF4A90E2),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "What We Do",
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
                    "Digital Solutions That\nDrive Success",
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
                  "From concept to deployment, we deliver comprehensive digital solutions\nthat transform businesses and create lasting impact.",
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

          // Services Grid
          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = 1;
              double childAspectRatio = 1.1;
              
              if (constraints.maxWidth >= 1200) {
                crossAxisCount = 3;
                childAspectRatio = 0.85;
              } else if (constraints.maxWidth >= 768) {
                crossAxisCount = 2;
                childAspectRatio = 0.9;
              }

              if (isMobile) {
                return Column(
                  children: List.generate(_services.length, (index) {
                    return AnimatedBuilder(
                      animation: _animations[index],
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, 30 * (1 - _animations[index].value)),
                          child: Opacity(
                            opacity: _animations[index].value,
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 30),
                              child: _buildServiceCard(_services[index], index),
                            ),
                          ),
                        );
                      },
                    );
                  }),
                );
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 30,
                  childAspectRatio: childAspectRatio,
                ),
                itemCount: _services.length,
                itemBuilder: (context, index) {
                  return AnimatedBuilder(
                    animation: _animations[index],
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, 30 * (1 - _animations[index].value)),
                        child: Opacity(
                          opacity: _animations[index].value,
                          child: _buildServiceCard(_services[index], index),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),

          // Call to Action
          const SizedBox(height: 80),
          _buildCTASection(),
        ],
      ),
    );
  }

  Widget _buildServiceCard(ServiceItem service, int index) {
    final isHovered = hoveredIndex == index;

    return MouseRegion(
      onEnter: (_) => setState(() => hoveredIndex = index),
      onExit: (_) => setState(() => hoveredIndex = -1),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.identity()
          ..scale(isHovered ? 1.05 : 1.0)
          ..translate(0.0, isHovered ? -8.0 : 0.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: isHovered
                  ? const Color(0xFF4A90E2).withOpacity(0.2)
                  : Colors.black.withOpacity(0.08),
              blurRadius: isHovered ? 30 : 20,
              offset: Offset(0, isHovered ? 15 : 8),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isHovered
                  ? const Color(0xFF4A90E2).withOpacity(0.3)
                  : Colors.grey.withOpacity(0.1),
              width: 1.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon with gradient background
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: service.gradient,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: service.gradient.colors.first.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Icon(
                  service.icon,
                  size: 32,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),

              // Service title
              Text(
                service.title,
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF2C3E50),
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 12),

              // Service description
              Text(
                service.description,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: const Color(0xFF6b7280),
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 24),

              // Technology chips
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: service.technologies.map((tech) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF4A90E2).withOpacity(0.1),
                          const Color(0xFF2C3E50).withOpacity(0.05),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color(0xFF4A90E2).withOpacity(0.2),
                      ),
                    ),
                    child: Text(
                      tech,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        color: const Color(0xFF4A90E2),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                }).toList(),
              ),

              const Spacer(),

              // Learn more link
              Row(
                children: [
                  Text(
                    "Learn More",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF4A90E2),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.arrow_forward,
                    size: 16,
                    color: const Color(0xFF4A90E2),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCTASection() {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF4A90E2), Color(0xFF2C3E50)],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4A90E2).withOpacity(0.3),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            "Ready to Transform Your Business?",
            style: GoogleFonts.inter(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            "Let's discuss your project and create something amazing together",
            style: GoogleFonts.inter(
              fontSize: 16,
              color: Colors.white.withOpacity(0.9),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF2C3E50),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Start Your Project",
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.rocket_launch, size: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ServiceItem {
  final IconData icon;
  final String title;
  final String description;
  final List<String> technologies;
  final LinearGradient gradient;

  ServiceItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.technologies,
    required this.gradient,
  });
}