import 'package:flutter/material.dart';

class ImageDialog extends StatelessWidget {
  final String? path;
  const ImageDialog({this.path, super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Image.asset('assets/events_resources/images/$path', width: 500, height: 500, fit: BoxFit.fill,),
    );
  }
}