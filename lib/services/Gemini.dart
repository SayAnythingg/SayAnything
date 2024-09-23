import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

Future<void> main() async {
  // Access your API key as an environment variable (see "Set up your API key" above)
  final apiKey =
      Platform.environment['AIzaSyCu_nh_v-8fJn_f6UtoKtkVdMXaFK9iVdQ'];
  if (apiKey == null) {
    if (kDebugMode) {
      print('No \$API_KEY environment variable');
    }
    exit(1);
  }
  // The Gemini 1.5 models are versatile and work with multi-turn conversations (like chat)
  final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: apiKey,
      generationConfig: GenerationConfig(maxOutputTokens: 100));
  // Initialize the chat
  final chat = model.startChat(history: [
    Content.text(''),
    Content.model([TextPart('')])
  ]);
  var content = Content.text('');
  var response = await chat.sendMessage(content);
  if (kDebugMode) {
    print(response.text);
  }
}
