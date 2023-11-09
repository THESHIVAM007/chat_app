import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('chat').orderBy('createdAt',descending: true).snapshots(),
        builder: (ctx, chatSnapshot) {
          if (chatSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!chatSnapshot.hasData || chatSnapshot.data!.docs.isEmpty) {
            const Center(
              child: Text('No messages found'),
            );
          }
          if (chatSnapshot.hasError) {
            const Center(
              child: Text('Something went Wrong'),
            );
          }
          final loadedMessages = chatSnapshot.data!.docs;
          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 40,left: 13,right: 13),
            reverse: true,
            itemCount: loadedMessages.length,
            itemBuilder: (ctx, index) =>
                Text(loadedMessages[index].data()['text']),
          );
        });
  }
}
