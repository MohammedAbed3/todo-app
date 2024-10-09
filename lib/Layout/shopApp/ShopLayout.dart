import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/Layout/shopApp/shopCubit/cubit.dart';
import 'package:untitled2/Layout/shopApp/shopCubit/states.dart';
import 'package:untitled2/Modules/ShopApp/LayoutScarrens/Search/ShopSearchScreen.dart';
import 'package:untitled2/shared/Components/components.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return
      BlocConsumer<ShopCubit,ShopStates>(

        listener: (context, state) {

        },
        builder: (context, state) {
          ShopCubit cubit =ShopCubit.get(context);


          return Scaffold(
            appBar: AppBar(
              leading: Text('Salla',
              style: Theme.of(context).textTheme.headlineLarge,
              ),
              actions: [
                IconButton(onPressed: () {
                  navgetTo(context, ShopSearchScreen());
                }, icon: Icon(Icons.search))
              ],
            ),
            body: cubit.bottomScreen[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index) {
                cubit.changeBottom(index);
              },
                currentIndex: cubit.currentIndex,
              items: [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined),label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.apps),label: 'Categories'),
            BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'Favorite'),
            BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings'),

          ]),
          );
        },

      );


  }
}
