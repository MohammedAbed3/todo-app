import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/Modules/ShopApp/Register/cubit/cubit.dart';
import 'package:untitled2/Modules/ShopApp/Register/cubit/state.dart';

import '../../../Layout/shopApp/ShopLayout.dart';
import '../../../shared/Components/components.dart';
import '../../../shared/Constains/constains.dart';
import '../../../shared/Networks/local/CacheHelper.dart';

class ShopRegisterScreen extends StatelessWidget {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {

            if (state.model.status!) {
              print(state.model.status);
              print(state.model.message);
              print(state.model.data?.token);
              CacheHelper.savaDate(
                key: 'token',
                value: state.model.data?.token,
              ).then((value) {
                token = state.model.data?.token;

                token = state.model.data?.token;
                navgetToKill(context, ShopLayout());
              },);
              ShowSnakBar(context: context, text: '${state.model.message}');
            } else {
              print(state.model.message);

              ShowSnakBar(context: context, text: 'حدث خطا${state.model.message}');
            }
            // يمكن إضافة الانتقال إلى الشاشة الرئيسية أو صفحة تسجيل الدخول هنا.
          } else if (state is ShopRegisterErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          ShopRegisterCubit cubit = ShopRegisterCubit.get(context);

          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "انشئ حسابك الآن",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // بريد إلكتروني
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: "البريد الإلكتروني",
                        border: OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.email_outlined),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // الاسم
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: "الاسم",
                        border: OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.person),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // كلمة المرور
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "كلمة المرور",
                        border: OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.lock),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // الهاتف
                    TextFormField(
                      controller: phoneController,
                      decoration: InputDecoration(
                        labelText: "رقم الهاتف",
                        border: OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.phone),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // زر التسجيل
                    ElevatedButton(
                      onPressed: () {
                        // هنا يمكنك إضافة منطق التحقق من البيانات
                        String email = emailController.text;
                        String password = passwordController.text;
                        String name = nameController.text;
                        String phone = phoneController.text;

                        if (email.isEmpty || password.isEmpty || name.isEmpty || phone.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("يرجى ملء جميع الحقول")),
                          );
                          return;
                        }

                        cubit.userRegister(
                            email: email,
                            password: password,
                            name: name,
                            phone: phone
                        );

                      },
                      child: state is ShopRegisterLoadingState
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text("تسجيل حساب"),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // رابط لتسجيل الدخول
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("لديك حساب؟ "),
                        TextButton(
                          onPressed: () {
                            // الانتقال إلى صفحة تسجيل الدخول
                          },
                          child: const Text(
                            "تسجيل الدخول",
                            style: TextStyle(fontSize: 16, color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
