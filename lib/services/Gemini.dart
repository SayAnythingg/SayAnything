import 'dart:io';
import 'package:google_generative_ai/google_generative_ai.dart';

void main() async {

  // Access your API key as an environment variable (see "Set up your API key" above)
  final apiKey = Platform.environment['AIzaSyCu_nh_v-8fJn_f6UtoKtkVdMXaFK9iVdQ'];
  if (apiKey == null) {
    print('No \$API_KEY environment variable');
    exit(1);
  }

  // The Gemini 1.5 models are versatile and work with most use cases
  GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
}

// safetySettings is a list of SafetySetting objects that define the safety settings for the model
final safetySettings = [
  SafetySetting(HarmCategory.harassment, HarmBlockThreshold.high),
  SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.high),
];