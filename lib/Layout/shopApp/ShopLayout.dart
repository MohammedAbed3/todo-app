import 'package:flutter/material.dart';
import 'package:untitled2/Modules/ShopApp/Login/ShopLoginScreen.dart';
import 'package:untitled2/shared/Components/components.dart';
import 'package:untitled2/shared/Networks/local/CacheHelper.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading: Text('Home Scarren'),
      ),
      body: defaultTextButton(function: () {
        CacheHelper.removeDate(key: 'token').then((value) {
          if(value!){
            navgetToKill(context, ShopLoginScreen());
          }
        },);
      }, text: 'sing out')
    );
  }
}
