import 'package:flutter/material.dart';

class Destination {
  const Destination(this.icon, this.label);
  final IconData icon;
  final String label;
}

const List<Destination> destinations = <Destination>[
  Destination(Icons.inbox_rounded, 'About'),
  Destination(Icons.article_outlined, 'Projects'),
  Destination(Icons.article_outlined, 'Work History'),
  Destination(Icons.messenger_outline_rounded, 'Skills'),
  Destination(Icons.contact_mail, 'Contact'),
];