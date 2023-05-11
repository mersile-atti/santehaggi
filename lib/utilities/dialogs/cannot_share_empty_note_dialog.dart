import 'package:flutter/material.dart';

import 'generic_dialog.dart';

Future<void> showCannotShareEmptyNoteDialiog(BuildContext context) async {
  return showGenericDialog<void>(
      context: context,
      title: 'Sharing',
      content: 'You cannot share an empty note',
      optionsBuilder: () => {
            'OK': null,
          });
}
