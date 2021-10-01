import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final String userName;
  final String userImage;

  MessageBubble(this.message, this.isMe, this.userName, this.userImage,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: isMe
                    ? Colors.grey[500]
                    : Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
                  bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
                ),
              ),
              width: 180,
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              margin: EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 8,
              ),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: Theme.of(context).textTheme.caption,
                  ),
                  Text(
                    message,
                    style: Theme.of(context).textTheme.bodyText2,
                    textAlign: isMe ? TextAlign.end : TextAlign.start,
                  )
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: -5,
          left: isMe? null : 165,
          right: isMe? 165 : null,
          child: CircleAvatar(
            backgroundImage: NetworkImage(userImage),
          ),
        ),
      ],
    );
  }
}
