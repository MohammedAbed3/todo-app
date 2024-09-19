

import 'package:flutter/material.dart';
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




