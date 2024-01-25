import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/features/account/services/account_services.dart';
import 'package:flutter_amazon_clone/features/account/widgets/account_button.dart';

class AdminTopButtons extends StatelessWidget {
  const AdminTopButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              AccountButton(
                text: 'Log Out',
                onTap: () {
                  _showConfirmDialog(context);
                },
              ),
              AccountButton(
                text: 'Analytics',
                onTap: () {},
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              AccountButton(
                text: 'Bank Detais',
                onTap: () {},
              ),
              AccountButton(
                text: 'Contact Amazon',
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _showConfirmDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: const Text('Do you want to log out?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                AccountServices().logOut(context);
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}
