import 'package:flutter/material.dart';

class ErrorHandling extends StatelessWidget {
  final String message;
  final String image;

  ErrorHandling(this.message, this.image);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Spacer(),
          Image(
            image: AssetImage(image),
            width: 200,
          ),
          Text(message),
          Spacer()
        ],
      ),
    );
  }
}
