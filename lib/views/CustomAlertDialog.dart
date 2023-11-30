import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('Sin wifi'),
        content: const Text('Por favor conectese a wifi'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      );

      }

    static void showAlertDialog(BuildContext context){
      showDialog(
      context: context,
      builder: (BuildContext context) {
        return const CustomAlertDialog();
      },
    );
    }
}