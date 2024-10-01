
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/Layout/NewsApp/Cubit/cubit.dart';
import 'package:untitled2/Layout/NewsApp/Cubit/states.dart';
import 'package:untitled2/Modules/NewsAppScarens/SearchScreen/SearchScreen.dart';
import 'package:untitled2/shared/Networks/remote/dio_helper.dart';

class news_layout extends StatelessWidget {
  const news_layout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(

        builder: (context, state) {
          NewsCubit cubit = NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('News App'),
              actions: [
                IconButton(onPressed: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(),));

                }, icon: Icon(Icons.search_rounded),),
                IconButton(onPressed: ()
                {
                  cubit.changeMode();

                }, icon: Icon(Icons.brightness_4),),
              ],

            ),
            body: cubit.newsScreen[cubit.currentIndex],

            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomNav(index);
              },
                items: cubit.bottomNavItem
            ) ,
          );
        } ,
        listener: (context, state) {

        },
    );
  }
}
