import 'package:flutter/material.dart';

import 'sections.dart';

class PortfolioSection extends StatefulWidget {
  const PortfolioSection({super.key});

  @override
  State<PortfolioSection> createState() => _PortfolioSectionState();
}

class _PortfolioSectionState extends State<PortfolioSection> {
  int hoveredIndex = -1;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final isTablet = MediaQuery.of(context).size.width < 1024;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFF8FAFE),
            Color(0xFFFFFFFF),
            Color(0xFFF0F4FF),
          ],
        ),
      ),
      child: Column(
        children: [
          const SectionHeader(
            title: "Our Portfolio",
            subtitle: "Innovative solutions that drive business growth and digital transformation",
          ),
          const SizedBox(height: 80),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: isMobile ? 1 : (isTablet ? 2 : 3),
            crossAxisSpacing: 40,
            mainAxisSpacing: 40,
            childAspectRatio: isMobile ? 1.1 : (isTablet ? 0.85 : 0.9),
            children: List.generate(_portfolioItems.length, (index) {
              final item = _portfolioItems[index];
              return MouseRegion(
                onEnter: (_) => setState(() => hoveredIndex = index),
                onExit: (_) => setState(() => hoveredIndex = -1),
                child: _buildPortfolioItem(item, index),
              );
            }),
          ),
          const SizedBox(height: 60),
          _buildViewAllButton(),
        ],
      ),
    );
  }

  Widget _buildPortfolioItem(PortfolioItem item, int index) {
    final isHovered = hoveredIndex == index;
    
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      transform: Matrix4.identity()..scale(isHovered ? 1.05 : 1.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: isHovered 
                ? const Color(0xFF4A90E2).withOpacity(0.3)
                : Colors.black.withOpacity(0.08),
            blurRadius: isHovered ? 30 : 20,
            offset: Offset(0, isHovered ? 15 : 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                Colors.white,
                const Color(0xFFF8FAFE),
              ],
            ),
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
              // Project Image/Icon Area
              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFF4A90E2), // MindNest blue
                        const Color(0xFF2C3E50), // MindNest dark
                      ],
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Background pattern
                      Positioned.fill(
                        child: CustomPaint(
                          painter: GridPatternPainter(),
                        ),
                      ),
                      // Main icon
                      Center(
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Icon(
                            item.icon,
                            size: 48,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      // Category badge
                      Positioned(
                        top: 16,
                        right: 16,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                            ),
                          ),
                          child: Text(
                            item.category,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Project Details
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2C3E50),
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item.description,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                          height: 1.4,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      // Tech stack chips
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: item.techStack.map((tech) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF4A90E2), Color(0xFF357ABD)],
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            tech,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildViewAllButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4A90E2).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF4A90E2), Color(0xFF2C3E50)],
            ),
            borderRadius: BorderRadius.circular(50),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'View All Projects',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 8),
              Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PortfolioItem {
  final String title;
  final String description;
  final String category;
  final IconData icon;
  final List<String> techStack;

  PortfolioItem({
    required this.title,
    required this.description,
    required this.category,
    required this.icon,
    required this.techStack,
  });
}

final List<PortfolioItem> _portfolioItems = [
  PortfolioItem(
    title: 'FinanceFlow Pro',
    description: 'Comprehensive financial management platform with AI-driven insights and real-time analytics.',
    category: 'FinTech',
    icon: Icons.account_balance,
    techStack: ['Flutter', 'Firebase', 'AI/ML'],
  ),
  PortfolioItem(
    title: 'HealthCare Connect',
    description: 'Telemedicine platform connecting patients with healthcare providers seamlessly.',
    category: 'Healthcare',
    icon: Icons.local_hospital,
    techStack: ['React', 'Node.js', 'WebRTC'],
  ),
  PortfolioItem(
    title: 'EduTech Learn',
    description: 'Interactive learning management system with personalized learning paths.',
    category: 'Education',
    icon: Icons.school,
    techStack: ['Vue.js', 'Python', 'AWS'],
  ),
  PortfolioItem(
    title: 'SmartRetail Hub',
    description: 'Omnichannel e-commerce solution with inventory management and analytics.',
    category: 'E-commerce',
    icon: Icons.shopping_cart,
    techStack: ['React Native', 'Shopify', 'GraphQL'],
  ),
  PortfolioItem(
    title: 'PropertyVision',
    description: 'Real estate platform with virtual tours and market analytics.',
    category: 'Real Estate',
    icon: Icons.home,
    techStack: ['Next.js', 'Three.js', 'MongoDB'],
  ),
  PortfolioItem(
    title: 'LogisticsPro',
    description: 'Supply chain management system with real-time tracking and optimization.',
    category: 'Logistics',
    icon: Icons.local_shipping,
    techStack: ['Flutter', 'Google Maps', 'IoT'],
  ),
];

class GridPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..strokeWidth = 1;

    const double spacing = 20;
    
    // Draw vertical lines
    for (double x = 0; x <= size.width; x += spacing) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint,
      );
    }
    
    // Draw horizontal lines
    for (double y = 0; y <= size.height; y += spacing) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}