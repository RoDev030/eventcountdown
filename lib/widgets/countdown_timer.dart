import 'dart:async';
import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  final DateTime eventDateTime;

  const CountdownTimer({super.key, required this.eventDateTime});

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Timer _timer;
  late Duration _timeRemaining;

  @override
  void initState() {
    super.initState();
    _updateTimeRemaining();
    _startTimer();
  }

  void _updateTimeRemaining() {
    final now = DateTime.now();
    setState(() {
      _timeRemaining = widget.eventDateTime.difference(now);
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => _updateTimeRemaining(),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    if (duration.isNegative) return "Event has started!";
    final days = duration.inDays;
    final hours = duration.inHours.remainder(24);
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return "$days d, $hours u, $minutes m, $seconds s";
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _formatDuration(_timeRemaining),
      style: const TextStyle(color: Colors.white, fontSize: 16),
    );
  }
}
