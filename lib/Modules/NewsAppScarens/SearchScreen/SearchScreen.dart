import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/Layout/NewsApp/Cubit/cubit.dart';
import 'package:untitled2/Layout/NewsApp/Cubit/states.dart';
import 'package:untitled2/shared/Components/components.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      builder:(context, state) {

       NewsCubit cubit= NewsCubit.get(context);

        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Search'),
                  border: OutlineInputBorder(),
                  prefix: Icon(Icons.search,),

                ),
                onChanged: (value) {

                  cubit.getSearchData(value);
                },
                style: const TextStyle(
                    color: Colors.white
                ),
              ),

              Expanded(child: articleBuilder(cubit.search, context,isSearch: true))
            ],
          ),

        );

      } ,
      listener: (context, state) {

      },

    );
  }
}
