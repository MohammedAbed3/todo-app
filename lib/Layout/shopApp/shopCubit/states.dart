import 'package:untitled2/Model/shop_app/home_model.dart';

import '../../../Model/shop_app/change_favorites_model.dart';

abstract class ShopStates{}
class ShopInitialState extends ShopStates{}
class ShopChangeBottomNavState extends ShopStates{}
class ShopLayoutLoadingState extends ShopStates{}
class ShopSuccessHomeDataState extends ShopStates{


}
class ShopErrorHomeDataState extends ShopStates{
  final String error;

  ShopErrorHomeDataState(this.error);
}


class ShopSuccessCategoriesState extends ShopStates{}
class ShopErrorCategoriesState extends ShopStates{
  final String error;

  ShopErrorCategoriesState(this.error);
}

class ShopSuccessChangeFavoriteState extends ShopStates{

  final ChangeFavoritesModel model;

  ShopSuccessChangeFavoriteState(this.model);
}
class ShopErrorChangeFavoriteState extends ShopStates{
  final String error;

  ShopErrorChangeFavoriteState(this.error);
}
class ShopChangeFavoriteState extends ShopStates{}
