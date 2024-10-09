import 'package:flutter/material.dart';

class ShopSearchScreen extends StatelessWidget {
  const ShopSearchScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: Text('SearchScreen',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
