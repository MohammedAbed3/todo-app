
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/Layout/shopApp/shopCubit/states.dart';
import 'package:untitled2/Model/shop_app/categories_model.dart';
import 'package:untitled2/Model/shop_app/get_favorites_model.dart';
import 'package:untitled2/Model/shop_app/home_model.dart';
import 'package:untitled2/Modules/ShopApp/LayoutScarrens/Categories/CategoriesScrren.dart';
import 'package:untitled2/Modules/ShopApp/LayoutScarrens/Favorites/FavoritesScreen.dart';
import 'package:untitled2/Modules/ShopApp/LayoutScarrens/Products/ProductsScreen.dart';
import 'package:untitled2/Modules/ShopApp/LayoutScarrens/Settings/SettingsScreen.dart';
import 'package:untitled2/shared/Constains/constains.dart';
import 'package:untitled2/shared/Networks/end_points.dart';
import 'package:untitled2/shared/Networks/remote/dio_helper.dart';

import '../../../Model/shop_app/change_favorites_model.dart';

class ShopCubit extends Cubit<ShopStates>{

  ShopCubit():super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> bottomScreen = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index){
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

   HomeModel? model;
  Map<int?,bool?>? favorites = {};
  void getHomeData(){
    emit(ShopLayoutLoadingState());
    DioHelper.getData(
        url: HOME,
        token: token).then((value) {

      model = HomeModel.fromJson(value?.data);
      print('token here ${token.toString()}');

      model?.data?.products.forEach((e){
        favorites?.addAll({
         e.id : e.inFavorites,

        });

      });

      print('Favorites hereee ${favorites.toString()}');

      if (model?.data?.banners != null && model!.data!.banners!.isNotEmpty) {
        print(model?.data?.banners[0].image); // الوصول للصورة الأولى من البنرات
      }
      print(model?.data?.products[0].name);
      print(model?.data?.products[0].price);
      emit(ShopSuccessHomeDataState());
    },).catchError( (e){
      print('tokennnnnn $token');
      emit(ShopErrorHomeDataState(e.toString()));
      print('Error here ${e.toString()}');

    });


  }


  CategoriesModel? categoriesModel;
  void getCategoriesData(){
    DioHelper.getData(
        url: GET_CATEGORIES).then((value) {

      categoriesModel = CategoriesModel.fromJson(value?.data);


      emit(ShopSuccessCategoriesState());
    },).catchError( (e){

      emit(ShopErrorCategoriesState(e.toString()));
      print('Error here ${e.toString()}');

    });


  }


  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorite(int? productId){
    favorites?[productId] = !favorites![productId]!;
    emit(ShopChangeFavoriteState());
    DioHelper.postData(
      url: FAVORITES,
      data: {'product_id': productId},
      token: token,
    )?.then((value) {
      print('Response data: ${value.data}');  // تحقق من البيانات

      // تحقق من حالة الاستجابة
      if (value.data['status'] == true) {
        changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
        emit(ShopSuccessChangeFavoriteState(changeFavoritesModel!));
      getFavorite();

      } else {
        emit(ShopErrorChangeFavoriteState(value.data['message']));
      }
    }).catchError((error) {
      favorites?[productId] = !favorites![productId]!;

      print('Error occurred: $error');
      emit(ShopErrorChangeFavoriteState(error.toString()));
    });

  }

  FavoritesModel? favModel;

  void getFavorite() {
emit(ShopLoadingGetFavState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      print('Response Data: ${value?.data}'); // تحقق من البيانات المستلمة

      if (value?.data != null) {
        favModel = FavoritesModel.fromJson(value?.data);
        emit(ShopSuccessGetFavState());
      } else {
        emit(ShopErrorGetFavState('No data found'));
      }
    }).catchError((error) {
      print('Error: $error');
      emit(ShopErrorGetFavState(error.toString()));
    });

  }


}