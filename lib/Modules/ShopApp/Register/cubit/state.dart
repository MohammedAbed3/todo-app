import 'package:untitled2/Model/shop_app/ShopLoginModel.dart';
import 'package:untitled2/Model/shop_app/register_model.dart';

abstract class ShopRegisterStates {}

class ShopRegisterInitialState extends ShopRegisterStates{}

class ShopRegisterChangPasswordState extends ShopRegisterStates{}


class ShopRegisterLoadingState extends ShopRegisterStates{}
class ShopRegisterSuccessState extends ShopRegisterStates{

  final RegisterModel model;

  ShopRegisterSuccessState(this.model);
}
class ShopRegisterErrorState extends ShopRegisterStates{
  final String error;

  ShopRegisterErrorState(this.error);
}