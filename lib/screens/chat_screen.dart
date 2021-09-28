import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/messages.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final messageCollectionId = dotenv.get('FIRESTORE_COLLECTION_ID');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Ag caint i nGleann Comhann'),
        actions: [
          DropdownButton(
            underline: Container(
              height: 0,
              color: Theme.of(context).appBarTheme.backgroundColor,
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
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('caints/$messageCollectionId/messages')
              .add({'text': 'Hello there from your floating action button.'});
        },
      ),
    );
  }
}
