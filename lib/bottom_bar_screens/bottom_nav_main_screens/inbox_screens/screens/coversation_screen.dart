import 'package:flutter/material.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({super.key});

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  final List<Map<String, dynamic>> messages = [
    {
      "message_id": 1,
      "send_user_id": 101,
      "receive_user_id": 102,
      "content": "Hello, how are you?",
      "message_type": "text",
      "timestamp": "10:30 AM",
      "status": "seen",
      "is_deleted": false,
      "is_edited": false,
      "reply_to": null,
      "isSender": true,
      "userImage": null,
    },
    {
      "message_id": 2,
      "send_user_id": 102,
      "receive_user_id": 101,
      "content":
          "I'm good, thanks! What about you? djqwjd ajsawdjaasdakd asjdawdkaw;lasdajd",
      "message_type": "text",
      "timestamp": "10:32 AM",
      "status": "delivered",
      "is_deleted": false,
      "is_edited": false,
      "reply_to": 1,
      "isSender": false,
      "userImage": "assets/image/emptyProfile.png",
    },
    {
      "message_id": 3,
      "send_user_id": 101,
      "receive_user_id": 102,
      "content": "I'm doing great! Thanks for asking.",
      "message_type": "text",
      "timestamp": "10:35 AM",
      "status": "sent",
      "is_deleted": false,
      "is_edited": false,
      "reply_to": null,
      "isSender": true,
      "userImage": null,
    },
  ];

  final TextEditingController _messageController = TextEditingController();

  Widget _buildMessage(Map<String, dynamic> message) {
    final bool isSender = message["isSender"];
    final String status = message["status"];
    final String timestamp = message["timestamp"];
    final String content = message["content"];
    final String? userImage = message["userImage"];

    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        mainAxisAlignment:
            isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment:
                  isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    left: isSender ? 70 : 0,
                    right: isSender ? 0 : 70,
                  ),
                  padding: const EdgeInsets.only(
                      left: 12, right: 12, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    color: isSender
                        ? const Color(0xFF383838)
                        : const Color(0xFFD6151A),
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(12),
                      topRight: const Radius.circular(12),
                      bottomLeft: Radius.circular(isSender ? 12 : 0),
                      bottomRight: Radius.circular(isSender ? 0 : 12),
                    ),
                  ),
                  child: Text(
                    content,
                    style: TextStyle(
                      color: isSender ? Colors.white : Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: isSender
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  children: [
                    Text(
                      timestamp,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    if (isSender) ...[
                      const SizedBox(width: 4),
                      Icon(
                        status == "pending"
                            ? Icons.access_time
                            : status == "delivered"
                                ? Icons.check
                                : Icons.done_all,
                        size: 16,
                        color: status == "seen" ? Colors.blue : Colors.grey,
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      messages.add({
        "message_id": messages.length + 1,
        "send_user_id": 101,
        "receive_user_id": 102,
        "content": _messageController.text.trim(),
        "message_type": "text",
        "timestamp": "Now",
        "status": "sent",
        "is_deleted": false,
        "is_edited": false,
        "reply_to": null,
        "isSender": true,
        "userImage": null,
      });
    });

    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            filterQuality: FilterQuality.high,
            colorFilter: ColorFilter.srgbToLinearGamma(),
            image: AssetImage('assets/image/bg.png') as ImageProvider<Object>,
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _buildMessage(message),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              height: 50,
              margin: const EdgeInsets.only(left: 20, bottom: 8, right: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFD6151A))),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(0),
                        hintText: "Type a message",
                        hintStyle: const TextStyle(color: Color(0xFFD6151A)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        // filled: true,
                        // fillColor: Colors.white,
                      ),
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        _sendMessage();
                      },
                      child: const Icon(Icons.send, color: Color(0xFFD6151A))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
