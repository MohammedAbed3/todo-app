import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/shared/Components/components.dart';
import 'package:untitled2/shared/HomeScreenCubit/Cubit.dart';
import 'package:untitled2/shared/HomeScreenCubit/Stetes.dart';

class DoneScreen extends StatelessWidget {
  const DoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit,AppStets>(
      builder: (context, state) {

        var tasks = AppCubit.get(context).doneTasks;

        return  ConditionalBuilder(
          condition: tasks.length > 0,
          fallback:(context) => const Center(

            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Icon(
                    Icons.task_alt,
                    size: 100,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'There are no Done Tasks Yet',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ]),
          ) ,
          builder: (context) => ListView.builder(
            itemBuilder: (context, index) => itemTasks(tasks[index] ,context),
            itemCount: tasks.length,

          ),
        );
      },
      listener: (context, state) {

      },

    );
  }
}
