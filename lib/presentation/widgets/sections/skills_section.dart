import 'package:flutter/material.dart';


class SkillsSection2 extends StatelessWidget {
  const SkillsSection2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      width: double.infinity,
      color: Colors.orange.shade50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Skills",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),

          _buildSkillCategory(context, "Core", [
            "Flutter", "Dart", "Android (Kotlin)", "Java", "iOS (Swift)"
          ]),
          const SizedBox(height: 24),

          _buildSkillCategory(context, "State Management", [
            "Bloc / Cubit", "Provider", "Riverpod", "GetX"
          ]),
          const SizedBox(height: 24),

          _buildSkillCategory(context, "Tools & Backend", [
            "Firebase", "Git", "CI/CD", "Figma", "REST APIs", "GraphQL"
          ]),
        ],
      ),
    );
  }

  Widget _buildSkillCategory(BuildContext context, String title, List<String> skills) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: skills.map((skill) => Chip(
            label: Text(skill),
            backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
            side: BorderSide.none,
            avatar: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.check, size: 16),
            ),
          )).toList(),
        ),
      ],
    );
  }
}