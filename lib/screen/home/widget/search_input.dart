import 'package:flutter/material.dart';
class Test extends StatelessWidget {
final String imageUrl;

  Test({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          
      ),
      body: const Center(
        child: Text('Show image'),
      ),
    );
  }
}