import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const UserTile({super.key, required this.text, this.onTap});

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
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Text(
                text[0].toUpperCase(),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              text,
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
