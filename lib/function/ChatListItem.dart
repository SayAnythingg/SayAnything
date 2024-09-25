import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:say_anything/screens/chat_page.dart';

class ChatListItem extends StatelessWidget {
  final String chatRoom;
  final Function removeChatRoom;
  final Function pinChatRoom;
  final bool isPinned;

  const ChatListItem(
      {super.key,
      required this.chatRoom,
      required this.removeChatRoom,
      required this.pinChatRoom,
      this.isPinned = false});

  @override
  Widget build(BuildContext context) {
    String lastMessage = "This is the last message from this chat room";
    String lastMessageTime = "10:30 PM";

    return Slidable(
      key: ValueKey(chatRoom),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(onDismissed: () => removeChatRoom()),
        children: [
          SlidableAction(
            onPressed: (context) => removeChatRoom(),
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) => pinChatRoom(),
            backgroundColor: const Color(0xFF7BC043),
            foregroundColor: Colors.white,
            icon: Icons.archive,
            label: 'Archive',
          ),
        ],
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Stack(
          children: [
            ListTile(
              leading: const Icon(Icons.person),
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
            if (isPinned)
              const Positioned(
                top: 5,
                left: 5,
                child: Icon(Icons.star, color: Colors.yellow),
              ),
          ],
        ),
      ),
    );
  }
}
