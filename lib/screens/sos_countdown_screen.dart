import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SosCountdownScreen extends StatefulWidget {
  final VoidCallback onCancel;
  final VoidCallback onCountdownFinished;

  const SosCountdownScreen({
    Key? key,
    required this.onCancel,
    required this.onCountdownFinished,
  }) : super(key: key);

  @override
  State<SosCountdownScreen> createState() => _SosCountdownScreenState();
}

class _SosCountdownScreenState extends State<SosCountdownScreen> {
  int _secondsLeft = 3;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft > 1) {
        setState(() {
          _secondsLeft--;
        });
      } else {
        _timer?.cancel();
        widget.onCountdownFinished();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0C0E12),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: LifelineSpacing.xl3, vertical: LifelineSpacing.xl3),
          child: Column(
            children: [
              const Spacer(),

              // Subhead
              Text(
                'SOS akan dikirim dalam',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white.withValues(alpha: 0.7),
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: LifelineSpacing.xl3),

              // Huge Countdown Number
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                child: Text(
                  '$_secondsLeft',
                  key: ValueKey<int>(_secondsLeft),
                  style: const TextStyle(
                    fontSize: 140,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFFE53935),
                    height: 1.0,
                  ),
                ),
              ),
              const SizedBox(height: LifelineSpacing.xl4),

              // Explanation text
              Text(
                'Kami akan menelepon 112, membagikan\nlokasi, dan memberi tahu 4 kontak\ndarurat.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withValues(alpha: 0.75),
                  height: 1.45,
                ),
              ),

              const Spacer(),

              // Cancel Button
              ElevatedButton(
                onPressed: () {
                  _timer?.cancel();
                  widget.onCancel();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF181D27),
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(LifelineRadius.xl2),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Batalkan',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: LifelineSpacing.lg16),
            ],
          ),
        ),
      ),
    );
  }
}
