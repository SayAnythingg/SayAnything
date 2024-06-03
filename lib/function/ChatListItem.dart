import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:SayAnything/screens/chat_page.dart';

class ChatListItem extends StatelessWidget {
  final String chatRoom;
  final Function removeChatRoom;

  ChatListItem({required this.chatRoom, required this.removeChatRoom});

  @override
  Widget build(BuildContext context) {
    String lastMessage = "This is the last message from this chat room";
    String lastMessageTime = "10:30 PM";

    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: GestureDetector(
        child: Container(
          margin: const EdgeInsets.all(8.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            color: Colors.white,
            child: ListTile(
              leading: Icon(Icons.person),
              title: Text(chatRoom),
              subtitle: Text(
                lastMessage,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Text(lastMessageTime),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChatPage(chatRoomName: chatRoom)),
                );
              },
            ),
          ),
        ),
      ),
      actions: <Widget>[
        IconSlideAction(
          caption: '置頂',
          color: Colors.blue,
          icon: Icons.star,
          onTap: () => removeChatRoom(),
        ),
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: '刪除',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => removeChatRoom(),
        ),
      ],
    );
  }
}
