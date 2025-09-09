import 'package:flutter/material.dart';

void main() {
  runApp(const MoodLifterApp());
}

class MoodLifterApp extends StatelessWidget {
  const MoodLifterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood Lifter Profile Card',
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: MoodLifterProfileCard(),
        ),
      ),
    );
  }
}

class MoodLifterProfileCard extends StatefulWidget {
  const MoodLifterProfileCard({super.key});

  @override
  State<MoodLifterProfileCard> createState() => _MoodLifterProfileCardState();
}

class _MoodLifterProfileCardState extends State<MoodLifterProfileCard> {
  bool isHappy = false;

  void toggleMood() {
    setState(() {
      isHappy = !isHappy;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleMood,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isHappy ? Colors.yellow[200] : Colors.grey[300],
          borderRadius: BorderRadius.circular(isHappy ? 30 : 10),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: isHappy ? 20 : 5,
              spreadRadius: isHappy ? 5 : 1,
            ),
          ],
        ),
        width: isHappy ? 320 : 280,
        height: isHappy ? 160 : 140,
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: isHappy ? 80 : 60,
              height: isHappy ? 80 : 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: isHappy ? Colors.orange : Colors.blueGrey,
                    width: 4),
                image: const DecorationImage(
                  image: NetworkImage(
                    'https://avatars.githubusercontent.com/u/14101776?s=280&v=4',
                  ), // sample avatar URL, replace with your own or AssetImage
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Alex Johnson',
                    style: TextStyle(
                      fontSize: isHappy ? 22 : 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  AnimatedOpacity(
                    opacity: isHappy ? 1.0 : 0.5,
                    duration: const Duration(milliseconds: 500),
                    child: Text(
                      'Flutter enthusiast and mood lifter.',
                      style: TextStyle(
                        fontSize: 14,
                        color: isHappy ? Colors.orange[800] : Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              iconSize: 32,
              icon: Icon(
                isHappy
                    ? Icons.sentiment_very_satisfied
                    : Icons.sentiment_satisfied,
                color: isHappy ? Colors.orange : Colors.blueGrey,
              ),
              onPressed: toggleMood,
              tooltip: 'Toggle Mood',
            )
          ],
        ),
      ),
    );
  }
}
