import 'package:flutter/material.dart';



class ContactSection2 extends StatelessWidget {
  const ContactSection2({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width > 700;

    return Container(
      padding: const EdgeInsets.all(24),
      width: double.infinity,
      color: Colors.purple.shade50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Contact Me",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text("Let's work together!"),
          const SizedBox(height: 32),

          // Responsive Layout: Row for Desktop, Column for Mobile
          if (isWide)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildContactInfo(context)),
                const SizedBox(width: 40),
                Expanded(child: _buildContactForm(context)),
              ],
            )
          else
            Column(
              children: [
                _buildContactInfo(context),
                const SizedBox(height: 40),
                _buildContactForm(context),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildContactInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildContactTile(Icons.email, "Email", "hamada@example.com"),
        _buildContactTile(Icons.phone, "Phone", "+20 123 456 7890"),
        _buildContactTile(Icons.location_on, "Location", "Cairo, Egypt"),
        const SizedBox(height: 20),
        Row(
          children: [
            IconButton.filledTonal(onPressed: (){}, icon: const Icon(Icons.code)), // GitHub
            const SizedBox(width: 10),
            IconButton.filledTonal(onPressed: (){}, icon: const Icon(Icons.work)), // LinkedIn
          ],
        )
      ],
    );
  }

  Widget _buildContactTile(IconData icon, String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, size: 28, color: Colors.purple),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(content, style: const TextStyle(fontSize: 16)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildContactForm(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const TextField(decoration: InputDecoration(labelText: "Your Name", border: OutlineInputBorder())),
            const SizedBox(height: 16),
            const TextField(decoration: InputDecoration(labelText: "Your Email", border: OutlineInputBorder())),
            const SizedBox(height: 16),
            const TextField(
              maxLines: 4,
              decoration: InputDecoration(labelText: "Message", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.send),
                label: const Text("Send Message"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}