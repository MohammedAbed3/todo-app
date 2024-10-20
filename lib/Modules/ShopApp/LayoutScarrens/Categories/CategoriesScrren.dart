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


  Widget buildCatItem(CategoriesData model) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
    child: Card(
      elevation: 4, // إضافة ظل للكارد
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // حواف دائرية للكارد
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // الصورة مع الحواف الدائرية
            ClipRRect(
              borderRadius: BorderRadius.circular(12), // حواف دائرية للصورة
              child: Image.network(
                '${model.image}',
                width: 80,
                height: 80,
                fit: BoxFit.cover, // ضبط الصورة لتناسب الحاوية
              ),
            ),
            const SizedBox(width: 15), // مسافة بين الصورة والنص
            // النص
            Expanded(
              child: Text(
                '${model.name}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis, // منع النص من الخروج عن الحدود
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_sharp,
              color: Colors.grey, // أيقونة السهم
            ),
          ],
        ),
      ),
    ),
  );
}
