
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/Layout/NewsApp/Cubit/states.dart';
import 'package:untitled2/Modules/NewsAppScarens/business_screen.dart';
import 'package:untitled2/Modules/NewsAppScarens/sciences_screen.dart';
import 'package:untitled2/Modules/NewsAppScarens/settings_screen.dart';
import 'package:untitled2/Modules/NewsAppScarens/sport_screen.dart';
import 'package:untitled2/shared/Networks/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>{

  NewsCubit(): super(NewsInitialState());

 static NewsCubit get(context)=> BlocProvider.of(context);

  List<Widget> newsScreen =[
    business_screen(),
    sport_screen(),
    sciences_screen(),
    settings_screen(),
  ];

  List<BottomNavigationBarItem> bottomNavItem = [
    BottomNavigationBarItem(
      icon: Icon(Icons.business_center_outlined),
      label: 'Business'
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports_basketball),
      label: 'Sports'
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science_sharp),
      label: 'Sciences'
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings'
    ),
    ];


  int currentIndex = 0;

  void changeBottomNav(int index){
    currentIndex = index;

    if(index ==1){
      getSportsData();
    }
    if(index ==2){
      getSciencesData();
    }
    emit(NewsChangeBottomNavState());
  }
  List<dynamic> business= [];
  List<dynamic> sports= [];
  List<dynamic>  sciences= [];

  void getBusinessData(){
    emit(NewsGetBusinessLoadingStates());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'us',
          'category':'business',
          'apiKey' : 'd470d1fdeb764cb4b7edb87889753390'
        }).then((value) {

          business = value?.data['articles'];
          emit(NewsGetBusinessSuccessStates());
          print(business[0]['title']);
      // print(value?.data.toString());
     // print(value?.data['articles'][0]['title']);
    },).catchError((erorr){
      print('Erorr Whene get Data ${erorr.toString()}');
      emit(NewsGetBusinessErrorStates(erorr.toString()));
    });
  }
  void getSportsData(){
    emit(NewsGetSportsLoadingStates());
   if(sports.length == 0){
     DioHelper.getData(
         url: 'v2/top-headlines',
         query: {
           'country':'us',
           'category':'sports',
           'apiKey' : 'd470d1fdeb764cb4b7edb87889753390'
         }).then((value) {

       sports = value?.data['articles'];
       emit(NewsGetSportsSuccessStates());
       print(sports[0]['title']);
       print('hiiiiiiiiii');
       // print(value?.data.toString());
       // print(value?.data['articles'][0]['title']);
     },).catchError((erorr){
       print('Erorr Whene get Sports Data ${erorr.toString()}');
       emit(NewsGetSportsErrorStates(erorr.toString()));
     });
   }else{
     emit(NewsGetSportsSuccessStates());

   }
  }

  void getSciencesData(){
    emit(NewsGetSciencesLoadingStates());
    if(sciences.length == 0){
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'us',
            'category':'science',
            'apiKey' : 'd470d1fdeb764cb4b7edb87889753390'
          }).then((value) {

        sciences = value?.data['articles'];
        emit(NewsGetSciencesSuccessStates());
        print(sciences[0]['title']);
        print('hiiiiiiiiii');
        // print(value?.data.toString());
        // print(value?.data['articles'][0]['title']);
      },).catchError((erorr){
        print('Erorr Whene get sciences Data ${erorr.toString()}');
        emit(NewsGetSciencesErrorStates(erorr.toString()));
      });
    }else{
      emit(NewsGetSciencesSuccessStates());

    }
  }
}