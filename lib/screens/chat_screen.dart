import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final messageCollectionId = dotenv.get('FIRESTORE_COLLECTION_ID');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        bottomOpacity: 0.5,
        title: Text('Ag caint i nGleann Comhann'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('caints/$messageCollectionId/messages')
            .snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!streamSnapshot.hasData) {
            return Center(
              child: Text('You don\'t have any messages yet.'),
            );
          } else {
            final documents = streamSnapshot.data!.docs;
            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (ctx, index) => Container(
                padding: EdgeInsets.all(8),
                child: Text(documents[index]['text']),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('caints/$messageCollectionId/messages').add({
            'text': 'Hello there from your floating action button.'
          });
        },
      ),
    );
  }
}
