import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:soulsync/pages/breathe_with_me.dart';
import 'package:soulsync/pages/chat_screen.dart';

class SafeSpaceHomePage extends StatelessWidget {
  const SafeSpaceHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF4A148C),
                  Color(0xFF6A1B9A),
                  Color(0xFF8E24AA),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Text(
                    'Hey there, how are you really feeling today?',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 30),
                  AnimatedHeadline(),
                  const SizedBox(height: 16),
                  const Text(
                    'Your AI companion, always here for your thoughts, feelings, and healing journey.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ChatScreen(),
                            ),
                          );
                        },
                        child: const Text('Start a Conversation'),
                      ),
                      OutlinedButton(
                        onPressed: () {},
                        child: const Text('See How It Works'),
                      ),
                      OutlinedButton(
                        onPressed: () {},
                        child: const Text('Track Your Mood'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'What best describes your mood today?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Wrap(
                    spacing: 10,
                    children: [
                      MoodChip(label: '😊 Happy'),
                      MoodChip(label: '😔 Sad'),
                      MoodChip(label: '😡 Frustrated'),
                      MoodChip(label: '😰 Anxious'),
                      MoodChip(label: '😴 Tired'),
                      MoodChip(label: '❓ Unsure'),
                    ],
                  ),
                  const SizedBox(height: 50),
                  const FeaturesSection(),
                  const SizedBox(height: 30),
                  TestimonialCard(),
                  const SizedBox(height: 40),
                  const Center(
                    child: Text(
                      'You\'re not alone. We\'re here to listen, anytime.',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('Privacy', style: TextStyle(color: Colors.white38)),
                      SizedBox(width: 10),
                      Text('About', style: TextStyle(color: Colors.white38)),
                      SizedBox(width: 10),
                      Text('Emergency Help',
                          style: TextStyle(color: Colors.white38)),
                      SizedBox(width: 10),
                      Text('Contact', style: TextStyle(color: Colors.white38)),
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedHeadline extends StatefulWidget {
  @override
  State<AnimatedHeadline> createState() => _AnimatedHeadlineState();
}

class _AnimatedHeadlineState extends State<AnimatedHeadline> {
  final List<String> _texts = [
    'A place to breathe.',
    'A space to talk.',
    'A friend who listens.'
  ];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), _changeText);
  }

  void _changeText() {
    if (!mounted) return;
    setState(() {
      _currentIndex = (_currentIndex + 1) % _texts.length;
    });
    Future.delayed(const Duration(seconds: 3), _changeText);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: Text(
        _texts[_currentIndex],
        key: ValueKey(_texts[_currentIndex]),
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}

class MoodChip extends StatelessWidget {
  final String label;
  const MoodChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      backgroundColor: Colors.white24,
      label: Text(label,
          style: const TextStyle(color: Color.fromARGB(255, 77, 74, 74))),
      onPressed: () {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Thanks for sharing"),
            content: const Text("Want to talk about it?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChatScreen(),
                    ),
                  );
                },
                child: const Text("Start Chat"),
              )
            ],
          ),
        );
      },
    );
  }
}

class FeaturesSection extends StatelessWidget {
  const FeaturesSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'How can I help you today?',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            FeatureCard(
                icon: Icons.chat,
                label: 'Talk to the AI',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChatScreen(),
                    ),
                  );
                }),
            const FeatureCard(icon: Icons.show_chart, label: 'Track your mood'),
            const FeatureCard(icon: Icons.book, label: 'Write in your journal'),
            FeatureCard(
                icon: Icons.air,
                label: 'Breathe with me',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BreatheWithMeScreen(),
                    ),
                  );
                }),
            const FeatureCard(icon: Icons.phone, label: 'Get support'),
          ],
        )
      ],
    );
  }
}

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onPressed;

  const FeatureCard({required this.icon, required this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class TestimonialCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Text(
        '"This little app became my go-to place after rough days. It\'s amazing how being listened to—even by AI—can help."',
        style: TextStyle(color: Colors.white70, fontStyle: FontStyle.italic),
      ),
    );
  }
}
