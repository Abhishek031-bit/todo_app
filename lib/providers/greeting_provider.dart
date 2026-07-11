import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'greeting_provider.g.dart';

@riverpod
Stream<String> greeting(Ref ref) async* {
  while (true) {
    yield _getGreeting();

    final now = DateTime.now();
    final nextChange = _nextGreetingChange(now);

    await Future.delayed(nextChange.difference(now));
  }
}

String _getGreeting() {
  final hour = DateTime.now().hour;

  if (hour >= 5 && hour < 12) {
    return 'Good Morning';
  } else if (hour >= 12 && hour < 17) {
    return 'Good Afternoon';
  } else if (hour >= 17 && hour < 21) {
    return 'Good Evening';
  } else {
    return 'Good Night';
  }
}

DateTime _nextGreetingChange(DateTime now) {
  final today = DateTime(now.year, now.month, now.day);

  final changes = [
    today.add(const Duration(hours: 5)), // 05:00
    today.add(const Duration(hours: 12)), // 12:00
    today.add(const Duration(hours: 17)), // 17:00
    today.add(const Duration(hours: 21)), // 21:00
    today.add(const Duration(days: 1, hours: 5)), // Tomorrow 05:00
  ];

  return changes.firstWhere((time) => time.isAfter(now));
}
