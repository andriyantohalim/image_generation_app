import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/chat_viewmodel.dart';
import 'views/chat_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChatViewModel(),
      child: const MaterialApp(
        home: ChatView(),
      ),
    );
  }
}