import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/Layout/shopApp/shopCubit/cubit.dart';
import 'package:untitled2/Layout/shopApp/shopCubit/states.dart';
import 'package:untitled2/shared/Components/components.dart';
import 'package:untitled2/shared/Styles/colors.dart';

import '../../../../Model/shop_app/get_favorites_model.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);

        // تحقق من أن favModel وبياناتها ليست null
        if (cubit.favModel?.data?.data == null || cubit.favModel!.data!.data!.isEmpty) {
          return const Center(
            child: Text('No Favorites Found'),
          );
        }

        // عرض القائمة إذا كانت البيانات موجودة
        return ConditionalBuilder(
          builder: (context) =>  ListView.separated(
            itemBuilder: (context, index) => buildFavItem(
                cubit.favModel!.data!.data![index],context
            ),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: cubit.favModel!.data!.data!.length,
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
          condition: state is! ShopLoadingGetFavState,
        );
      },
    );
  }

  Widget buildFavItem(FvaData model, BuildContext context) {
    return Card(
      elevation: 4, // إضافة ظل خفيف للكارد
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // جعل الحواف دائرية
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // الصورة مع الحواف الدائرية
            ClipRRect(
              borderRadius: BorderRadius.circular(12), // حواف دائرية للصورة
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage('${model.product?.image}'),
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                  if (model.product?.discount != 0)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.8),
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Discount',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 15), // مسافة بين الصورة والنص
            // النصوص والمعلومات
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model.product?.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '${model.product?.price?.round()} \$',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (model.product?.discount != 0)
                        Text(
                          '${model.product?.oldPrice?.round()} \$',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const Spacer(),
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: ShopCubit.get(context).favorites?[model.product!.id] == true
                            ? Colors.red
                            : Colors.grey,
                        child: IconButton(
                          onPressed: () {
                            print(model.id);
                            ShopCubit.get(context).changeFavorite(model.product!.id);
                          },
                          padding: EdgeInsets.zero,
                          icon: const Icon(
                            Icons.favorite,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
