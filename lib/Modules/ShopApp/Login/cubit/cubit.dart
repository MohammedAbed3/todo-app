

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/Model/shop_app/ShopLoginModel.dart';
import 'package:untitled2/Modules/ShopApp/Login/cubit/state.dart';
import 'package:untitled2/shared/Networks/end_points.dart';
import 'package:untitled2/shared/Networks/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>{


  ShopLoginCubit(): super(ShopLoginInitialState());

  ShopLoginModel? model;




  static ShopLoginCubit get(context)=> BlocProvider.of(context);
  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;

  void userLogin({
    required String email,
    required String password,
}){
    emit(ShopLoginLoadingState());
    DioHelper.postData(url: LOGIN, data: {
      'email':email,
      'password':password,
    })?.then((value) {
       model= ShopLoginModel.fromJson(value.data);
      print(value.data);
      print(model?.status);
      print(model?.data?.name);

      emit(ShopLoginSuccessState(model!));
    },).catchError((onError){
      print(onError.toString());
      emit(ShopLoginErrorState(onError.toString()));
    });
  }

  void changePasswordSate(){

    isPassword =!isPassword;

    suffix  = isPassword ? Icons.visibility_outlined :Icons.visibility_off_outlined ;
    emit(ShopLoginChangPasswordState());


  }
}