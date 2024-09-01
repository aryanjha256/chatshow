import 'package:chatshow/components/my_button.dart';
import 'package:chatshow/components/my_textfield.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String? userName;
  ProfilePage({super.key, this.userName});

  final TextEditingController nameController = TextEditingController();

  initstate() {
    nameController.text = userName!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          MyTextfield(
            hintText: "Your Name",
            controller: nameController,
          ),
          const SizedBox(height: 20),
          MyButton(text: "Update", onTap: () {}),
        ],
      ),
    );
  }
}
