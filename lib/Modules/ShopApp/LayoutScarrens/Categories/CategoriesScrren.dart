import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/Layout/shopApp/shopCubit/cubit.dart';
import 'package:untitled2/Layout/shopApp/shopCubit/states.dart';
import 'package:untitled2/shared/Components/components.dart';

import '../../../../Model/shop_app/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(

      listener: (context, state) {

      },
        builder: (context, state) {

        ShopCubit cubit = ShopCubit.get(context);
          return ListView.separated(
              itemBuilder: (context, index) => buildCatItem(cubit.categoriesModel!.data!.data[index]),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: cubit.categoriesModel!.data!.data.length);
        },

    );
  }


  Widget buildCatItem(CategoriesData model)=>  Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(image: NetworkImage('${model.image}')
          ,width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
        SizedBox(width: 15,),

        Text('${model.name}',
        style: TextStyle(
          fontSize: 20

        ),
        ),
        Spacer(),
        Icon(Icons.arrow_forward_ios_sharp),
      ],

    ),
  );
}
