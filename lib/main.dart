import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:untitled2/Layout/NewsApp/Cubit/cubit.dart';
import 'package:untitled2/Layout/NewsApp/Cubit/states.dart';
import 'package:untitled2/Layout/NewsApp/news_layout.dart';
import 'package:untitled2/shared/Networks/local/CacheHelper.dart';
import 'package:untitled2/shared/Networks/remote/dio_helper.dart';
import 'package:untitled2/shared/bloc_observer.dart';


void main()async {

  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();

 bool? newMode =  CacheHelper.getBoolean(key: 'isDark');

  runApp(MyApp(newMode!));
}

class MyApp extends StatelessWidget {

  final bool isDark;


  const MyApp(this.isDark, {super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()..getBusinessData()..changeMode(fromShared: isDark),
      child: BlocConsumer<NewsCubit, NewsStates>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
                scaffoldBackgroundColor: Colors.white,
                floatingActionButtonTheme: const FloatingActionButtonThemeData(
                  backgroundColor: Colors.deepOrange,
                ),
                appBarTheme: const AppBarTheme(
                    backgroundColor: Colors.white,
                    elevation: 0.0,
                    iconTheme: IconThemeData(color: Colors.black),
                    titleTextStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.white,
                        statusBarIconBrightness: Brightness.dark)),
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrangeAccent,
                  elevation: 20,
                  unselectedItemColor: Colors.grey,
                  backgroundColor: Colors.white,
                )),
            darkTheme: ThemeData(
              primarySwatch: Colors.deepOrange,
              appBarTheme: AppBarTheme(
                  backgroundColor: HexColor('333739'),
                  elevation: 0.0,
                  iconTheme: const IconThemeData(color: Colors.white),
                  titleTextStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: HexColor('333739'),
                      statusBarIconBrightness: Brightness.light)),
              scaffoldBackgroundColor: HexColor('333739'),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrangeAccent,
                elevation: 20,
                unselectedItemColor: Colors.grey,
                backgroundColor: HexColor('333739'),
              ),
              textTheme: const TextTheme(
                bodyLarge: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
            themeMode: NewsCubit.get(context).isDark ? ThemeMode.dark :ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: const news_layout(),
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
