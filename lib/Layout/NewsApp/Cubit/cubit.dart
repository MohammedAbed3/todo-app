
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/Layout/NewsApp/Cubit/states.dart';
import 'package:untitled2/Modules/NewsAppScarens/business_screen.dart';
import 'package:untitled2/Modules/NewsAppScarens/sciences_screen.dart';
import 'package:untitled2/Modules/NewsAppScarens/sport_screen.dart';
import 'package:untitled2/shared/Networks/local/CacheHelper.dart';
import 'package:untitled2/shared/Networks/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>{

  NewsCubit(): super(NewsInitialState());

 static NewsCubit get(context)=> BlocProvider.of(context);

  List<Widget> newsScreen =[
    const business_screen(),
    const sport_screen(),
    const sciences_screen(),
  ];

  List<BottomNavigationBarItem> bottomNavItem = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.business_center_outlined),
      label: 'Business'
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.sports_basketball),
      label: 'Sports'
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.science_sharp),
      label: 'Sciences'
    ),

    ];


  int currentIndex = 0;

  bool isDark = false;

  void changeMode({bool? fromShared}){

    if(fromShared != null){
      isDark = fromShared;

    }else{
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(NewsChangeModeStates());

      },);
    }

  }

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(NewsChangeBottomNavState()); // إصدار الحالة لتغيير التبويب

    if (index == 1) {
      getSportsData(); // بعد إصدار الحالة، قم بجلب بيانات الرياضة
    } else if (index == 2) {
      getSciencesData(); // بعد إصدار الحالة، قم بجلب بيانات العلوم
    }
  }

  List<dynamic> business= [];
  List<dynamic> sports= [];
  List<dynamic>  sciences= [];
  List<dynamic>  search= [];

  void getBusinessData() {
    emit(NewsGetBusinessLoadingStates());

    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'us',
        'category': 'business',
        'apiKey': 'd470d1fdeb764cb4b7edb87889753390'
      },
    ).then((value) {
      business = value?.data['articles'];
      emit(NewsGetBusinessSuccessStates());
      print(business[0]['title']);
    }).catchError((error) {
      print('Error when getting data: ${error.toString()}');
      emit(NewsGetBusinessErrorStates(error.toString()));
    });
  }
  void getSportsData(){
    emit(NewsGetSportsLoadingStates());
   if(sports.isEmpty){
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
    if(sciences.isEmpty){
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

  void getSearchData(String value) {
    emit(NewsGetSearchLoadingStates());

    // تحقق مما إذا كانت قائمة العلوم فارغة وقم بمعالجة ذلك

      // استدعاء DioHelper للحصول على البيانات من API
      DioHelper.getData(
        url: 'v2/everything',
        query: {
          'q': value,
          'apiKey': 'd470d1fdeb764cb4b7edb87889753390',
        },
      ).then((value) {
        // التحقق من وجود البيانات في الاستجابة
        if (value != null && value.data != null) {
          search = value.data['articles'];

          if (search.isNotEmpty) {
            print(search[0]['title']);
          } else {
            print('No articles found.');
          }

          emit(NewsGetSearchSuccessStates());
          print('Searching here...');
        } else {
          emit(NewsGetSearchErrorStates("No data returned"));
        }
      }).catchError((error) {
        print('Error when getting sciences data: ${error.toString()}');
        emit(NewsGetSearchErrorStates(error.toString()));
      });
    }
  }
