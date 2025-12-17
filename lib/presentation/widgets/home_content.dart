import 'package:book/presentation/widgets/sections/achievements_section.dart';
import 'package:book/presentation/widgets/sections/contact_section.dart';
import 'package:book/presentation/widgets/sections/cover_section.dart';
import 'package:book/presentation/widgets/sections/experience_section.dart';
import 'package:book/presentation/widgets/sections/projects_section.dart';
import 'package:book/presentation/widgets/sections/skills_section.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_constants.dart';


class HomeContent2 extends StatelessWidget {
  const HomeContent2({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // controller: _scrollController,
      child: Column(
        children: [


          // Cover Section
          // const CoverSection(),

          // const SizedBox(height: AppConstants.spacing4xl),
          //
          // // // Skills Section
          // const SkillsSection(),
          // //
          // const SizedBox(height: AppConstants.spacing4xl),
          // //
          // // // Experience Section
          // const ExperienceSection(),
          // //
          // const SizedBox(height: AppConstants.spacing4xl),
          // //
          // // // Projects Section
          // const ProjectsSection(),
          //
          // const SizedBox(height: AppConstants.spacing4xl),
          //
          // // Achievements Section
          // const AchievementsSection(),
          //
          // const SizedBox(height: AppConstants.spacing4xl),
          //
          // // Contact Section
          // const ContactSection(),
          //
          // // Footer
          // const FooterSection(),
        ],
      ),
    );
  }
}
