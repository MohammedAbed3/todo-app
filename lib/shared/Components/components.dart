

import 'package:flutter/material.dart';
import 'package:untitled2/Layout/NewsApp/Cubit/cubit.dart';
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
        SizedBox(width: 20,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,

            children: [

              Text('${model['title']}',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),
              ),
              Text(
                  '${model['date']}'),

            ],
          ),
        ),
        SizedBox(width: 20,),
        IconButton(
            onPressed: () {
              AppCubit.get(context).updateDate(status: 'done', id: model['id']);

        },
        icon: Icon(Icons.check_box_outlined)
        ),
        IconButton(
            onPressed: () {
              AppCubit.get(context).updateDate(status: 'archive', id: model['id']);

        },
        icon: Icon(Icons.archive_outlined)
        ),

      ],

    ),
  ),
  onDismissed: (direction) {
    AppCubit.get(context).deleteDate(id: model['id']);
  },
);

Widget buildArticleItem(article)=>Padding(
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
                  : AssetImage('assets/images/no_image.png') as ImageProvider, // صورة افتراضية

              fit: BoxFit.cover
          ),
        ),
      ),
      SizedBox(width: 20,),
      Expanded(
        child: Container(
          height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text('${article['title']}',
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15
                  ),),
              ),
              Text('${article['publishedAt']}',
                style: TextStyle(
                  color: Colors.grey,

                ),),

            ],),
        ),
      )
    ],
  ),
);



