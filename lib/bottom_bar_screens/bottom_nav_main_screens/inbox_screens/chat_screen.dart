import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/inbox_screens/screens/coversation_screen.dart';
import 'package:matrimony/models/interest_model.dart';

class ChatScreen extends StatefulWidget {
  final SentModel sent;

  const ChatScreen({super.key, required this.sent});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(widget.sent),
      body: const Column(
        children: [
          Expanded(
            child: ConversationScreen(),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(SentModel sent) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.red, size: 20),
        onPressed: () => Navigator.pop(context),
      ),
      titleSpacing: 0,
      title: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: sent.images != null && sent.images!.isNotEmpty
                ? MemoryImage(
                    base64Decode(sent.images![0]),
                  )
                : const AssetImage('assets/image/emptyProfile.png')
                    as ImageProvider,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    sent.name ?? '',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(Icons.verified, size: 16, color: Colors.blue[400]),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                'Last seen just now',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(
            FontAwesomeIcons.phone,
            color: Color(0xFFD6151A),
            size: 20,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(
            FontAwesomeIcons.video,
            color: Color(0xFFD6151A),
            size: 20,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.more_vert, color: Color(0xFFD6151A)),
          onPressed: () {},
        ),
      ],
    );
  }
}
