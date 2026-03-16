import '../models/project_model.dart';
import '../models/experience_model.dart';
import '../models/skill_model.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/app_constants.dart';

class PortfolioData {
  PortfolioData._();

  // Projects
  static List<ProjectModel> get projects => [
    ProjectModel(
      title: 'Aber',
      subtitle: 'Dream Interpretation Platform',
      period: 'Jul 2022 – Oct 2025',
      description:
          'Led architectural planning and delivery using Clean Architecture and BLoC, '
          'driving app to production with an active user base. Implemented secure online '
          'payments (HyperPay) and WebRTC voice calls, enabling monetization and real-time '
          'features. Performed targeted profiling and UI optimizations, achieving an estimated '
          '40% speed improvement in critical user flows.',
      technologies: [
        'Flutter',
        'Clean Architecture',
        'BLoC',
        'WebRTC',
        'HyperPay',
        'CallKit',
        'Firebase',
      ],
      links: ProjectLinks(
        appStore: AppConstants.aberAppStore,
        playStore: AppConstants.aberPlayStore,
      ),
      gradient: AppColors.projectGradient1,
      image: AppConstants.abberProject,
    ),
    ProjectModel(
      title: 'Atmemly',
      subtitle: 'Freelancing Platform',
      period: 'Jul 2023 – Oct 2023',
      description:
          'Built a freelancing platform that connects project owners with freelancers. '
          'Implemented push notification system (Firebase Cloud Messaging) with deep linking '
          'and user segmentation. Designed responsive & adaptive UIs for seamless user experience '
          'across different devices and screen sizes.',
      technologies: [
        'Flutter',
        'Firebase FCM',
        'Deep Linking',
        'Responsive Design',
        'User Segmentation',
      ],
      links: ProjectLinks(
        appStore: AppConstants.atmemlyAppStore,
        playStore: AppConstants.atmemlyPlayStore,
      ),
      gradient: AppColors.projectGradient2,
      image: AppConstants.atmemly,
    ),
    ProjectModel(
      title: 'Remontada FC',
      subtitle: 'Sports Social Media',
      period: 'Jan 2023 – Oct 2023',
      description:
          'Built multi-role video platform supporting Clubs, Players, Coaches and more (9 profiles). '
          'Implemented video Reels and optimized playback lifecycle. Eliminated persistent dark-mode '
          'UI jank via render-thread profiling and widget rebuild fixes, improving 90th-percentile '
          'frame-rate to 60fps for core flows.',
      technologies: [
        'Flutter',
        'Video Streaming',
        'Multi-role System',
        'Performance Optimization',
        'State Management',
      ],
      links: ProjectLinks(
        appStore: AppConstants.remontadaAppStore,
        playStore: AppConstants.remontadaPlayStore,
        web: AppConstants.remontadaWeb,
      ),
      gradient: AppColors.projectGradient3,
      image: AppConstants.remontada,
    ),
    ProjectModel(
      title: 'Al-Mutawwif',
      subtitle: 'Pilgrimage Assistant App',
      period: '2022 - 2023',
      description:
          'Contributed to high-reliability features: navigation, multi-directional request handling, '
          'state persistence, and crash reliability improvements. Implemented core features for '
          'pilgrimage guidance with offline support and real-time updates.',
      technologies: [
        'Flutter',
        'Maps Integration',
        'Offline Support',
        'State Persistence',
        'High Reliability',
      ],
      links: ProjectLinks(
        appStore: AppConstants.mutawwifAppStore,
        playStore: AppConstants.mutawwifPlayStore,
        appGallery: AppConstants.mutawwifAppGallery,
      ),
      gradient: AppColors.projectGradient4,
      image: AppConstants.almotawef
    ),
    ProjectModel(
      title: 'Shooter App',
      subtitle: 'Pilgrimage Assistant App',
      period: '2022 - 2023',
      description:
          'Contributed to high-reliability features: navigation, multi-directional request handling, '
          'state persistence, and crash reliability improvements. Implemented core features for '
          'pilgrimage guidance with offline support and real-time updates.',
      technologies: [
        'Flutter',
        'Maps Integration',
        'Offline Support',
        'State Persistence',
        'High Reliability',
      ],
      links: ProjectLinks(
        appStore: AppConstants.mutawwifAppStore,
        playStore: AppConstants.mutawwifPlayStore,
        appGallery: AppConstants.mutawwifAppGallery,
      ),
      gradient: AppColors.projectGradient4,
      image: AppConstants.shooterApp,
    ),
  ];

  // Experience
  static List<ExperienceModel> get experiences => [
    const ExperienceModel(
      company: 'Somow Tech',
      role: 'Senior Flutter Developer',
      period: 'Jul 2022 – Oct 2025',
      location: 'Saudi Arabia - Remote',
      icon: '📱',
      achievements: [
        'Led full Flutter app development for "Aber", including Clean Architecture, BLoC state management, and modular feature structure',
        'Implemented secure authentication (Firebase Auth + API tokens) and user onboarding flows',
        'Implemented WebRTC voice calling with CallKit integration and contributed improvements to the flutter_callkit_incoming package',
        'Developed native payment integration (HyperPay) and managed store deployments to App Store and Google Play',
        'Optimized app performance via profiling, improving UI frame rate and load times by ~40%',
      ],
      technologies: [
        'Flutter',
        'Clean Architecture',
        'BLoC',
        'WebRTC',
        'Firebase',
        'HyperPay',
      ],
    ),
    const ExperienceModel(
      company: 'Dubisign',
      role: 'Flutter Developer / Technical Interviewer',
      period: 'Jan 2023 – Oct 2023',
      location: 'Mansoura - Onsite',
      icon: '🎬',
      achievements: [
        'Led front-end implementation of Remontada FC supporting 9 user roles and video Reels',
        'Optimized video prefetch and player lifecycle, reducing video start time',
        'Eliminated persistent dark-mode UI jank via render-thread profiling and widget rebuild fixes',
        'Improved 90th-percentile frame-rate to 60fps for core flows',
        'Designed a standardized technical assessment for new hires, shortening hiring time-to-offer',
      ],
      technologies: [
        'Flutter',
        'Video Streaming',
        'Performance Optimization',
        'Technical Interviewing',
      ],
    ),
    const ExperienceModel(
      company: 'Digital Vision',
      role: 'Flutter Developer',
      period: 'Dec 2021 – Feb 2022',
      location: 'Alexandria - Hybrid',
      icon: '🛒',
      achievements: [
        'Implemented core e-commerce features for most5dm using BLoC pattern',
        'Improved checkout reliability and reduced crash reports',
        'Focused on state-management and error handling best practices',
        'Delivered features on time with high code quality standards',
      ],
      technologies: ['Flutter', 'BLoC', 'E-commerce', 'State Management'],
    ),
    const ExperienceModel(
      company: 'IEEE-Elzaher',
      role: 'Volunteer Technical Mentor',
      period: 'Oct 2021 – Aug 2022',
      location: 'Cairo - Hybrid',
      icon: '👨‍🏫',
      achievements: [
        'Mentored university students in Flutter/Dart fundamentals',
        'Delivered workshops on state management and architectural best practices',
        'Helped students build their first Flutter applications',
        'Shared industry knowledge and career guidance',
      ],
      technologies: ['Flutter', 'Teaching', 'Mentoring', 'State Management'],
    ),
  ];

  // Skills
  static List<SkillCategory> get skills => [
    const SkillCategory(
      category: 'Core',
      icon: '💎',
      skills: [
        'Flutter',
        'Dart',
        'BLoC',
        'Cubit',
        'Provider',
        'GetX',
        'Flutter Web',
        'Cross-platform',
        'iOS',
        'Android',
        'Responsive Design',
      ],
    ),
    const SkillCategory(
      category: 'Architecture & Patterns',
      icon: '🏗️',
      skills: [
        'Clean Architecture',
        'SOLID',
        'Repository Pattern',
        'Dependency Injection',
        'Modularization',
      ],
    ),
    const SkillCategory(
      category: 'Real-time & Payments',
      icon: '⚡',
      skills: [
        'WebRTC',
        'CallKit',
        'Media Streaming',
        'HyperPay',
        'Payment Gateway Integration',
      ],
    ),
    const SkillCategory(
      category: 'Backend & Data',
      icon: '🗄️',
      skills: [
        'RESTful API',
        'WebSockets',
        'Firebase',
        'Firestore',
        'FCM',
        'Dio',
        'Hive',
        'Sqflite',
        'JSON',
      ],
    ),
    const SkillCategory(
      category: 'Testing & DevOps',
      icon: '🧪',
      skills: [
        'Unit Testing',
        'Widget Testing',
        'Integration Testing',
        'CI/CD',
        'Fastlane',
        'GitHub Actions',
        'GitLab CI',
      ],
    ),
    const SkillCategory(
      category: 'Native Interop',
      icon: '📲',
      skills: ['Kotlin', 'Java', 'Swift', 'Platform Channels'],
    ),
    const SkillCategory(
      category: 'Leadership',
      icon: '👔',
      skills: [
        'Technical Leadership',
        'Mentoring',
        'Architecture Reviews',
        'Technical Interviewing',
        'Cross-functional Communication',
      ],
    ),
  ];

  // Achievements
  static List<Achievement> get achievements => [
    const Achievement(
      value: '~40%',
      title: 'Performance Improvement',
      description: 'UI throughput on flagship app',
    ),
    const Achievement(
      value: '5+',
      title: 'Years Experience',
      description: 'Senior Flutter Development',
    ),
    const Achievement(
      value: '10+',
      title: 'Projects Delivered',
      description: 'Production apps with active users',
    ),
    const Achievement(
      value: '60fps',
      title: 'Frame Rate',
      description: 'Optimized for core user flows',
    ),
  ];

  // Education
  static const EducationModel education = EducationModel(
    degree: 'Bachelor of Physical Education',
    institution: 'University of Sadat City',
    period: 'Sep 2018 – Jun 2022',
    location: 'Menoufia',
  );

  // Certificates
  static List<CertificateModel> get certificates => [
    const CertificateModel(
      name: 'HMS Core App Developer Workshop',
      issuer: 'Huawei',
    ),
    const CertificateModel(name: 'Android Developer', issuer: 'Udacity'),
    const CertificateModel(
      name: 'One Million Arab Coders Initiative',
      issuer: 'One Million Arab Coders',
    ),
    const CertificateModel(
      name: 'The Complete 2022 Flutter & Dart Development Course',
      issuer: 'Udemy',
    ),
    const CertificateModel(
      name: 'Programming Foundations: Fundamentals',
      issuer: 'LinkedIn',
    ),
  ];
}
