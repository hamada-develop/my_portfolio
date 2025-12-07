class ExperienceModel {
  final String company;
  final String role;
  final String period;
  final String location;
  final String icon;
  final List<String> achievements;
  final List<String>? technologies;

  const ExperienceModel({
    required this.company,
    required this.role,
    required this.period,
    required this.location,
    required this.icon,
    required this.achievements,
    this.technologies,
  });
}

class EducationModel {
  final String degree;
  final String institution;
  final String period;
  final String location;

  const EducationModel({
    required this.degree,
    required this.institution,
    required this.period,
    required this.location,
  });
}

class CertificateModel {
  final String name;
  final String issuer;
  final String? url;

  const CertificateModel({
    required this.name,
    required this.issuer,
    this.url,
  });
}