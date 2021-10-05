import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../widgets/messages.dart';
import '../widgets/new_message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _requested = false;
  bool _fetching = false;
  late NotificationSettings _settings;

  Future<void> getMessagingPerms() async {
    setState(() {
      _fetching = true;
    });
    final fbm = FirebaseMessaging.instance;
    NotificationSettings settings = await fbm.requestPermission();
    setState(() {
      _requested = true;
      _fetching = false;
      _settings = settings;
    });

    @override
    void initState() {
      getMessagingPerms();
      super.initState();
    }

    @override
    Widget build(BuildContext context) {
      if (!_requested) {
        getMessagingPerms();
      }
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Ag caint i nGleann Comhann'),
          actions: [
            DropdownButton(
              underline: Container(
                height: 0,
                color: Theme
                    .of(context)
                    .appBarTheme
                    .backgroundColor,
              ),
              icon: Icon(
                Icons.more_vert,
              ),
              items: [
                DropdownMenuItem(
                  value: 'logout',
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.exit_to_app,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text('Logout'),
                      ],
                    ),
                  ),
                ), //DropdownMenuItem
              ],
              onChanged: (itemIdentifier) {
                if (itemIdentifier == 'logout') {
                  FirebaseAuth.instance.signOut();
                }
              },
            ), //DropdownButton
          ],
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Messages(),
            ),
            NewMessage(),
          ],
        ),
      );
    }
  }
}

