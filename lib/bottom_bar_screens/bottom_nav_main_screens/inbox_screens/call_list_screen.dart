import 'package:flutter/material.dart';

class CallListScreen extends StatelessWidget {
  const CallListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (context, index) {
        return CallTile(
          name: 'Ragavarshini',
          time: '5:45 PM',
          date: '24 Oct',
        );
      },
    );
  }
}

class CallTile extends StatelessWidget {
  final String name;
  final String time;
  final String date;

  const CallTile({
    Key? key,
    required this.name,
    required this.time,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Profile Image
          Container(
            width: 50,
            height: 50,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.grey.shade200,
                width: 1,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.network(
                'https://placeholder.com/150',
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Name and Time
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$date, $time',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // Call Actions
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.call,
                  color: Colors.red.shade400,
                  size: 22,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.videocam,
                  color: Colors.red.shade400,
                  size: 22,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Example of how to display missed calls
class CallModel {
  final String name;
  final String time;
  final String date;
  final bool isMissed;

  CallModel({
    required this.name,
    required this.time,
    required this.date,
    this.isMissed = false,
  });
}

class CallListWithStatus extends StatelessWidget {
  final List<CallModel> calls = [
    CallModel(name: 'Ragavarshini', time: '5:45 PM', date: '24 Oct'),
    CallModel(
        name: 'Ragavarshini', time: '3:30 PM', date: '24 Oct', isMissed: true),
    CallModel(name: 'Ragavarshini', time: '2:15 PM', date: '24 Oct'),
    CallModel(name: 'Ragavarshini', time: '11:20 AM', date: '24 Oct'),
  ];

  CallListWithStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: calls.length,
      itemBuilder: (context, index) {
        final call = calls[index];
        return CallTileWithStatus(
          name: call.name,
          time: call.time,
          date: call.date,
          isMissed: call.isMissed,
        );
      },
    );
  }
}

class CallTileWithStatus extends StatelessWidget {
  final String name;
  final String time;
  final String date;
  final bool isMissed;

  const CallTileWithStatus({
    Key? key,
    required this.name,
    required this.time,
    required this.date,
    this.isMissed = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Profile Image
          Container(
            width: 50,
            height: 50,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.grey.shade200,
                width: 1,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.network(
                'https://placeholder.com/150',
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Name and Time
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: isMissed ? Colors.red : Colors.black,
                      ),
                    ),
                    if (isMissed) ...[
                      const SizedBox(width: 4),
                      Icon(
                        Icons.call_missed,
                        size: 16,
                        color: Colors.red,
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '$date, $time',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // Call Actions
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.call,
                  color: Colors.red.shade400,
                  size: 22,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.videocam,
                  color: Colors.red.shade400,
                  size: 22,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
