import 'package:chatshow/components/user_tile.dart';
import 'package:chatshow/pages/chat_page.dart';
import 'package:chatshow/services/auth/auth_service.dart';
import 'package:chatshow/components/my_drawer.dart';
import 'package:chatshow/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ChatService chatService = ChatService();
  final AuthService authService = AuthService();

  void logout() {
    final authService = AuthService();
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Show'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: logout,
          ),
        ],
      ),
      drawer: const MyDrawer(),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: chatService.getUserStreams(),
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

        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => _buildUserListItems(userData, context))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserListItems(
      Map<String, dynamic> userData, BuildContext context) {
    if (userData["email"] != authService.currentUser!.email) {
      return UserTile(
          displayName: userData["displayName"],
          email: userData["email"],
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                  receiverDisplayName: userData["displayName"],
                  receiverId: userData["uid"],
                ),
              ),
            );
          });
    } else {
      return const SizedBox.shrink();
    }
  }
}
