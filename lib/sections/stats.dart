import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StatsSection extends StatefulWidget {
  const StatsSection({super.key});

  @override
  State<StatsSection> createState() => _StatsSectionState();
}

class _StatsSectionState extends State<StatsSection>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;
  late List<Animation<double>> _scaleAnimations;
  
  final List<StatItem> _stats = [
    StatItem(
      number: "10+",
      label: "Projects Delivered",
      icon: Icons.rocket_launch_rounded,
      description: "Successfully launched",
    ),
    StatItem(
      number: "96%",
      label: "Client Satisfaction",
      icon: Icons.star_rounded,
      description: "Average rating",
    ),
    StatItem(
      number: "5+",
      label: "Happy Clients",
      icon: Icons.people_rounded,
      description: "Trusted partners",
    ),
    StatItem(
      number: "24/7",
      label: "Support Available",
      icon: Icons.support_agent_rounded,
      description: "Round the clock",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      _stats.length,
      (index) => AnimationController(
        duration: Duration(milliseconds: 800 + (index * 200)),
        vsync: this,
      ),
    );
    
    _animations = _controllers.map((controller) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeOutBack),
      );
    }).toList();
    
    _scaleAnimations = _controllers.map((controller) {
      return Tween<double>(begin: 0.8, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.elasticOut),
      );
    }).toList();
    
    // Start animations with stagger effect
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
        vertical: isMobile ? 80 : 100,
        horizontal: isMobile ? 20 : 50,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            const Color(0xFFF8FAFE),
            Colors.white,
          ],
          stops: const [0.0, 0.5, 1.0],
        ),
      ),
      child: Column(
        children: [
          // Section header
          Container(
            margin: const EdgeInsets.only(bottom: 60),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF4A90E2).withOpacity(0.1),
                        const Color(0xFF2C3E50).withOpacity(0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFF4A90E2).withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    "Our Impact",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF4A90E2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Color(0xFF4A90E2), Color(0xFF2C3E50)],
                  ).createShader(bounds),
                  child: Text(
                    "Numbers That Tell Our Story",
                    style: GoogleFonts.inter(
                      fontSize: isMobile ? 28 : 36,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      height: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          
          // Stats grid
          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = 1;
              if (constraints.maxWidth >= 1024) {
                crossAxisCount = 4;
              } else if (constraints.maxWidth >= 768) {
                crossAxisCount = 2;
              }
              
              if (isMobile) {
                return Column(
                  children: List.generate(_stats.length, (index) {
                    return AnimatedBuilder(
                      animation: _animations[index],
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, 50 * (1 - _animations[index].value)),
                          child: Opacity(
                            opacity: _animations[index].value,
                            child: Transform.scale(
                              scale: _scaleAnimations[index].value,
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 30),
                                child: _buildStatCard(_stats[index], index),
                              ),
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
                  childAspectRatio: isTablet ? 1.1 : 1.2,
                ),
                itemCount: _stats.length,
                itemBuilder: (context, index) {
                  return AnimatedBuilder(
                    animation: _animations[index],
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, 50 * (1 - _animations[index].value)),
                        child: Opacity(
                          opacity: _animations[index].value,
                          child: Transform.scale(
                            scale: _scaleAnimations[index].value,
                            child: _buildStatCard(_stats[index], index),
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(StatItem stat, int index) {
    return MouseRegion(
      onEnter: (_) => _onHover(index, true),
      onExit: (_) => _onHover(index, false),
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              color: const Color(0xFF4A90E2).withOpacity(0.1),
              blurRadius: 40,
              offset: const Offset(0, 16),
            ),
          ],
          border: Border.all(
            color: const Color(0xFF4A90E2).withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon with gradient background
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF4A90E2), Color(0xFF2C3E50)],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF4A90E2).withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Icon(
                stat.icon,
                color: Colors.white,
                size: 32,
              ),
            ),
            const SizedBox(height: 24),
            
            // Number with animated counting effect
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Color(0xFF4A90E2), Color(0xFF2C3E50)],
              ).createShader(bounds),
              child: Text(
                stat.number,
                style: GoogleFonts.inter(
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  height: 1.0,
                ),
              ),
            ),
            const SizedBox(height: 8),
            
            // Main label
            Text(
              stat.label,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF2C3E50),
                height: 1.3,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            
            // Description
            Text(
              stat.description,
              style: GoogleFonts.inter(
                fontSize: 13,
                color: const Color(0xFF6b7280),
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _onHover(int index, bool isHovered) {
    // Add subtle hover animation if needed
    if (isHovered) {
      _controllers[index].forward();
    }
  }
}

class StatItem {
  final String number;
  final String label;
  final IconData icon;
  final String description;

  StatItem({
    required this.number,
    required this.label,
    required this.icon,
    required this.description,
  });
}