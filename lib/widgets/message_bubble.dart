import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;

  MessageBubble(this.message, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(12),
          ),
          width: 200,
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          margin: EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 8,
          ),
          child: Text(
            message,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
      ],
    );
  }
}
