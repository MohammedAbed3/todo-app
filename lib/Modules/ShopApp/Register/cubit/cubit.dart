

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/Modules/ShopApp/Register/cubit/state.dart';
import 'package:untitled2/shared/Networks/end_points.dart';
import 'package:untitled2/shared/Networks/remote/dio_helper.dart';

import '../../../../Model/shop_app/register_model.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>{


  ShopRegisterCubit(): super(ShopRegisterInitialState());

  RegisterModel? model;




  static ShopRegisterCubit get(context)=> BlocProvider.of(context);
  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
}){
    emit(ShopRegisterLoadingState());
    DioHelper.postData(url: REGISTER, data: {
      'email':email,
      'password':password,
      'name':name,
      'phone':phone,
    })?.then((value) {
       model= RegisterModel.fromJson(value.data);
      print(value.data);
      print(model?.status);
      print(model?.data?.name);

      emit(ShopRegisterSuccessState(model!));
    },).catchError((onError){
      print(onError.toString());
      emit(ShopRegisterErrorState(onError.toString()));
    });
  }

  void changePasswordSate(){

    isPassword =!isPassword;

    suffix  = isPassword ? Icons.visibility_outlined :Icons.visibility_off_outlined ;
    emit(ShopRegisterChangPasswordState());


  }
}