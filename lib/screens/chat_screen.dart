import 'package:flutter/material.dart';

class  ChatScreen extends StatelessWidget {
  const  ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        bottomOpacity: 0.5,
        title: Text('Ag caint i nGleann Comhann'),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (ctx, index) => Container(
          padding: EdgeInsets.all(8),
          child: Text('This should work...'),
        ),
      ),
    );
  }
}
