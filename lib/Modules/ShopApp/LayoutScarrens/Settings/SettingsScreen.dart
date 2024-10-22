import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/Layout/shopApp/shopCubit/cubit.dart';
import 'package:untitled2/Layout/shopApp/shopCubit/states.dart';
import 'package:untitled2/Model/shop_app/ShopLoginModel.dart';
import 'package:untitled2/shared/Components/components.dart';
import 'package:untitled2/shared/Constains/constains.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var phoneController = TextEditingController();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();

    ShopCubit.get(context).getProfile();

  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {


      },
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        var model = cubit.profileModel?.data;

        if(model != null) {
          print('new name${model.name}');
          print(model.phone);
          print(model.email);

            nameController.text = model.name ?? '';
            emailController.text = model.email ?? '';
            phoneController.text = model.phone ?? '';




          print(nameController.text);
          print(emailController.text);
          print(phoneController.text);

        }

        return ConditionalBuilder(
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage('${model?.image}'),
                ),
                SizedBox(height: 20),
                defaultFormField(
                  controller: nameController,
                  type: TextInputType.text,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return 'Name must not empty';
                    }
                  },
                  label: 'Name',
                  prefix: Icons.person_2_outlined,
                ),
                SizedBox(height: 20),
                defaultFormField(
                  controller: emailController,
                  type: TextInputType.text,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return 'Email must not empty';
                    }
                  },
                  label: 'Email',
                  prefix: Icons.email_outlined,
                ),
                SizedBox(height: 20),
                defaultFormField(
                  controller: phoneController,
                  type: TextInputType.text,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return 'Phone must not empty';
                    }
                  },
                  label: 'Phone',
                  prefix: Icons.phone,
                ),
                SizedBox(height: 20),
                defaultButton(
                  function: () {

                    cubit.logout(context);
                    nameController.clear();
                    emailController.clear();
                    phoneController.clear();


                  },
                  text: 'Logout',
                  background: Colors.red,
                ),
              ],
            ),
          ),
          condition: cubit.profileModel != null ,
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
