import 'package:SayAnything/screens/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ChatSearch extends SearchDelegate<String> {
  final List<String> chatRooms;

  ChatSearch(this.chatRooms);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? chatRooms
        : chatRooms.where((c) => c.toLowerCase().startsWith(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index]),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChatPage(chatRoomName: suggestions[index])),
            );
          },
        );
      },
    );
  }
}

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
    // Add more chat rooms here
  ];

  int unreadMessagesCount = 1;

  void incrementUnreadMessages() {
    setState(() {
      unreadMessagesCount++;
      if (unreadMessagesCount > 10) {
        unreadMessagesCount = 1;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    simulateNewMessages();
  }

  void simulateNewMessages() async {
    for (int i = 0; i < 10; i++) {
      await Future.delayed(Duration(seconds: 2));
      incrementUnreadMessages();
    }
  }

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
                            child: Stack(
                              children: [
                                ListTile(
                                  leading: Icon(Icons.person),
                                  title: Text(chatRooms[index]),
                                  subtitle: Text(
                                    lastMessage,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  trailing: Text(lastMessageTime),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ChatPage(chatRoomName: chatRooms[index])),
                                    );
                                  },
                                ),
                                Positioned(
                                  left: 10, 
                                  top: 10,
                                  child: AnimatedSwitcher(
                                    duration: Duration(milliseconds: 500),
                                    transitionBuilder: (Widget child, Animation<double> animation) {
                                      return ScaleTransition(child: child, scale: animation);
                                    },
                                    child: Container(
                                      key: ValueKey<int>(unreadMessagesCount),
                                      padding: EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      constraints: BoxConstraints(
                                        minWidth: 14,
                                        minHeight: 14,
                                      ),
                                      child: Text(
                                        '$unreadMessagesCount',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 8,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      actions: <Widget>[
                        IconSlideAction(
                          caption: '置頂',
                          color: Colors.blue,
                          icon: Icons.star,
                          onTap: () {
                            setState(() {
                              chatRooms.insert(0, chatRooms.removeAt(index));
                            });
                          },
                        ),
                      ],
                      secondaryActions: <Widget>[
                        IconSlideAction(
                          caption: '刪除',
                          color: Colors.red,
                          icon: Icons.delete,
                          onTap: () {
                            setState(() {
                              chatRooms.removeAt(index);
                            });
                          },
                        ),
                      ],
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