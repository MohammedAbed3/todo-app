
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/Layout/shopApp/shopCubit/states.dart';
import 'package:untitled2/Model/shop_app/categories_model.dart';
import 'package:untitled2/Model/shop_app/home_model.dart';
import 'package:untitled2/Modules/ShopApp/LayoutScarrens/Categories/CategoriesScrren.dart';
import 'package:untitled2/Modules/ShopApp/LayoutScarrens/Favorites/FavoritesScreen.dart';
import 'package:untitled2/Modules/ShopApp/LayoutScarrens/Products/ProductsScreen.dart';
import 'package:untitled2/Modules/ShopApp/LayoutScarrens/Settings/SettingsScreen.dart';
import 'package:untitled2/shared/Constains/constains.dart';
import 'package:untitled2/shared/Networks/end_points.dart';
import 'package:untitled2/shared/Networks/remote/dio_helper.dart';

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
  void getHomeData(){
    emit(ShopLayoutLoadingState());
    DioHelper.getData(
        url: HOME,
        token: token).then((value) {

      model = HomeModel.fromJson(value?.data);

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
}