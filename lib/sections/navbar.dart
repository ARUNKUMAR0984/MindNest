import 'package:ak_mindnest_studio_website/sections/contact_section.dart';
import 'package:ak_mindnest_studio_website/sections/projects_section.dart';
import 'package:ak_mindnest_studio_website/sections/services_section.dart';
import 'package:flutter/material.dart';

class Navbar extends StatefulWidget {
  final GlobalKey servicesKey;
  final GlobalKey projectsKey;
  final GlobalKey contactKey;

  const Navbar({
    super.key,
    required this.servicesKey,
    required this.projectsKey,
    required this.contactKey,
  });

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  String hoveredItem = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  // Scroll to top or home
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  transform: Matrix4.identity()..scale(hoveredItem == 'logo' ? 1.05 : 1.0),
                  child: MouseRegion(
                    onEnter: (_) => setState(() => hoveredItem = 'logo'),
                    onExit: (_) => setState(() => hoveredItem = ''),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xFF6B7280),
                                const Color(0xFF9CA3AF),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Image.asset(
                            'assets/logo.png',
                            height: 32,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'AkMindNest Studio',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF374151),
                            letterSpacing: -0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                _buildNavItem('Services', 'services'),
                const SizedBox(width: 8),
                _buildNavItem('Projects', 'projects'),
                const SizedBox(width: 8),
                _buildNavItem('Contact', 'contact'),
                const SizedBox(width: 24),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  onEnter: (_) => setState(() => hoveredItem = 'cta'),
                  onExit: (_) => setState(() => hoveredItem = ''),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: hoveredItem == 'cta'
                            ? [const Color(0xFF4B5563), const Color(0xFF374151)]
                            : [const Color(0xFF6B7280), const Color(0xFF4B5563)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF6B7280).withOpacity(0.3),
                          blurRadius: hoveredItem == 'cta' ? 12 : 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Scrollable.ensureVisible(
                            widget.contactKey.currentContext!,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        },
                        borderRadius: BorderRadius.circular(25),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Get Started',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String title, String key) {
    final isHovered = hoveredItem == key;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => hoveredItem = key),
      onExit: (_) => setState(() => hoveredItem = ''),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isHovered ? const Color(0xFF6B7280).withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              final contextToScroll = key == 'services'
                  ? widget.servicesKey.currentContext
                  : key == 'projects'
                      ? widget.projectsKey.currentContext
                      : widget.contactKey.currentContext;
              
              if (contextToScroll != null) {
                Scrollable.ensureVisible(
                  contextToScroll,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              }
            },
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: isHovered ? const Color(0xFF374151) : const Color(0xFF6B7280),
                      fontWeight: isHovered ? FontWeight.w600 : FontWeight.w500,
                      fontSize: 15,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 2),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 2,
                    width: isHovered ? title.length * 8.0 : 0,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF6B7280),
                          const Color(0xFF9CA3AF),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(1),
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
