import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechService {
  late stt.SpeechToText _speech;
  late FlutterTts _flutterTts;

  SpeechService() {
    _speech = stt.SpeechToText();
    _flutterTts = FlutterTts();
  }

  Future<bool> initializeSpeech(Function(String) onResult,
      stt.SpeechErrorListener? onError, Function(String) onStatus) async {
    return await _speech.initialize(
      onStatus: onStatus,
      onError: onError,
    );
  }

  void startListening(Function(String) onResult) {
    _speech.listen(
      onResult: (val) => onResult(val.recognizedWords),
      localeId: 'zh-TW',
      listenFor: const Duration(seconds: 100),
      // ignore: deprecated_member_use
      partialResults: true,
      // ignore: deprecated_member_use
      listenMode: stt.ListenMode.dictation,
    );
  }

  void stopListening() {
    _speech.stop();
  }

  Future<void> speak(String text) async {
    await _flutterTts.setLanguage("zh-TW");
    await _flutterTts.setPitch(1.0);
    await _flutterTts.speak(text);
  }

  void dispose() {
    _flutterTts.stop();
  }
}
