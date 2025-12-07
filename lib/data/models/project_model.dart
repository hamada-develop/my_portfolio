import 'package:flutter/material.dart';

class ProjectModel {
  final String title;
  final String subtitle;
  final String period;
  final String description;
  final List<String> technologies;
  final ProjectLinks links;
  final LinearGradient gradient;

  const ProjectModel({
    required this.title,
    required this.subtitle,
    required this.period,
    required this.description,
    required this.technologies,
    required this.links,
    required this.gradient,
  });
}

class ProjectLinks {
  final String? appStore;
  final String? playStore;
  final String? web;
  final String? appGallery;

  const ProjectLinks({
    this.appStore,
    this.playStore,
    this.web,
    this.appGallery,
  });

  bool get hasLinks =>
      appStore != null ||
          playStore != null ||
          web != null ||
          appGallery != null;

  List<ProjectLink> get availableLinks {
    List<ProjectLink> links = [];
    if (appStore != null) {
      links.add(ProjectLink(
        url: appStore!,
        platform: 'App Store',
        icon: '🍎',
      ));
    }
    if (playStore != null) {
      links.add(ProjectLink(
        url: playStore!,
        platform: 'Google Play',
        icon: '🤖',
      ));
    }
    if (web != null) {
      links.add(ProjectLink(
        url: web!,
        platform: 'Web',
        icon: '🌐',
      ));
    }
    if (appGallery != null) {
      links.add(ProjectLink(
        url: appGallery!,
        platform: 'App Gallery',
        icon: '📱',
      ));
    }
    return links;
  }
}

class ProjectLink {
  final String url;
  final String platform;
  final String icon;

  const ProjectLink({
    required this.url,
    required this.platform,
    required this.icon,
  });
}