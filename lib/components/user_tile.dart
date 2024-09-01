import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String displayName;
  final String email;

  final void Function()? onTap;

  const UserTile(
      {super.key, required this.displayName, required this.email, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Text(
                email[0].toUpperCase(),
                style: TextStyle(
                  color:
                      Colors.primaries[email.length % Colors.primaries.length],
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              displayName,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
