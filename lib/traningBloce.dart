import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/Cubit/Cubit.dart';
import 'package:untitled2/Cubit/States.dart';

class traningBloce extends StatelessWidget {
  const traningBloce({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
    create: (context) => CounterCubit(),
      child: BlocConsumer<CounterCubit,CounterStates>(
          builder: (context, state) {
          return Scaffold(

              appBar: AppBar(),
              body: SizedBox(
                height: double.infinity,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {

                          CounterCubit.get(context).counterPlus();
                        },
                        child: const Text('+',
                          style: TextStyle(
                              fontSize: 40
                          ),)

                    ),
                    Text('${CounterCubit.get(context).counter}',
                      style: const TextStyle(
                          fontSize: 40
                      ),),
                    TextButton(
                        onPressed: () {
                          CounterCubit.get(context).counterMinus();
                        },
                        child: const Text('-',
                          style: TextStyle(
                              fontSize: 50
                          ),)),

                  ],
                ),
              ),
            );
          },
          listener: (context, state) {

          },
      ),
    );
  }
}
