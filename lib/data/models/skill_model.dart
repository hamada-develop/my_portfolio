class SkillCategory {
  final String category;
  final List<String> skills;
  final String? icon;

  const SkillCategory({
    required this.category,
    required this.skills,
    this.icon,
  });
}

class Achievement {
  final String value;
  final String title;
  final String description;

  const Achievement({
    required this.value,
    required this.title,
    required this.description,
  });
}