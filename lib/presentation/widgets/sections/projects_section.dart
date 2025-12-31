import 'package:flutter/material.dart';

class ProjectsSection2 extends StatelessWidget {
  const ProjectsSection2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      color: Colors.green.shade50,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("My Projects", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          // Dynamic Grid: 1 column on mobile, 2 on desktop
          LayoutBuilder(builder: (context, constraints) {
            final crossAxisCount = constraints.maxWidth > 700 ? 2 : 1;
            return GridView.builder(
              shrinkWrap: true, // Vital for scrolling inside a Column
              physics: const NeverScrollableScrollPhysics(), // Disable internal scroll
              itemCount: 4,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.5,
              ),
              itemBuilder: (context, index) => Card(
                color: Colors.green.shade200,
                child: Center(child: Text("Project #${index + 1}")),
              ),
            );
          }),
        ],
      ),
    );
  }
}