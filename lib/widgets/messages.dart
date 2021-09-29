import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Messages extends StatelessWidget {
  Messages({Key? key}) : super(key: key);
  final messageCollectionId = dotenv.get('FIRESTORE_COLLECTION_ID');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('caints/$messageCollectionId/messages').orderBy('createdAt').snapshots(),
      builder: (ctx, AsyncSnapshot<QuerySnapshot> caintsSnapshot) {
        if (caintsSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final caints = caintsSnapshot.data!.docs;
        return ListView.builder(
          reverse: true,
          itemCount: caints.length,
          itemBuilder: (ctx, index) => Text(caints[index]['text']),
        );
      },
    );
  }
}
