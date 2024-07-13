import 'package:flutter/material.dart';
import '../models/message_model.dart';
import '../services/openai_service.dart';

class ChatViewModel extends ChangeNotifier {
  final List<Message> _messages = [];
  final OpenAIService _openAIService = OpenAIService();
  final TextEditingController textController = TextEditingController();

  List<Message> get messages => _messages;

  void sendMessage(String text) {
    _messages.add(Message(text: text, sender: 'user'));
    notifyListeners();
    _getReply(text);
  }

  Future<void> _getReply(String text) async {
    try {
      final imageUrl = await _openAIService.generateImage(text);
      _messages.add(Message(text: '', sender: 'bot', imageUrl: imageUrl));
    } catch (e) {
      _messages.add(Message(text: 'Error: ${e.toString()}', sender: 'bot'));
    }
    notifyListeners();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}