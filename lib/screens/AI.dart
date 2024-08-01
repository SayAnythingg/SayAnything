import 'package:SayAnything/services/API_services.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
// ignore: depend_on_referenced_packages
import 'package:speech_to_text/speech_to_text.dart' as stt;
// ignore: depend_on_referenced_packages
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
// ignore: depend_on_referenced_packages
import 'package:uuid/uuid.dart';
// ignore: depend_on_referenced_packages
import 'package:dart_openai/dart_openai.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:rive/rive.dart' as rive;

final JokeApiService = JokeApi();

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

  late stt.SpeechToText _speech;
  late FlutterTts _flutterTts;
  bool _isListening = false;
  String _text = '';
  Timer? _timer;
  int _seconds = 0;

  late rive.RiveAnimationController _riveController;

  @override
  void initState() {
    super.initState();
    OpenAI.apiKey = 'sk-proj-H6qL1pU1mM8SGE7efMrVT3BlbkFJTtxFghKPPgyhajLVhWVO';
    _speech = stt.SpeechToText();
    _flutterTts = FlutterTts();
    _riveController = rive.SimpleAnimation('idle');
  }

  void _startListening() async {
    bool available = await _speech.initialize(
      onStatus: (val) {
        if (val == 'notListening' && _isListening) {
          _startListening();
        }
      },
      onError: (val) => debugPrint('onError: $val'),
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
      _speech.listen(
        onResult: (val) => setState(() {
          _text = val.recognizedWords;
        }),
        localeId: 'zh-TW',
        listenFor: const Duration(seconds: 100),
        // ignore: deprecated_member_use
        partialResults: true,
        // ignore: deprecated_member_use
        listenMode: stt.ListenMode.dictation,
      );
    }
  }

  void _stopListening() {
    setState(() {
      _isListening = false;
    });
    _speech.stop();
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

  Future<void> _speak(String text) async {
    await _flutterTts.setLanguage("zh-TW");
    await _flutterTts.setPitch(1.0);
    await _flutterTts.speak(text);
  }

  void _sendToOpenAI(String text) async {
    String prompt =
        "$text\n請自然的跟我對答聊天";

    try {
      final response = await OpenAI.instance.chat.create(
        model: "gpt-4o",
        messages: [
          OpenAIChatCompletionChoiceMessageModel(
            content: [
              OpenAIChatCompletionChoiceMessageContentItemModel.text(prompt),
            ],
            role: OpenAIChatMessageRole.user,
          ),
        ],
        maxTokens: 1500,
      );

      final message = response.choices.first.message.content?.first.text;
      if (message != null) {
        _addMessage(message.trim(), isUserMessage: false);
        await _speak(message.trim());
        _playAnimation(); // Play animation when AI responds
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint("OpenAI 請求失敗: $e");
      }
    }
  }

  void _playAnimation() {
    setState(() {
      _riveController.isActive = true;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _flutterTts.stop();
    super.dispose();
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(Icons.psychology_rounded, size: 30, color: Color(0xFF545454)),
          SizedBox(width: 4),
          Image.asset('assets/images/MultiMedia3.png', height: 135, width: 135),
        ],
      ),
      automaticallyImplyLeading: false,
      backgroundColor: Color(0xFFDECFE2),
      elevation: 0,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.smart_toy_outlined, color: Color(0xFF545454)),
          onPressed: () async {
            final joke = await JokeApiService.getJoke(1);
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0))),
                  content: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Image.asset('assets/images/logo.png', width: 50.0, height: 50.0),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(height: 60),
                          Text(
                            joke.setup,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            joke.punchline,
                            style: TextStyle(fontSize: 16),
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
      decoration: BoxDecoration(
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
                controllers: [_riveController],
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
                  glowColor: Color.fromARGB(255, 255, 255, 255),
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