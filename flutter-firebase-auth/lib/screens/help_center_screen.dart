import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HelpCenterScreen extends StatefulWidget {
  static const String routeName = '/help-center';

  const HelpCenterScreen({Key? key}) : super(key: key);

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [
    {'sender': 'bot', 'text': 'Welcome to the AI Help Center! How can I help you today?'}
  ];

  final Color primaryColor = const Color.fromARGB(255, 17, 0, 16);
  bool _isTyping = false;

  // Function to send the message and get the AI response
  Future<void> _sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    // Add user's message
    setState(() {
      _messages.insert(0, {'sender': 'user', 'text': text.trim()});
      _controller.clear();
      _isTyping = true;
    });

    try {
      final botReply = await _getBotResponse(text.trim());
      setState(() {
        _messages.insert(0, {'sender': 'bot', 'text': botReply});
      });
    } catch (e) {
      setState(() {
        _messages.insert(0, {'sender': 'bot', 'text': '❗ Error occurred. Please try again.'});
      });
    } finally {
      setState(() {
        _isTyping = false;
      });
    }
  }

  // Function to get the AI response from OpenAI
  Future<String> _getBotResponse(String query) async {
  const apiKey = 'YOUR_API_KEY_HERE';
  final apiUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=$apiKey';

  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      "contents": [
        {
          "parts": [
            {"text": query}
          ],
          "role": "user"
        }
      ]
    }),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final botMessage = data['candidates'][0]['content']['parts'][0]['text'];
    return botMessage.trim();
  } else {
    print("Error: ${response.body}");
    throw Exception('Failed to fetch AI reply');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('Help Center'),
        foregroundColor: Colors.white,
      ),
      body: Container(
        color: primaryColor,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: _messages.length + (_isTyping ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (_isTyping && index == 0) {
                      return _buildTypingIndicator();
                    }
                    final message = _messages[_isTyping ? index - 1 : index];
                    final isBot = message['sender'] == 'bot';
                    return Align(
                      alignment: isBot ? Alignment.centerLeft : Alignment.centerRight,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: isBot ? Colors.grey[200] : primaryColor.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          message['text']!,
                          style: TextStyle(
                            color: isBot ? Colors.black87 : Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          hintText: 'Type your question...',
                          border: InputBorder.none,
                        ),
                        onSubmitted: (value) => _sendMessage(value),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    backgroundColor: primaryColor,
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.white),
                      onPressed: () => _sendMessage(_controller.text),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Typing indicator widget (Spinner)
  Widget _buildTypingIndicator() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
        child: const SpinKitThreeBounce(
          color: Colors.black87,
          size: 20.0,
        ),
      ),
    );
  }
}
