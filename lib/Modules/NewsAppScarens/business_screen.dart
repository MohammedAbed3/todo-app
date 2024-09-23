import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/Layout/NewsApp/Cubit/cubit.dart';
import 'package:untitled2/Layout/NewsApp/Cubit/states.dart';
import 'package:untitled2/shared/Components/components.dart';

class business_screen extends StatelessWidget {
  const business_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: BlocConsumer<NewsCubit,NewsStates>(
          builder:(context, state) {
            NewsCubit cubit = NewsCubit.get(context);
            return ConditionalBuilder(
              condition: state is! NewsGetBusinessLoadingStates ,
              builder: (context) => ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildArticleItem(cubit.business[index]),
                itemCount: cubit.business.length,
                separatorBuilder: (context, index) => SizedBox(height: 10,),
              ),
              fallback: (context) => Center(child: CircularProgressIndicator()),
            );
          } ,
          listener:(context, state) {

          } ,

        ),

    );
  }
}
