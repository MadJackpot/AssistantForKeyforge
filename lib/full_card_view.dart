import 'package:flutter/material.dart';

class FullCardView extends StatelessWidget {
  final String imageUrl;

  FullCardView(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryVariant,
      body: Hero(
        tag: imageUrl,
        child: Image.network(
          imageUrl,
          fit: BoxFit.contain,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
