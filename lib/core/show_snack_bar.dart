import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

void showSnackBar({
  required BuildContext context,
  required ContentType contentType,
  required String title,
  required String message,
}) {
  final snackBar = SnackBar(
    elevation: 0,
    behavior: .floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(title: title, message: message, contentType: contentType),
  );
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}
