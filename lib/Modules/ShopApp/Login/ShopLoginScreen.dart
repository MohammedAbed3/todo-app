import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/Layout/shopApp/ShopLayout.dart';
import 'package:untitled2/Modules/ShopApp/Login/cubit/cubit.dart';
import 'package:untitled2/Modules/ShopApp/Login/cubit/state.dart';
import 'package:untitled2/Modules/ShopApp/Register/ShopRegisterScreen.dart';
import 'package:untitled2/shared/Components/components.dart';
import 'package:untitled2/shared/Constains/constains.dart';
import 'package:untitled2/shared/Networks/local/CacheHelper.dart';

class ShopLoginScreen extends StatelessWidget {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  ShopLoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.model.status!) {
              print(state.model.status);
              print(state.model.message);
              print(state.model.data?.token);
              CacheHelper.savaDate(
                  key: 'token',
                  value: state.model.data?.token,
              ).then((value) {

                token = state.model.data?.token;
                navgetToKill(context, ShopLayout());
              },);
              ShowSnakBar(context: context, text: '${state.model.message}');
            } else {
              print(state.model.message);

              ShowSnakBar(context: context, text: 'حدث خطا${state.model.message}');
            }
          }
          if (state is ShopLoginErrorState) {
            // قم بتعيين المتغير هنا إلى الحالة

          ShowSnakBar(context: context, text: "حدث خطا");
          }

        },

          builder: (context, state) {

          ShopLoginCubit cubit = ShopLoginCubit.get(context);
            return Scaffold(
              appBar: AppBar(),
              body:  Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('LOGIN',
                              style: Theme.of(context).textTheme.displayMedium ,),
                            Text('login now to browse our hot offers'
                              ,
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: Colors.grey
                              ) ,),
                            const SizedBox(
                              height: 30,
                            ),
                            defaultFormField(
                                controller: emailController,
                                type: TextInputType.emailAddress,
                                validate: ( value) {
                                  if(value!.isEmpty){
                                    return 'please enter your email';
                                  }
                                  return null;
                                },
                                label: 'Email Address',
                                prefix: Icons.email_outlined,
                              textAction: TextInputAction.next

                            ),

                            const SizedBox(
                              height: 15,
                            ),
                            defaultFormField(
                                controller: passwordController,
                                type: TextInputType.visiblePassword,
                                validate: ( value) {
                                  if(value!.isEmpty){
                                    return 'password too short';
                                  }
                                  return null;
                                },
                                label: 'Password Address',
                                prefix: Icons.lock_clock_outlined,
                                suffix: cubit.suffix,
                              suffixPressed: () {
                                cubit.changePasswordSate();

                              },


                                textAction: TextInputAction.done,
                                isPassword: cubit.isPassword,

                                onSubmit: (value) {
                                if(formKey.currentState!.validate()){
                                  cubit.userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }

                              },
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            ConditionalBuilder(
                              condition: state is! ShopLoginLoadingState,
                              builder: (context) => defaultButton(
                                  function: () {
                                    if(formKey.currentState!.validate()){
                                      cubit.userLogin(
                                          email: emailController.text,
                                          password: passwordController.text);
                                    }



                                  },
                                  text: 'login',
                                  isUpperCase: true
                              ),
                              fallback: (context) => const Center(child: CircularProgressIndicator()),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Dont hava an account',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                defaultTextButton(
                                    function: () {
                                      navgetTo(context,  ShopRegisterScreen());
                                    },
                                    text: 'Register Now')
                              ],
                            )


                          ]
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
         ),
    );
  }
}
