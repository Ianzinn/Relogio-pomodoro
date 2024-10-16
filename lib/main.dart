import 'package:flutter/material.dart';
import 'package:pomodoro/pages/Pomodoro.dart';
import 'package:provider/provider.dart';
import './store/pomodoro.store.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<PomodoroStore>(
          create: (_) => PomodoroStore(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Relógio pomodoro',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Pomodoro(),
      ),
    );
  }
}
