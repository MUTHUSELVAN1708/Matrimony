import 'package:flutter/material.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/inbox_screens/call_list_screen.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/inbox_screens/request_user_list_screen.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/inbox_screens/user_chat_screen.dart';

class Inbox extends StatefulWidget {
  const Inbox({Key? key}) : super(key: key);

  @override
  State<Inbox> createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  int _selectedTabIndex = 0; // Default to Chat
  int _selectedChipIndex = 0; // Default to first chip
  PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true, // Align the title centrally
        title: const Text(
          'Inbox',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          // Mailbox/Chat Toggle
          MailboxChatToggle(
            onTabChanged: (index) {
              setState(() {
                _selectedTabIndex = index;
              });
            },
          ),
          // Conditionally render the screens
          _selectedTabIndex == 1
              ? const Expanded(child: UserChatScreen()) // Chat screen
              : Expanded(
                  child: Column(
                    children: [
                      // Filter chips
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Row(
                          children: [
                            _buildFilterChip('Received', 0),
                            _buildFilterChip('Awaiting Response', 1),
                            _buildFilterChip('Requests', 2),
                            _buildFilterChip('Calls', 3),
                          ],
                        ),
                      ),
                      // PageView content based on selected chip
                      Expanded(
                        child: PageView(
                          controller: _pageController,
                          onPageChanged: (index) {
                            setState(() {
                              _selectedChipIndex = index;
                            });
                          },
                          children: [
                            _buildMessagePage("Received Messages"),
                            _buildMessagePage("Awaiting Response Messages"),
                            RequestUsersList(
                              userImages: [
                                'url1',
                                'url2',
                                'url3',
                                'url4',
                                'url5',
                              ],
                              totalRequests: 7,
                              onAddPhoto: () {
                                // Handle add photo action
                              },
                            ),
                            CallListScreen(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, int index) {
    final isSelected = _selectedChipIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedChipIndex = index;
        });
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        child: Chip(
          label: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
          backgroundColor: isSelected ? Colors.black : Colors.grey.shade200,
        ),
      ),
    );
  }

  Widget _buildMessagePage(String messageType) {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) {
        return _buildMessageTile(messageType);
      },
    );
  }

  Widget _buildMessageTile(String messageType) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundImage: NetworkImage('https://placeholder.com/150'),
        radius: 25,
      ),
      title: Row(
        children: [
          const Text(
            'Ragavarshini',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 4),
          Icon(Icons.verified, size: 16, color: Colors.blue.shade400),
        ],
      ),
      subtitle: Row(
        children: [
          Expanded(
            child: Text(
              'Message type: $messageType',
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          const Text('Read more', style: TextStyle(color: Colors.red)),
        ],
      ),
      trailing: const Text(
        '4:25pm',
        style: TextStyle(color: Colors.grey, fontSize: 12),
      ),
    );
  }
}

class MailboxChatToggle extends StatefulWidget {
  final Function(int)? onTabChanged;

  const MailboxChatToggle({
    Key? key,
    this.onTabChanged,
  }) : super(key: key);

  @override
  State<MailboxChatToggle> createState() => _MailboxChatToggleState();
}

class _MailboxChatToggleState extends State<MailboxChatToggle> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildToggleButton(
              title: 'Mailbox',
              index: 0,
            ),
          ),
          Expanded(
            child: _buildToggleButton(
              title: 'Chat',
              index: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton({
    required String title,
    required int index,
  }) {
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
        widget.onTabChanged?.call(index);
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.all(4),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
