import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final bool isMobile;
  final VoidCallback onAboutPressed;
  final VoidCallback onServicesPressed;
  final VoidCallback onPortfolioPressed;
  final VoidCallback onPricingPressed;
  final VoidCallback onContactPressed;

  const CustomAppBar({
    super.key,
    required this.isMobile,
    required this.onAboutPressed,
    required this.onServicesPressed,
    required this.onPortfolioPressed,
    required this.onPricingPressed,
    required this.onContactPressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  String hoveredButton = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        toolbarHeight: kToolbarHeight + 10,
        leading: widget.isMobile 
            ? Builder(
                builder: (context) => IconButton(
                  icon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF4A90E2), Color(0xFF2C3E50)],
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              )
            : null,
        title: Row(
          children: [
            // Logo container with gradient background
            Container(
              padding: const EdgeInsets.all(12),
             
              child: Image.asset(
                'assets/MindNest.png',
                height: 100,
                width: 100,
                fit: BoxFit.contain,
          // This will tint the logo white if it's an icon
              ),
            ),
    
            // Brand text with gradient
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
          color: Color(0xff434343), // Second color
          letterSpacing: -0.5,
        ),
      ),
    ],
  ),
),

          ],
        ),
        actions: widget.isMobile
            ? null
            : [
                _buildNavButton("About", widget.onAboutPressed),
                _buildNavButton("Services", widget.onServicesPressed),
                _buildNavButton("Portfolio", widget.onPortfolioPressed),
                _buildNavButton("Pricing", widget.onPricingPressed),
                const SizedBox(width: 16),
                
                // Enhanced CTA Button
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF4A90E2).withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: widget.onContactPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF4A90E2), Color(0xFF2C3E50)],
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Get Started",
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
              ],
      ),
    );
  }

  Widget _buildNavButton(String text, VoidCallback onPressed) {
    final isHovered = hoveredButton == text;
    
    return MouseRegion(
      onEnter: (_) => setState(() => hoveredButton = text),
      onExit: (_) => setState(() => hoveredButton = ''),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isHovered 
              ? const Color(0xFF4A90E2).withOpacity(0.1)
              : Colors.transparent,
        ),
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Text(
            text,
            style: GoogleFonts.inter(
              color: isHovered 
                  ? const Color(0xFF4A90E2)
                  : const Color(0xFF4a5568),
              fontWeight: isHovered ? FontWeight.w600 : FontWeight.w500,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  final VoidCallback onAboutPressed;
  final VoidCallback onServicesPressed;
  final VoidCallback onPortfolioPressed;
  final VoidCallback onPricingPressed;
  final VoidCallback onContactPressed;

  const CustomDrawer({
    super.key,
    required this.onAboutPressed,
    required this.onServicesPressed,
    required this.onPortfolioPressed,
    required this.onPricingPressed,
    required this.onContactPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          // Enhanced DrawerHeader with MindNest branding
          Container(
            height: 200,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF4A90E2),
                  Color(0xFF357ABD),
                  Color(0xFF2C3E50),
                ],
                stops: [0.0, 0.6, 1.0],
              ),
            ),
            child: Stack(
              children: [
                // Background pattern
                Positioned.fill(
                  child: CustomPaint(
                    painter: DrawerPatternPainter(),
                  ),
                ),
                
                // Content
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Logo
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Image.asset(
                          'assets/MindNest.png',
                          height: 32,
                          width: 32,
                          fit: BoxFit.contain,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Brand name
                      Text(
                        "MindNest",
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      
                      // Tagline
                      Text(
                        "Digital Solutions Agency",
                        style: GoogleFonts.inter(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Navigation items
          _buildDrawerItem(
            Icons.info_outline_rounded,
            "About Us",
            "Learn about our story",
            onAboutPressed,
          ),
          _buildDrawerItem(
            Icons.work_outline_rounded,
            "Services",
            "What we offer",
            onServicesPressed,
          ),
          _buildDrawerItem(
            Icons.folder_open_rounded,
            "Portfolio",
            "Our recent work",
            onPortfolioPressed,
          ),
          _buildDrawerItem(
            Icons.price_check_rounded,
            "Pricing",
            "Transparent pricing",
            onPricingPressed,
          ),
          
          const SizedBox(height: 20),
          
          // Divider
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  const Color(0xFF4A90E2).withOpacity(0.3),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Contact info
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Get In Touch",
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF2C3E50),
                  ),
                ),
                const SizedBox(height: 12),
                _buildContactItem(Icons.email_outlined, "hello@mindnest.dev"),
                _buildContactItem(Icons.phone_outlined, "+1 (555) 123-4567"),
              ],
            ),
          ),
          
          const Spacer(),
          
          // Enhanced CTA Button
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF4A90E2).withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: onContactPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF4A90E2), Color(0xFF2C3E50)],
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Start Your Project",
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, String subtitle, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFF4A90E2).withOpacity(0.1),
                const Color(0xFF2C3E50).withOpacity(0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: const Color(0xFF4A90E2),
            size: 22,
          ),
        ),
        title: Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF2C3E50),
          ),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.inter(
            fontSize: 13,
            color: const Color(0xFF4a5568),
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Color(0xFF4a5568),
        ),
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: const Color(0xFF4A90E2),
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: const Color(0xFF4a5568),
            ),
          ),
        ],
      ),
    );
  }
}

class DrawerPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..strokeWidth = 1;

    // Draw geometric pattern
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 6; j++) {
        final rect = Rect.fromLTWH(
          i * 60.0 - 20,
          j * 40.0 - 10,
          30,
          30,
        );
        canvas.drawRRect(
          RRect.fromRectAndRadius(rect, const Radius.circular(6)),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}