import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );

    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
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
      ),
    );
  }

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
        );
      },
    );
  }

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

  Widget _buildContactForm() {
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
          ),
        ],
      ),
    );
  }



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