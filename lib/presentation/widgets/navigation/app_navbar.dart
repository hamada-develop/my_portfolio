import 'package:flutter/material.dart';
import 'dart:ui';
import '../../../core/theme/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/responsive.dart';

class AppNavbar extends StatefulWidget {
  final ScrollController scrollController;

  const AppNavbar({
    super.key,
    required this.scrollController,
  });

  @override
  State<AppNavbar> createState() => _AppNavbarState();
}

class _AppNavbarState extends State<AppNavbar> {
  String _activeSection = AppConstants.sectionHome;
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    if (widget.scrollController.offset > 50 && !_isScrolled) {
      setState(() => _isScrolled = true);
    } else if (widget.scrollController.offset <= 50 && _isScrolled) {
      setState(() => _isScrolled = false);
    }
  }

  void _scrollToSection(String section) {
    setState(() => _activeSection = section);

    double offset;
    switch (section) {
      case AppConstants.sectionHome:
        offset = 0;
        break;
      case AppConstants.sectionExperience:
        offset = MediaQuery.of(context).size.height * 1.5;
        break;
      case AppConstants.sectionProjects:
        offset = MediaQuery.of(context).size.height * 2.5;
        break;
      case AppConstants.sectionContact:
        offset = MediaQuery.of(context).size.height * 4.0;
        break;
      default:
        offset = 0;
    }

    widget.scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;

    return AnimatedContainer(
      duration: AppConstants.animationNormal,
      decoration: BoxDecoration(
        color: _isScrolled
            ? AppColors.backgroundDark.withOpacity(0.8)
            : Colors.transparent,
        border: _isScrolled
            ? const Border(
          bottom: BorderSide(
            color: AppColors.glassBorder,
            width: 1,
          ),
        )
            : null,
      ),
      child: ClipRect(
        child: BackdropFilter(
          filter: _isScrolled
              ? ImageFilter.blur(sigmaX: 10, sigmaY: 10)
              : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: responsive.getValue(
                mobile: AppConstants.spacingMd,
                tablet: AppConstants.spacingXl,
                desktop: AppConstants.spacing3xl,
              ),
              vertical: AppConstants.spacingMd,
            ),
            child: responsive.isMobile
                ? _buildMobileNavbar()
                : _buildDesktopNavbar(),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopNavbar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Logo
        _buildLogo(),

        // Navigation Items
        Row(
          children: [
            _NavItem(
              label: 'Home',
              isActive: _activeSection == AppConstants.sectionHome,
              onTap: () => _scrollToSection(AppConstants.sectionHome),
            ),
            const SizedBox(width: AppConstants.spacingXl),
            _NavItem(
              label: 'Experience',
              isActive: _activeSection == AppConstants.sectionExperience,
              onTap: () => _scrollToSection(AppConstants.sectionExperience),
            ),
            const SizedBox(width: AppConstants.spacingXl),
            _NavItem(
              label: 'Projects',
              isActive: _activeSection == AppConstants.sectionProjects,
              onTap: () => _scrollToSection(AppConstants.sectionProjects),
            ),
            const SizedBox(width: AppConstants.spacingXl),
            _NavItem(
              label: 'Contact',
              isActive: _activeSection == AppConstants.sectionContact,
              onTap: () => _scrollToSection(AppConstants.sectionContact),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileNavbar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildLogo(),
        PopupMenuButton<String>(
          icon: const Icon(
            Icons.menu,
            color: AppColors.textPrimary,
          ),
          color: AppColors.backgroundDeep,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusMd),
            side: const BorderSide(
              color: AppColors.glassBorder,
              width: 1,
            ),
          ),
          onSelected: _scrollToSection,
          itemBuilder: (context) => [
            _buildMenuItem('Home', AppConstants.sectionHome),
            _buildMenuItem('Experience', AppConstants.sectionExperience),
            _buildMenuItem('Projects', AppConstants.sectionProjects),
            _buildMenuItem('Contact', AppConstants.sectionContact),
          ],
        ),
      ],
    );
  }

  Widget _buildLogo() {
    return GestureDetector(
      onTap: () => _scrollToSection(AppConstants.sectionHome),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(AppConstants.radiusSm),
        ),
        child: const Center(
          child: Text(
            'H',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  PopupMenuItem<String> _buildMenuItem(String label, String value) {
    return PopupMenuItem<String>(
      value: value,
      child: Text(
        label,
        style: TextStyle(
          color: _activeSection == value
              ? AppColors.accentPurpleLight
              : AppColors.textSecondary,
          fontWeight:
          _activeSection == value ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    Key? key,
    required this.label,
    required this.isActive,
    required this.onTap,
  }) : super(key: key);

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: AppConstants.animationFast,
          padding: const EdgeInsets.symmetric(
            vertical: AppConstants.spacingSm,
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: widget.isActive
                    ? AppColors.accentPurpleLight
                    : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              color: _isHovered || widget.isActive
                  ? AppColors.accentPurpleLight
                  : AppColors.textSecondary,
              fontSize: 16,
              fontWeight: widget.isActive ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}