import 'package:flutter/material.dart';

Future showSuccessAlert(BuildContext context, successMsg) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          children: [
            Image.asset(
              'assets/image/success.png',
              width: 53,
              height: 53,
              fit: BoxFit.contain,
            ),
            const Text(
              'Success!',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
        content: Text(
          successMsg,
          style: TextStyle(fontSize: 16),
        ),
        backgroundColor: Color.fromARGB(255, 252, 239, 244),
        actions: [
          Center(
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Pawsome!',
                style: TextStyle(
                  color: Color.fromARGB(204, 255, 3, 93),
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}

Future showErrorAlert(BuildContext context, errorMsg) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Uh oh!'),
        content: Text(errorMsg),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
