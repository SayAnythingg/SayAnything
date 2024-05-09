// ChatList.dart
import 'package:flutter/material.dart';
import 'package:SayAnything/function/ChatSearch.dart';
import 'package:SayAnything/function/ChatListItem.dart';


class ChatList extends StatefulWidget {
  ChatList({Key? key}) : super(key: key);

  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  List<String> chatRooms = [
    'Chris',
    'Anderson',
    'Cosmo ',
    'Ivy ',
    '鍾弘浩',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.zero,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFDECFE2), Color(0xFF7EC4CF)],
            ),
          ),
          child: Column(
            children: [
              AppBar(
                title: Text('Chat'),
                backgroundColor: Colors.transparent, 
                elevation: 0, 
                automaticallyImplyLeading: false,
                actions: [
                  IconButton(
                    icon: Icon(Icons.search),
                    color: Colors.black,
                    onPressed: () {
                      showSearch(
                        context: context,
                        delegate: ChatSearch(chatRooms),
                      );
                    },
                  ),
                ],
              ),
              Container(
                height: 50, 
                color: Colors.yellow, 
                child: Center(child: Text('廣告')), 
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(top: 0),
                  itemCount: chatRooms.length,
                  itemBuilder: (context, index) {
                    return ChatListItem(
                      chatRoom: chatRooms[index],
                      removeChatRoom: () {
                        setState(() {
                          chatRooms.removeAt(index);
                        });
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}