

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/Modules/WebView/WebView.dart';
import 'package:untitled2/shared/HomeScreenCubit/Cubit.dart';

Widget itemTasks ( Map model , BuildContext context)=>Dismissible(
  key: Key(model['id'].toString()),
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [

        CircleAvatar(
          radius: 45,
          child: Text('${model['time']}'),

        ),
        const SizedBox(width: 20,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,

            children: [

              Text('${model['title']}',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),
              ),
              Text(
                  '${model['date']}'),

            ],
          ),
        ),
        const SizedBox(width: 20,),
        IconButton(
            onPressed: () {
              AppCubit.get(context).updateDate(status: 'done', id: model['id']);

        },
        icon: const Icon(Icons.check_box_outlined)
        ),
        IconButton(
            onPressed: () {
              AppCubit.get(context).updateDate(status: 'archive', id: model['id']);

        },
        icon: const Icon(Icons.archive_outlined)
        ),

      ],

    ),
  ),
  onDismissed: (direction) {
    AppCubit.get(context).deleteDate(id: model['id']);
  },
);

Widget buildArticleItem(article, context)=>InkWell(
  onTap: () {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Webview(article['url']),));
  },
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children:
      [

        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(

                image: article['urlToImage'] != null && article['urlToImage'].isNotEmpty
                    ? NetworkImage(article['urlToImage'])
                    : const AssetImage('assets/images/no_image.png') as ImageProvider, // صورة افتراضية

                fit: BoxFit.cover
            ),
          ),
        ),
        const SizedBox(width: 20,),
        Expanded(
          child: SizedBox(
            height: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text('${article['title']}',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge,

                  ),
                ),
                Text('${article['publishedAt']}',
                  style: const TextStyle(
                    color: Colors.grey,

                  ),),

              ],),
          ),
        )
      ],
    ),
  ),
);


Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  required VoidCallback? function ,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  ValueChanged<String>? onSubmit,
  ValueChanged<String>? onChange,
  VoidCallback? onTap,
  bool isPassword = false,
  required FormFieldValidator<String>? validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  VoidCallback? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: suffixPressed,
          icon: Icon(
            suffix,
          ),
        )
            : null,
        border: const OutlineInputBorder(),
      ),
    );



Widget articleBuilder(list, context,{isSearch= false}) => ConditionalBuilder(
  condition: list.length > 0,
  builder: (context) =>
      ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(list[index], context),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: 10,),
  fallback: (context) => isSearch ? Container(): const Center(child: CircularProgressIndicator()),
);

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);

