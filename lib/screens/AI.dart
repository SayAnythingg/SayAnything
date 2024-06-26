import 'package:flutter/material.dart';
import 'package:SayAnything/services/API_services.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:translator/translator.dart';
import 'package:speech_to_text/speech_to_text.dart';

final JokeApiService = JokeApi();

class multimedia extends StatefulWidget {
  @override
  _AIState createState() => _AIState();
}

class _AIState extends State<multimedia> {
  String aiResponse = '';
  String userMessage = '';
  final TextEditingController _controller = TextEditingController();
  final FlutterTts flutterTts = FlutterTts();
  final translator = GoogleTranslator();
  final SpeechToText speech = SpeechToText();

  Future<void> startListening() async {
    bool available = await speech.initialize(
      onStatus: (status) => print('$status'),
      onError: (error) => print('$error'),
    );
    if (available) {
      speech.listen(
        onResult: (result) {
          setState(() {
            userMessage = result.recognizedWords;
          });
          if (result.finalResult) {
            getAIResponse();
          }
        },
      );
    } else {
      print("The user has denied the use of speech recognition.");
    }
  }

  Future<void> getAIResponse() async {
    final apiKey = 'AIzaSyCu_nh_v-8fJn_f6UtoKtkVdMXaFK9iVdQ';
    final model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: apiKey,
        generationConfig: GenerationConfig(maxOutputTokens: 150));
    final chat = model.startChat(history: [
      Content.text('Hello, I am a student'),
      Content.model([TextPart('')])
    ]);
    var content = Content.text(userMessage);
    var response = await chat.sendMessage(content);
    setState(() {
      aiResponse = response.text!;
    });
    _controller.clear();

    await flutterTts.speak(aiResponse);
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
            Image.asset('assets/images/MultiMedia3.png',
                height: 135, width: 135),
          ],
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFDECFE2),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.smart_toy_outlined,
              color: Color(0xFF545454),
            ),
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
                          child: Image.asset('assets/images/logo.png',
                              width: 50.0, height: 50.0),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(height: 60),
                            Text(
                              joke.setup,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
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
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFDECFE2), Color(0xFF7EC4CF)],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.grey[400]!, Colors.grey[500]!],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: SingleChildScrollView(
                            child: Text(aiResponse),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.grey[400]!, Colors.grey[500]!],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: TextField(
                          controller: _controller,
                          onChanged: (value) {
                            setState(() {
                              userMessage = value;
                            });
                          },
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.fromLTRB(
                                20.0, 10.0, 10.0, 10.0),
                            hintText: 'Type message here...',
                            hintStyle: const TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: const Color(0xFF545454),
                            prefixIcon: const Icon(Icons.message,
                                color: Color.fromARGB(249, 234, 242, 247)),
                            suffixIcon: userMessage.isEmpty
                                ? GestureDetector(
                                    onLongPressStart: (details) =>
                                        startListening(),
                                    onLongPressEnd: (details) => speech.stop(),
                                    child: Icon(Icons.mic, color: Colors.white),
                                  )
                                : IconButton(
                                    icon: Icon(Icons.send, color: Colors.white),
                                    onPressed: getAIResponse,
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 140.0),
        child: SpeedDial(
          backgroundColor: const Color(0xFF7EC4CF),
          animatedIcon: AnimatedIcons.menu_close,
          children: [
            SpeedDialChild(
              child: Icon(Icons.person),
              label: 'AI girlfriend',
              onTap: () {
                setState(() {
                  aiResponse = 'You selected AI girlfriend';
                });
              },
            ),
            SpeedDialChild(
              child: const Icon(Icons.person),
              label: 'AI boyfriend',
              onTap: () {
                setState(() {
                  aiResponse = 'You selected AI boyfriend';
                });
              },
            ),
            SpeedDialChild(
              child: const Icon(Icons.school),
              label: 'English teacher',
              onTap: () async {
                flutterTts.setLanguage('en-US');
                if (userMessage.endsWith('給我英文')) {
                  String messageToTranslate = userMessage
                      .substring(0, userMessage.length - '給我英文'.length)
                      .trim();
                  final translation =
                      await translator.translate(messageToTranslate, to: 'en');
                  await flutterTts.speak(translation.text);
                  setState(() {
                    aiResponse =
                        'You selected English teacher. Translation: ${translation.text}';
                  });
                } else {
                  await flutterTts.speak(
                      'This is English mode, mainly for English practice and guidance, you can also tell me Chinese, I can translate it to English for you');
                  setState(() {
                    aiResponse =
                        'You selected English teacher. Translation: $aiResponse';
                  });
                }
              },
            ),
            SpeedDialChild(
              child: const Icon(Icons.school),
              label: 'Chinese teacher',
              onTap: () async {
                flutterTts.setLanguage('zh-CN');
                if (userMessage.endsWith('請幫我翻譯成中文')) {
                  String messageToTranslate = userMessage
                      .substring(0, userMessage.length - '請幫我翻譯成中文'.length)
                      .trim();
                  final translation = await translator
                      .translate(messageToTranslate, to: 'zh-TW');
                  await flutterTts.speak(translation.text);
                  setState(() {
                    aiResponse =
                        'You selected Chinese teacher. Translation: ${translation.text}';
                  });
                } else {
                  await flutterTts
                      .speak('這是中文模式, 主要給予中文的練習和指導, 你也可以告訴我英文,我可以翻譯給你中文');
                  setState(() {
                    aiResponse =
                        'You selected Chinese teacher. Translation: $aiResponse';
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
