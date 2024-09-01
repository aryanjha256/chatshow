import 'package:chatshow/components/chat_bubble.dart';
import 'package:chatshow/components/my_textfield.dart';
import 'package:chatshow/services/auth/auth_service.dart';
import 'package:chatshow/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String receiverDisplayName;
  final String receiverId;
  const ChatPage(
      {super.key, required this.receiverDisplayName, required this.receiverId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        Future.delayed(
          const Duration(milliseconds: 500),
          () => _scrollToBottom(),
        );
      }
    });

    Future.delayed(
      const Duration(milliseconds: 500),
      () => _scrollToBottom(),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

  final ScrollController _scrollController = ScrollController();
  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  void sendMessage() async {
    if (_messageController.text.isEmpty) {
      return;
    }
    final message = _messageController.text;
    await _chatService.sendMessage(
      widget.receiverId,
      message,
    );
    _messageController.clear();

    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverDisplayName),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildChatList(),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildChatList() {
    String currentUserId = _authService.currentUser!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(currentUserId, widget.receiverId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('An error occurred'),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: ListView(
            controller: _scrollController,
            children: snapshot.data!.docs
                .map<Widget>(
                    (chatData) => _buildChatListItems(chatData, context))
                .toList(),
          ),
        );
      },
    );
  }

  Widget _buildChatListItems(DocumentSnapshot chatData, BuildContext context) {
    Map<String, dynamic> chat = chatData.data() as Map<String, dynamic>;
    bool isSender = chat["senderId"] == _authService.currentUser!.uid;
    var alignment = isSender ? Alignment.centerRight : Alignment.centerLeft;
    return Container(
      alignment: alignment,
      child: ChatBubble(message: chat["message"], isCurrentUser: isSender),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        children: [
          Expanded(
            child: MyTextfield(
              focusNode: _focusNode,
              controller: _messageController,
              hintText: 'Type a message...',
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            margin: const EdgeInsets.only(right: 20),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_upward,
                color: Colors.white,
              ),
              onPressed: sendMessage,
            ),
          ),
        ],
      ),
    );
  }
}
