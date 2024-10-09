import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Text('CategoriesScreen',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
