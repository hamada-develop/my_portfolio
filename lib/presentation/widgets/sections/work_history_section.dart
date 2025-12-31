import 'package:flutter/material.dart';


class WorkHistorySection2 extends StatelessWidget {
  const WorkHistorySection2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      width: double.infinity,
      color: Colors.blueGrey.shade50, // Distinct background color
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Work History",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),

          // List of Experience Cards
          _buildExperienceCard(
            context,
            company: "Tech Solutions Inc.",
            role: "Senior Flutter Developer",
            duration: "2023 - Present",
            description: "Led a team of 5 developers building a fintech super-app. Improved app performance by 40% using Isolates.",
          ),
          _buildExperienceCard(
            context,
            company: "Creative Studio",
            role: "Mobile App Developer",
            duration: "2021 - 2023",
            description: "Developed and shipped 3 e-commerce apps for high-profile clients. Integrated payment gateways and complex animations.",
          ),
          _buildExperienceCard(
            context,
            company: "Startup Hub",
            role: "Junior Android Developer",
            duration: "2018 - 2021",
            description: "Started with Native Android (Java/Kotlin) before migrating legacy codebases to Flutter.",
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceCard(
      BuildContext context, {
        required String company,
        required String role,
        required String duration,
        required String description,
      }) {
    // Responsive Layout Check
    final isWide = MediaQuery.sizeOf(context).width > 600;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    company,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                if (isWide) // Show duration on the right for desktop
                  Text(duration, style: const TextStyle(fontWeight: FontWeight.w500)),
              ],
            ),
            if (!isWide) ...[ // Show duration below title for mobile
              const SizedBox(height: 4),
              Text(duration, style: TextStyle(color: Colors.grey[600])),
            ],
            const SizedBox(height: 8),
            Text(
              role,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: TextStyle(fontSize: 14, color: Colors.grey[800], height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}