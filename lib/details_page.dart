import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
 final String title;
 final String imageUrl;
 final String description;


 DetailsPage(this.title, this.imageUrl, this.description);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
              Text(title),
              Image.asset(imageUrl),
              Text(description),
        ],
      ),
    );
  }
}
