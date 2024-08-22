import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class DetailsPage extends StatelessWidget {
  DetailsPage(this.gif, {super.key});

  Map<String, dynamic> gif;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          gif["title"],
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [IconButton(onPressed: () {
          Share.share("oi");
        },
            icon: Icon(Icons.share))],
      ),
      body: Container(
        width: double.maxFinite,
        child: Image.network(
          gif["images"]["original"]["url"],
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
