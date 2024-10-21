import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:untitled2/Layout/NewsApp/Cubit/cubit.dart';
import 'package:untitled2/Layout/NewsApp/Cubit/states.dart';
import 'package:untitled2/Layout/shopApp/ShopLayout.dart';
import 'package:untitled2/Layout/shopApp/shopCubit/cubit.dart';
import 'package:untitled2/Modules/ShopApp/Login/ShopLoginScreen.dart';
import 'package:untitled2/Modules/ShopApp/OnBoarding/OnBoardingScreen.dart';
import 'package:untitled2/shared/Constains/constains.dart';
import 'package:untitled2/shared/Networks/local/CacheHelper.dart';
import 'package:untitled2/shared/Networks/remote/dio_helper.dart';
import 'package:untitled2/shared/Styles/colors.dart';
import 'package:untitled2/shared/Styles/theme.dart';
import 'package:untitled2/shared/bloc_observer.dart';


void main()async {

  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();

  bool? newMode = CacheHelper.getData(key: 'isDark') ;
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding') ;
  token= CacheHelper.getData(key: 'token');
  print(onBoarding);

  Widget widget;

  if(onBoarding != null){
    if(token != null) widget = ShopLayout();
    else widget = ShopLoginScreen();
  }else{
    widget = OnBoardingScreen();
  }
  runApp(MyApp(isDark: newMode,startWidget: widget,));
}

class MyApp extends StatelessWidget {

  final bool? isDark;
  final Widget? startWidget;


  const MyApp({ this.isDark,  this.startWidget ,super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
        create: (context) => NewsCubit()..getBusinessData()..changeMode(fromShared: isDark),
        ),
        BlocProvider(
        create: (context) => ShopCubit()..getHomeData()..getCategoriesData()..getFavorite()..getProfile(),
        ),

    ],
      child: BlocConsumer<NewsCubit, NewsStates>(
          builder: (context, state) {
            return MaterialApp(
              title: 'Flutter Demo',

              theme: ligthThame ,
              
              darkTheme: darkThame,
              themeMode: NewsCubit.get(context).isDark ? ThemeMode.light :ThemeMode.light,
              debugShowCheckedModeBanner: false,
              home:  startWidget,
            );
          },
          listener: (context, state) {},
        ),

    );
  }
}
