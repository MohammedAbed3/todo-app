import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Text('FavoritesScreen',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
