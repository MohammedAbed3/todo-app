import 'package:untitled2/Model/shop_app/ShopLoginModel.dart';

abstract class ShopLoginStates {}

class ShopLoginInitialState extends ShopLoginStates{}

class ShopLoginChangPasswordState extends ShopLoginStates{}


class ShopLoginLoadingState extends ShopLoginStates{}
class ShopLoginSuccessState extends ShopLoginStates{

  final ShopLoginModel model;

  ShopLoginSuccessState(this.model);
}
class ShopLoginErrorState extends ShopLoginStates{
  final String error;

  ShopLoginErrorState(this.error);
}