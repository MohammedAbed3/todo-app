import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/Layout/NewsApp/Cubit/cubit.dart';
import 'package:untitled2/Layout/NewsApp/Cubit/states.dart';
import 'package:untitled2/shared/Components/components.dart';

class business_screen extends StatelessWidget {
  const business_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          NewsCubit cubit = NewsCubit.get(context);
          List list = cubit.business;

          return articleBuilder(list, context);
        },
      ),
    );
  }
}
