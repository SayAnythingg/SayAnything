import 'dart:async';

import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
// ignore: depend_on_referenced_packages
import 'package:uuid/uuid.dart';
import 'package:rive/rive.dart' as rive;
import 'package:say_anything/services/API_services.dart';
import 'package:say_anything/function/SpeechServices.dart';
import 'package:say_anything/function/AnimationService.dart';

class Multimedia extends StatefulWidget {
  const Multimedia({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MultimediaState createState() => _MultimediaState();
}

class _MultimediaState extends State<Multimedia> {
  final List<types.Message> _messages = [];
  final _user = const types.User(id: 'user');
  final _openAIUser = const types.User(id: 'openai');

  late SpeechService _speechService;
  late AIService _apiService;
  late AnimationService _animationService;

  bool _isListening = false;
  String _text = '';
  Timer? _timer;
  int _seconds = 0;

  @override
  void initState() {
    super.initState();
    _speechService = SpeechService();
    _apiService = AIService();
    _animationService = AnimationService();
  }

  void _startListening() async {
    bool available = await _speechService.initializeSpeech(
      (val) => setState(() {
        _text = val;
      }),
      (val) => debugPrint('onError: $val'),
      (val) {
        if (val == 'notListening' && _isListening) {
          _startListening();
        }
      },
    );

    if (available) {
      setState(() {
        _isListening = true;
        _seconds = 0;
      });
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _seconds++;
        });
      });
      _speechService.startListening((val) => setState(() {
        _text = val;
      }));
    }
  }

  void _stopListening() {
    setState(() {
      _isListening = false;
    });
    _speechService.stopListening();
    _timer?.cancel();
    if (_text.isNotEmpty) {
      _addMessage(_text);
      _sendToOpenAI(_text);
    }
  }

  void _addMessage(String text, {bool isUserMessage = true}) {
    final message = types.TextMessage(
      author: isUserMessage ? _user : _openAIUser,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: text,
    );

    setState(() {
      _messages.insert(0, message);
    });
  }

  Future<void> _sendToOpenAI(String text) async {
    final message = await _apiService.sendToOpenAI(text);
    if (message != null) {
      _addMessage(message.trim(), isUserMessage: false);
      await _speechService.speak(message.trim());
      _animationService.playAnimation(); 
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _speechService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(Icons.psychology_rounded, size: 30, color: Color(0xFF545454)),
            const SizedBox(width: 4),
            Image.asset('assets/images/MultiMedia3.png',
                height: 135, width: 135),
          ],
        ),
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFDECFE2),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.smart_toy_outlined, color: Color(0xFF545454)),
            onPressed: () async {
              final joke = await _apiService.getJoke();
              showDialog(
                // ignore: use_build_context_synchronously
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0))),
                    content: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Image.asset('assets/images/logo.png',
                              width: 50.0, height: 50.0),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const SizedBox(height: 60),
                            Text(
                              joke.setup,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              joke.punchline,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.api),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.api),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFDECFE2), Color(0xFF7EC4CF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: rive.RiveAnimation.asset(
                  'assets/animation/character.riv',
                  controllers: [_animationService.controller],
                ),
              ),
            ),
            Expanded(
              child: Chat(
                messages: _messages,
                onSendPressed: (text) {},
                user: _user,
                emptyState: Center(
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    child: const Text(
                      'Please start talking to me',
                      style: TextStyle(fontSize: 18, color: Colors.black54),
                    ),
                  ),
                ),
                customBottomWidget: Container(),
              ),
            ),
            const SizedBox(height: 32.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  AvatarGlow(
                    animate: true,
                    glowColor: const Color.fromARGB(255, 255, 255, 255),
                    duration: const Duration(milliseconds: 2000),
                    repeat: true,
                    child: InkWell(
                      onTap: _isListening ? _stopListening : _startListening,
                      customBorder: const CircleBorder(),
                      child: CircleAvatar(
                        radius: 36,
                        backgroundColor: Colors.white,
                        child: Icon(
                          _isListening ? Icons.mic : Icons.mic_none,
                          color: const Color(0xFF7EC4CF),
                          size: 36,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    _isListening ? '$_seconds s' : '',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12.0),
          ],
        ),
      ),
    );
  }
}