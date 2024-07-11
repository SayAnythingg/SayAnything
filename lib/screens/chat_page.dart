import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:intl/date_symbol_data_local.dart';
// ignore: depend_on_referenced_packages
import 'package:mime/mime.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:uuid/uuid.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(
        home: ChatPage(
          chatRoomName: '',
        ),
      );
}

class ChatPage extends StatefulWidget {
  final String chatRoomName;

  const ChatPage({super.key, required this.chatRoomName});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<types.Message> _messages = [];
  final _user = const types.User(
    id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
  );

  @override
  void initState() {
    super.initState();
    _loadMessages();
    _addFakeMessages(); // Add this line
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleAttachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => Container(
        color: const Color(0xff7ec4cf),
        child: SafeArea(
          child: SizedBox(
            height: 144,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _handleImageSelection();
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.photo),
                      Text('Photo'),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _handleFileSelection();
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.file_upload),
                      Text('File'),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.cancel),
                      Text('Cancel'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {
      final message = types.FileMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        mimeType: lookupMimeType(result.files.single.path!),
        name: result.files.single.name,
        size: result.files.single.size,
        uri: result.files.single.path!,
      );

      _addMessage(message);
    }
  }

  void _handleImageSelection() async {
    try {
      final result = await ImagePicker().pickImage(
        imageQuality: 70,
        maxWidth: 1440,
        source: ImageSource.gallery,
      );

      if (result != null) {
        final bytes = await result.readAsBytes();
        final image = await decodeImageFromList(bytes);

        final message = types.ImageMessage(
          author: _user,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          height: image.height.toDouble(),
          id: const Uuid().v4(),
          name: result.name,
          size: bytes.length,
          uri: result.path,
          width: image.width.toDouble(),
        );

        _addMessage(message);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }

  void _handleMessageTap(BuildContext _, types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        try {
          final index =
              _messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
              (_messages[index] as types.FileMessage).copyWith(
            isLoading: true,
          );

          setState(() {
            _messages[index] = updatedMessage;
          });

          final client = http.Client();
          final request = await client.get(Uri.parse(message.uri));
          final bytes = request.bodyBytes;
          final documentsDir = (await getApplicationDocumentsDirectory()).path;
          localPath = '$documentsDir/${message.name}';

          if (!File(localPath).existsSync()) {
            final file = File(localPath);
            await file.writeAsBytes(bytes);
          }
        } finally {
          final index =
              _messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
              (_messages[index] as types.FileMessage).copyWith(
            isLoading: null,
          );

          setState(() {
            _messages[index] = updatedMessage;
          });
        }
      }

      await OpenFilex.open(localPath);
    }
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = (_messages[index] as types.TextMessage).copyWith(
      previewData: previewData,
    );

    setState(() {
      _messages[index] = updatedMessage;
    });
  }

  int _conversationStep = 0;

void _handleSendPressed(types.PartialText message) {
  final textMessage = types.TextMessage(
    author: _user,
    createdAt: DateTime.now().millisecondsSinceEpoch,
    id: const Uuid().v4(),
    text: message.text,
  );

  _addMessage(textMessage);

  Future.delayed(const Duration(seconds: 1), () {
    types.TextMessage responseMessage;

    if (_conversationStep == 0) {
      responseMessage = types.TextMessage(
        author: const types.User(id: 'Chris'),
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: "That photo looks beautiful, where is it?",
      );
    } else if (_conversationStep == 1) {
      responseMessage = types.TextMessage(
        author: const types.User(id: 'Chris'),
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: "Hope we can go there for a picnic next time.",
      );
    } else if (_conversationStep == 2) {
      responseMessage = types.TextMessage(
        author: const types.User(id: 'Chris'),
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: "Give me a few minutes to read this document.",
      );
    } else {
      _conversationStep = -1; 
      return;
    }

    _addMessage(responseMessage);
    _conversationStep++;
  });
}

  void _loadMessages() async {
    final response = await rootBundle.loadString('assets/messages.json');
    final messages = (jsonDecode(response) as List)
        .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
        .toList();

    setState(() {
      _messages = messages;
    });
  }

  void _addFakeMessages() {
    final fakeMessages = [
      types.TextMessage(
        author: const types.User(id: 'user-123'),
        createdAt: DateTime.now().subtract(const Duration(minutes: 5)).millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: 'Definitely! It\'s great to disconnect and enjoy nature. Also, I\'m really glad we met. You\'re a great friend.',
      ),
      types.TextMessage(
        author: _user,
        createdAt: DateTime.now().subtract(const Duration(minutes: 4)).millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: 'That sounds nice. I\'ve been meaning to get outside more too.',
      ),
      types.TextMessage(
        author: const types.User(id: 'user-123'),
        createdAt: DateTime.now().subtract(const Duration(minutes: 3)).millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: 'Same here! It\'s a beautiful day. Went for a walk in the park.',
      ),
      types.TextMessage(
        author: _user,
        createdAt: DateTime.now().subtract(const Duration(minutes: 2)).millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: 'I\'m doing well, thanks! Enjoying the lovely weather. How about you?',
      ),
      types.TextMessage(
        author: const types.User(id: 'user-123'),
        createdAt: DateTime.now().subtract(const Duration(minutes: 1)).millisecondsSinceEpoch,
        id: const Uuid().v4(),
       text: 'Hey! How have you been?',
      ),
    ];

    setState(() {
      _messages.insertAll(0, fakeMessages);
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF7EC4CF),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: Row(
            children: <Widget>[
              CircleAvatar(
                backgroundImage:
                    NetworkImage('https://via.placeholder.com/150'),
                radius: 20,
              ),
              SizedBox(width: 10),
              Text(
                widget.chatRoomName,
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.phone),
              onPressed: () {},
            ),
          ],
        ),
        body: Chat(
          messages: _messages,
          onAttachmentPressed: _handleAttachmentPressed,
          onMessageTap: _handleMessageTap,
          onPreviewDataFetched: _handlePreviewDataFetched,
          onSendPressed: _handleSendPressed,
          showUserAvatars: true,
          showUserNames: true,
          user: _user,
          theme: const DefaultChatTheme(
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
            inputBackgroundColor: Color(0xFF7EC4CF),
            primaryColor: Color(0xFF7EC4CF),
            seenIcon: Text(
              'read',
              style: TextStyle(
                fontSize: 10.0,
              ),
            ),
          ),
        ),
      );
}