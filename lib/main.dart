import 'package:flutter/material.dart';
import 'package:tick_notes_app/views/home_view.dart';

void main() {
  runApp(TickNotesApp());
}

class TickNotesApp extends StatelessWidget {
  const TickNotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.dark),

      debugShowCheckedModeBanner: false,
      initialRoute: HomeView.id,
      routes: {HomeView.id: (context) => const HomeView()},
    );
  }
}
