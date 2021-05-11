import 'package:flutter/material.dart';
import 'package:myceleb/model/model.dart';

class MyAppBar extends StatelessWidget {
  final int balance;

  const MyAppBar({Key? key, required this.balance}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'My Account',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            Spacer(),
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
        // const SizedBox(height: 10),
        Text(
          'Balance: Ugx ${numberCommaFormatter.format(balance)}',
          style: TextStyle(fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
