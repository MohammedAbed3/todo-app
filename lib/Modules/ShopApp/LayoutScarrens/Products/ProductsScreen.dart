import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:untitled2/Layout/shopApp/shopCubit/cubit.dart';
import 'package:untitled2/Layout/shopApp/shopCubit/states.dart';
import 'package:untitled2/Model/shop_app/categories_model.dart';
import 'package:untitled2/Model/shop_app/home_model.dart';
import 'package:untitled2/shared/Styles/colors.dart';

import '../../../../shared/Components/components.dart';

class ProductsScreen extends StatelessWidget {
  var ShopHomeController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessChangeFavoriteState) {
          if (!state.model.status!) {
            ShowSnakBar(context: context, text: '${state.model.message}');
          }
        }
      },
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return ConditionalBuilder(
            condition: cubit.model != null && cubit.categoriesModel != null,
            builder: (context) =>
                productsBuilder(cubit.model, cubit.categoriesModel, context),
            fallback: (context) => Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget productsBuilder(HomeModel? model, CategoriesModel? catModel, context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
              items: model?.data?.banners
                  .map(
                    (e) => Image(
                      image: NetworkImage('${e.image}'),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                  height: 250,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  viewportFraction: 1,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal)),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 100,
                  child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          buildCategoriesItem(catModel.data!.data[index]),
                      separatorBuilder: (context, index) => SizedBox(
                            width: 10,
                          ),
                      itemCount: catModel!.data!.data.length),
                ),
                Text(
                  'New Procuct',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio: 1 / 1.58,
              physics: NeverScrollableScrollPhysics(),
              children: List.generate(
                  model!.data!.products.length,
                  (index) =>
                      buildGridProduct(model.data!.products[index], context)),
            ),
          )
        ],
      ),
    );
  }

  Widget buildGridProduct(ProductsModel model, BuildContext context) {
    return Card(
      elevation: 4, // إضافة ظل خفيف لتمييز الكارد
      margin: const EdgeInsets.all(8), // مسافة بين العناصر
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // حواف دائرية للكارد
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // الصورة مع الخصم
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12), // حواف دائرية للصورة
                  child: Image.network(
                    '${model.image}',
                    width: double.infinity,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                if (model.discount != 0)
                  Positioned(
                    left: 0,
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.8),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Discount',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8), // مسافة بين الصورة والمحتوى
            // النصوص والمعلومات
            Text(
              '${model.name}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  '${model.price.round()} \$',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 10),
                if (model.discount != 0)
                  Text(
                    '${model.oldPrice.round()} \$',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                const Spacer(),
                // زر المفضلة
                CircleAvatar(
                  radius: 18,
                  backgroundColor:
                      ShopCubit.get(context).favorites?[model.id] == true
                          ? Colors.red
                          : Colors.grey,
                  child: IconButton(
                    onPressed: () {
                      print(model.id);
                      ShopCubit.get(context).changeFavorite(model.id);
                    },
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCategoriesItem(CategoriesData model) {
    return Card(
      elevation: 4, // ظل خفيف
      margin: const EdgeInsets.all(8), // مسافات بين العناصر
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // حواف دائرية
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12), // حواف دائرية للصورة
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            // استخدام AspectRatio لجعل الصورة متناسبة دائمًا
            AspectRatio(
              aspectRatio: 1, // نسبة العرض إلى الارتفاع 1:1
              child: Image.network(
                '${model.image}',
                fit: BoxFit.cover, // ملء الصورة مع الحفاظ على التناسب
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error, color: Colors.red); // عرض أيقونة عند فشل تحميل الصورة
                },
              ),
            ),
            // النص مع خلفية شفافة
            Container(
              width: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [primaryColor,
                      Colors.transparent
                    ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,


                )
              ),
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                '${model.name}',
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
