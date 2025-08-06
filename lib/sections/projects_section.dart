import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
// Add this import at the top of the file
import 'dart:math' as math;
class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late List<Animation<double>> _cardAnimations;
  late AnimationController _parallaxController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    );

    _parallaxController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    _cardAnimations = List.generate(4, (index) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            index * 0.15,
            0.4 + (index * 0.15),
            curve: Curves.elasticOut,
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
    final projects = [
      {
        'title': '2048 Game',
        'subtitle': 'Classic Puzzle Game',
        'description': 'A beautifully designed 2048 puzzle game with smooth animations, score tracking, and addictive gameplay. Features clean UI and optimized performance for all devices.',
        'technologies': ['Flutter', 'Dart', 'Animations', 'Local Storage', 'Game Logic'],
        'status': 'Live on Play Store',
        'downloads': '1.2K+',
        'rating': '4.5',
        'reviews': '45',
        'link': 'https://play.google.com/store/apps/details?id=com.arunkumar.my_first_game_2048',
        'github': 'https://github.com/ARUNKUMAR0984/2048-game',
        'icon': Icons.games,
        'color': const Color(0xFF8B5CF6),
        'isLive': true,
        'screenshots': [
          'https://drive.google.com/uc?export=view&id=1wnN16SXQfz5BaR7qLnD0PDJhPKsrCQ7n',
        ],
        'features': ['Smooth Animations', 'Score Tracking', 'Best Score Memory', 'Restart Game'],
        'category': 'Gaming',
      },
      {
        'title': 'PomoPro',
        'subtitle': 'Productivity Timer',
        'description': 'Advanced Pomodoro timer app with customizable work sessions, break intervals, task management, and detailed productivity analytics for enhanced focus.',
        'technologies': ['Flutter', 'Firebase', 'Push Notifications', 'Analytics', 'Charts'],
        'status': 'Coming Soon',
        'downloads': 'Pre-launch',
        'rating': 'New',
        'reviews': '0',
        'link': '#',
        'github': 'https://github.com/ARUNKUMAR0984/pomopro',
        'icon': Icons.timer,
        'color': const Color(0xFFF59E0B),
        'isLive': false,
        'screenshots': [
         'https://drive.google.com/uc?export=view&id=1wnN16SXQfz5BaR7qLnD0PDJhPKsrCQ7n',
        ],
        'features': ['Custom Timers', 'Task Management', 'Statistics', 'Focus Sessions'],
        'category': 'Productivity',
      },
      {
        'title': 'DocForge',
        'subtitle': 'PDF Utility & Notes',
        'description': 'Comprehensive PDF management and note-sharing platform with advanced document editing, real-time collaboration, and secure cloud synchronization.',
        'technologies': ['Flutter', 'Supabase', 'PDF Kit', 'Cloud Storage', 'Real-time DB'],
        'status': 'In Development',
        'downloads': 'Pre-launch',
        'rating': 'New',
        'reviews': '0',
        'link': '#',
        'github': 'https://github.com/ARUNKUMAR0984/docforge',
        'icon': Icons.picture_as_pdf,
        'color': const Color(0xFFEF4444),
        'isLive': false,
        'screenshots': [
          'https://drive.google.com/uc?export=view&id=1wnN16SXQfz5BaR7qLnD0PDJhPKsrCQ7n',
          
        ],
        'features': ['PDF Merge', 'PDF Split', 'Lock PDF'],
        'category': 'Utility',
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
                    
                    // Projects showcase
                    _buildProjectsShowcase(projects),
                    
                    const SizedBox(height: 80),
                    
                    // Enhanced stats section
                    _buildEnhancedStatsSection(),
                    
                    const SizedBox(height: 60),
                    
                    // Call to action
                    _buildCallToAction(),
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
            painter: BackgroundPainter(_parallaxController.value),
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
                const Color(0xFF6B7280).withOpacity(0.1),
                const Color(0xFF9CA3AF).withOpacity(0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: const Color(0xFF6B7280).withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.rocket_launch,
                size: 16,
                color: const Color(0xFF6B7280),
              ),
              const SizedBox(width: 8),
              Text(
                'MY PROJECTS',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF6B7280),
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
              const Color(0xFF9CA3AF),
            ],
          ).createShader(bounds),
          child: Text(
            'Crafting Digital\nExperiences',
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
          constraints: const BoxConstraints(maxWidth: 600),
          child: Text(
            'From concept to deployment, I create innovative mobile applications that solve real-world problems and deliver exceptional user experiences.',
            style: TextStyle(
              fontSize: 18,
              color: const Color(0xFF6B7280),
              height: 1.6,
              letterSpacing: 0.3,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildProjectsShowcase(List<Map<String, dynamic>> projects) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Column(
          children: projects.asMap().entries.map((entry) {
            final index = entry.key;
            final project = entry.value;
            final isEven = index % 2 == 0;
            
            return Transform.translate(
              offset: Offset(0, (1 - _cardAnimations[index].value) * 50),
              child: Opacity(
                opacity: _cardAnimations[index].value,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 60),
                  child: EnhancedProjectCard(
                    project: project,
                    isReversed: !isEven,
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildEnhancedStatsSection() {
    final stats = [
      {
        'label': 'Apps Published',
        'value': '3+',
        'icon': Icons.publish,
        'color': const Color(0xFF8B5CF6),
        'description': 'Live on Play Store'
      },
      
      {
        'label': 'Code Commits',
        'value': '500+',
        'icon': Icons.code,
        'color': const Color(0xFFF59E0B),
        'description': 'GitHub Activity'
      },
      {
        'label': 'User Rating',
        'value': '4.8★',
        'icon': Icons.star,
        'color': const Color(0xFFEF4444),
        'description': 'Average Score'
      },
    ];

    return Container(
      padding: const EdgeInsets.all(50),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            const Color(0xFFF8FAFC),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.trending_up,
                color: const Color(0xFF6B7280),
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'Project Impact',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF374151),
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: 50,
            runSpacing: 40,
            alignment: WrapAlignment.center,
            children: stats.map((stat) {
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          (stat['color'] as Color).withOpacity(0.1),
                          (stat['color'] as Color).withOpacity(0.05),
                        
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color:(stat['color'] as Color).withOpacity(0.2),
                      ),
                    ),
                    child: Icon(
                      stat['icon'] as IconData,
                      color: stat['color'] as Color,
                      size: 36,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    stat['value'] as String,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF374151),
                      letterSpacing: -1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    stat['label'] as String,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    stat['description'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      color: const Color(0xFF9CA3AF),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCallToAction() {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF6B7280),
            const Color(0xFF4B5563),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6B7280).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Have a Project in Mind?',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Let\'s collaborate and bring your ideas to life with cutting-edge mobile solutions.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.9),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => _launchUrl('mailto:arunkumars97462@gmail.com?subject=Project Collaboration'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF374151),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 0,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.mail, size: 18),
                const SizedBox(width: 8),
                Text(
                  'Start a Conversation',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (url != '#' && await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}

class EnhancedProjectCard extends StatefulWidget {
  final Map<String, dynamic> project;
  final bool isReversed;

  const EnhancedProjectCard({
    super.key,
    required this.project,
    this.isReversed = false,
  });

  @override
  State<EnhancedProjectCard> createState() => _EnhancedProjectCardState();
}

class _EnhancedProjectCardState extends State<EnhancedProjectCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  late Animation<double> _scaleAnimation;
  PageController? _screenshotController;
  int _currentScreenshot = 0;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeOut),
    );
    _screenshotController = PageController();
  }

  @override
  void dispose() {
    _hoverController.dispose();
    _screenshotController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 768;
    
    return MouseRegion(
      onEnter: (_) => _hoverController.forward(),
      onExit: (_) => _hoverController.reverse(),
      child: AnimatedBuilder(
        animation: _hoverController,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1200),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: widget.project['color'].withOpacity(0.1),
                    blurRadius: 30,
                    offset: const Offset(0, 15),
                  ),
                ],
                border: Border.all(
                  color: Colors.grey[200]!,
                  width: 1,
                ),
              ),
              child: isDesktop
                  ? _buildDesktopLayout()
                  : _buildMobileLayout(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      children: widget.isReversed
          ? [_buildContent(), _buildScreenshots()]
          : [_buildScreenshots(), _buildContent()],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildScreenshots(),
        _buildContent(),
      ],
    );
  }

  Widget _buildScreenshots() {
    return Flexible(
      flex: 5,
      child: Container(
        height: 400,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              widget.project['color'].withOpacity(0.1),
              widget.project['color'].withOpacity(0.05),
            ],
          ),
          borderRadius: widget.isReversed
              ? const BorderRadius.only(
                  topRight: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                )
              : const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  bottomLeft: Radius.circular(24),
                ),
        ),
        child: Stack(
          children: [
            // Phone mockup frame
            Center(
              child: Container(
                width: 200,
                height: 350,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Container(
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(21),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(21),
                    child: _buildScreenshotCarousel(),
                  ),
                ),
              ),
            ),
            
            // Navigation dots
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.project['screenshots'].length,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentScreenshot == index ? 20 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentScreenshot == index
                          ? widget.project['color']
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

Widget _buildScreenshotCarousel() {
  return PageView.builder(
    controller: _screenshotController,
    onPageChanged: (index) => setState(() => _currentScreenshot = index),
    itemCount: widget.project['screenshots'].length,
    itemBuilder: (context, index) {
      return Image.network(
        widget.project['screenshots'][index],
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Center(
            child: Text(
              'Failed to load image',
              style: TextStyle(color: Colors.red),
            ),
          );
        },
      );
    },
  );
}


  Widget _buildContent() {
    return Flexible(
      flex: 6,
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: widget.project['color'].withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: widget.project['color'].withOpacity(0.3),
                ),
              ),
              child: Text(
                widget.project['category'],
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: widget.project['color'],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Title and subtitle
            Text(
              widget.project['title'],
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                color: const Color(0xFF374151),
                letterSpacing: -1,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.project['subtitle'],
              style: TextStyle(
                fontSize: 18,
                color: widget.project['color'],
                fontWeight: FontWeight.w600,
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Description
            Text(
              widget.project['description'],
              style: TextStyle(
                fontSize: 16,
                color: const Color(0xFF6B7280),
                height: 1.6,
                letterSpacing: 0.2,
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Features
            Text(
              'Key Features',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF374151),
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.project['features'].map<Widget>((feature) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6B7280).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    feature,
                    style: TextStyle(
                      fontSize: 12,
                      color: const Color(0xFF6B7280),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
            ),
            
            const SizedBox(height: 24),
            
            // Technologies
            Text(
              'Technologies Used',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF374151),
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.project['technologies'].map<Widget>((tech) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        widget.project['color'].withOpacity(0.1),
                        widget.project['color'].withOpacity(0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: widget.project['color'].withOpacity(0.2),
                    ),
                  ),
                  child: Text(
                    tech,
                    style: TextStyle(
                      fontSize: 12,
                      color: widget.project['color'],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }).toList(),
            ),
            
            const SizedBox(height: 32),
            
            // Stats and actions
            Row(
              children: [
                if (widget.project['isLive']) ...[
                  _buildStatItem(Icons.download, widget.project['downloads']),
                  const SizedBox(width: 20),
                  _buildStatItem(Icons.star, '${widget.project['rating']} (${widget.project['reviews']})'),
                  const Spacer(),
                ] else ...[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.orange.withOpacity(0.3)),
                    ),
                    child: Text(
                      widget.project['status'],
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.orange[700],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
                
                // Action buttons
                Row(
                  children: [
                    if (widget.project['github'] != '#')
                      _buildActionButton(
                        'Code',
                        Icons.code,
                        () => _launchUrl(widget.project['github']),
                        isSecondary: true,
                      ),
                    if (widget.project['isLive']) ...[
                      const SizedBox(width: 12),
                      _buildActionButton(
                        'View App',
                        Icons.open_in_new,
                        () => _launchUrl(widget.project['link']),
                        isSecondary: false,
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 16,
          color: const Color(0xFF6B7280),
        ),
        const SizedBox(width: 6),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: const Color(0xFF6B7280),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(
    String label,
    IconData icon,
    VoidCallback onTap, {
    bool isSecondary = false,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            gradient: isSecondary
                ? null
                : LinearGradient(
                    colors: [
                      widget.project['color'],
                      widget.project['color'].withOpacity(0.8),
                    ],
                  ),
            color: isSecondary ? Colors.white : null,
            border: isSecondary
                ? Border.all(color: widget.project['color'].withOpacity(0.3))
                : null,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: widget.project['color'].withOpacity(isSecondary ? 0.1 : 0.3),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 16,
                color: isSecondary ? widget.project['color'] : Colors.white,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: isSecondary ? widget.project['color'] : Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (url != '#' && await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}

class BackgroundPainter extends CustomPainter {
  final double animation;

  BackgroundPainter(this.animation);

 @override
void paint(Canvas canvas, Size size) {
  final paint = Paint()..style = PaintingStyle.fill;

  for (int i = 0; i < 8; i++) {
    final double opacity = 0.03 + (i % 3) * 0.01;
    paint.color = const Color(0xFF6B7280).withOpacity(opacity);

    final double x = (size.width * 0.1) +
        (i * size.width * 0.15) +
        (50 * math.sin(animation * 2 * math.pi + i));

    final double y = (size.height * 0.2) +
        (i % 3) * (size.height * 0.3) +
        (30 * math.cos(animation * 2 * math.pi + i));

    final double radius = 20 + (i % 4) * 10.0;

    if (i % 2 == 0) {
      canvas.drawCircle(Offset(x, y), radius, paint);
    } else {
      canvas.drawRRect(
        RRect.fromLTRBR(
          x - radius,
          y - radius,
          x + radius,
          y + radius,
          Radius.circular(radius * 0.2),
        ),
        paint,
      );
    }
  }
}


  @override
  bool shouldRepaint(BackgroundPainter oldDelegate) {
    return oldDelegate.animation != animation;
  }
}

