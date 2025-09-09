import 'package:flutter/material.dart';

void main() {
  runApp(const OnboardingApp());
}

class OnboardingApp extends StatelessWidget {
  const OnboardingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Onboarding Flow',
      debugShowCheckedModeBanner: false,
      home: const OnboardingScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _fadeAnimation1;
  late final Animation<Offset> _slideAnimation1;

  late final Animation<double> _fadeAnimation2;
  late final Animation<Offset> _slideAnimation2;

  late final Animation<double> _fadeAnimation3;
  late final Animation<Offset> _slideAnimation3;

  late final Animation<double> _fadeAnimation4;
  late final Animation<Offset> _slideAnimation4;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _fadeAnimation1 = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
          parent: _controller, curve: const Interval(0.0, 0.25, curve: Curves.easeIn)),
    );
    _slideAnimation1 = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
          parent: _controller, curve: const Interval(0.0, 0.25, curve: Curves.easeOut)),
    );

    _fadeAnimation2 = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
          parent: _controller, curve: const Interval(0.25, 0.5, curve: Curves.easeIn)),
    );
    _slideAnimation2 = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
          parent: _controller, curve: const Interval(0.25, 0.5, curve: Curves.easeOut)),
    );

    _fadeAnimation3 = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
          parent: _controller, curve: const Interval(0.5, 0.75, curve: Curves.easeIn)),
    );
    _slideAnimation3 = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
          parent: _controller, curve: const Interval(0.5, 0.75, curve: Curves.easeOut)),
    );

    _fadeAnimation4 = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
          parent: _controller, curve: const Interval(0.75, 1.0, curve: Curves.easeIn)),
    );
    _slideAnimation4 = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
          parent: _controller, curve: const Interval(0.75, 1.0, curve: Curves.easeOut)),
    );

    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pushReplacementNamed('/home');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildAnimatedItem(
      {required Animation<double> fade,
      required Animation<Offset> slide,
      required Widget child}) {
    return FadeTransition(
      opacity: fade,
      child: SlideTransition(
        position: slide,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildAnimatedItem(
                fade: _fadeAnimation1,
                slide: _slideAnimation1,
                child: const Text(
                  'Welcome to Flutter App',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              _buildAnimatedItem(
                fade: _fadeAnimation2,
                slide: _slideAnimation2,
                child: Image.network(
                  'assets/Image.png',
                ),
              ),
              const SizedBox(height: 20),
              _buildAnimatedItem(
                fade: _fadeAnimation3,
                slide: _slideAnimation3,
                child: const Icon(
                  Icons.flutter_dash,
                  size: 80,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 20),
              _buildAnimatedItem(
                fade: _fadeAnimation4,
                slide: _slideAnimation4,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/home');
                  },
                  child: const Text('Get Started'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: const Center(
        child: Text(
          'Welcome Home!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
