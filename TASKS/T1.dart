import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MAD Lab Task 1',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Task 1 - Widgets"),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              ProfileCard(),
              SizedBox(height: 20),
              RatingWidget(),
              SizedBox(height: 20),
              ContentToggle(),
            ],
          ),
        ),
      ),
    );
  }
}

/// Sub-Task 1.1: Social Media Profile Card
class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage("assets/images/profile.jpg"),
            ),
            const SizedBox(height: 10),
            const Text("Viraj Mhatre",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Text("Flutter Developer | Tech Enthusiast",
                style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                ProfileStat(label: "Posts", count: "120"),
                ProfileStat(label: "Followers", count: "450"),
                ProfileStat(label: "Following", count: "180"),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ProfileStat extends StatelessWidget {
  final String label;
  final String count;
  const ProfileStat({super.key, required this.label, required this.count});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(count,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}

/// Sub-Task 1.2: Interactive Rating Widget
class RatingWidget extends StatefulWidget {
  const RatingWidget({super.key});

  @override
  State<RatingWidget> createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  int _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            return IconButton(
              onPressed: () {
                setState(() {
                  _rating = index + 1;
                });
              },
              icon: Icon(
                index < _rating ? Icons.star : Icons.star_border,
                color: Colors.amber,
                size: 32,
              ),
            );
          }),
        ),
        Text("Rating: $_rating / 5",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      ],
    );
  }
}

/// Sub-Task 1.3: Dynamic Content Toggle with RichText
class ContentToggle extends StatefulWidget {
  const ContentToggle({super.key});

  @override
  State<ContentToggle> createState() => _ContentToggleState();
}

class _ContentToggleState extends State<ContentToggle> {
  bool _showFullText = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            style: const TextStyle(color: Colors.black, fontSize: 16),
            children: [
              const TextSpan(
                  text:
                      "Flutter is Google’s UI toolkit for building natively compiled applications... "),
              if (_showFullText)
                const TextSpan(
                    text:
                        "It helps you build apps for mobile, web, and desktop from a single codebase, with fast development and expressive UI."),
            ],
          ),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              _showFullText = !_showFullText;
            });
          },
          child: Text(_showFullText ? "Read Less" : "Read More"),
        )
      ],
    );
  }
}
