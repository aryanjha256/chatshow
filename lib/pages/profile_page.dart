import 'package:chatshow/components/my_button.dart';
import 'package:chatshow/components/my_textfield.dart';
import 'package:chatshow/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final String? userName;
  const ProfilePage({super.key, this.userName});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthService authService = AuthService();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController =
      TextEditingController(text: AuthService().currentUser!.email);

  void updateProfile(BuildContext context) {
    final name = nameController.text;

    if (name.isEmpty) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            title: Text('Name cannot be empty!'),
          ),
        );
      }
      return;
    }

    authService.updateDisplayName(name);
  }

  @override
  void initState() {
    super.initState();
    _setDisplayName();
  }

  void _setDisplayName() async {
    String name = await authService.getDisplayName();
    nameController.text = name;
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
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
            hintText: "Your Email",
            controller: emailController,
            readOnly: true,
          ),
          const SizedBox(height: 20),
          MyTextfield(
            hintText: "Your Name",
            controller: nameController,
          ),
          const SizedBox(height: 20),
          MyButton(
              text: "Update",
              onTap: () {
                updateProfile(context);
              }),
        ],
      ),
    );
  }
}
