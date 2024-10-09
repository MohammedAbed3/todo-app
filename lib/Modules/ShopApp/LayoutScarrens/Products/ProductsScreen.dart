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

class ProductsScreen extends StatelessWidget {

  var ShopHomeController = PageController();

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {

      },
      builder: (context, state) {

        ShopCubit cubit = ShopCubit.get(context);
        return ConditionalBuilder(
            condition: cubit.model != null && cubit.categoriesModel != null,
            builder: (context) =>productsBuilder(cubit.model,cubit.categoriesModel) ,
            fallback:(context) =>  Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget productsBuilder(HomeModel? model,CategoriesModel? catModel){
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
              items: model?.data?.banners.map((e) => Image(
                image: NetworkImage('${e.image}'),
                width: double.infinity,
                fit: BoxFit.cover,
              ),).toList(),
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
                scrollDirection: Axis.horizontal


              )
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Categories',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                ),
                ),
                Container(
                  height: 100,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => buildCategoriesItem(catModel.data!.data[index]),
                      separatorBuilder: (context, index) =>  SizedBox(width: 10,),
                      itemCount: catModel!.data!.data.length),
                ),


                Text('New Procuct',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20,),

          Container(
            color: Colors.grey[300],
            child: GridView.count(crossAxisCount: 2,
              shrinkWrap: true,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio: 1/1.58,

              physics: NeverScrollableScrollPhysics(),
              children: List.generate(model!.data!.products.length, (index) =>buildGridProduct(model.data!.products[index]) ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildGridProduct(ProductsModel model){
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(image: NetworkImage('${model.image}'),
                width: double.infinity,

                height: 200,
              ),
              if(model.discount != 0)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                color: Colors.red,
                child: Text('Discount',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15
                ),
                ),
              )

            ],

          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text('${model.name}',
                maxLines: 2,
                  style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: 16,
                    height: 1.3

                ),
                ),
                Row(
                  children: [
                    Text('${model.price.round()}',

                      style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: 12,
                        height: 1.3,
                        color: primaryColor

                    ),
                    ),
                    SizedBox(width: 10,),
                    if(model.discount !=0)
                    Text('${model.oldPrice.round()}',

                      style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: 12,
                        height: 1.3,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough

                    ),
                    ),
                    Spacer(),
                    IconButton(onPressed: () {
                      
                    },
                        padding: EdgeInsets.zero,
                        icon: Icon(Icons.favorite_border,
                    size: 20,
                    ))
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategoriesItem(CategoriesData model){
    return           Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children:
      [
        Image(image: NetworkImage('${model.image}'),
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
        Container(
            width: 100,
            color: Colors.black.withOpacity(0.8),
            child: Text('${model.name}',
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.white
              ),
            ))
      ],
    );

  }
}
