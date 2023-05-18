import 'package:flutter/material.dart';
import 'package:santehaggi/utilities/dialogs/generic_dialog.dart';

Future<void> showPasswordResetSentDialog(BuildContext context) {
  return showGenericDialog<void>(
    context: context,
    title: 'Password Reset',
    content: 'A password reset email has been sent to your email address.',
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
