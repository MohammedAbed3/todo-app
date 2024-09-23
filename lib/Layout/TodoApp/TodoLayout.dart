import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:untitled2/shared/HomeScreenCubit/Cubit.dart';
import 'package:untitled2/shared/HomeScreenCubit/Stetes.dart';





class HomeLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var fromKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();




  @override
  Widget build(BuildContext context) {

    return BlocProvider(

      create: (context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit,AppStets>(
        listener: (context, AppStets state) {

          if (state is AppInsertDatabaseState){
            Navigator.pop(context);
          }

        },
          builder: (context, AppStets state) {
            AppCubit cubit = AppCubit.get(context);

            return Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                backgroundColor: Colors.blueGrey,
                title: const Text(
                  'Todo App',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              body: cubit.screen[cubit.bnbSelected],
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  if (cubit.isBottomSheetOpened) {

                    if (fromKey.currentState!.validate()) {
                      // insertIntoDatabase(
                      //   titleController.text,
                      //   dateController.text,
                      //   timeController.text,
                      // ).then(
                      //
                      //       (value) {
                      //     getDateFromDatabase(database).then((value) {
                      //       Navigator.pop(context);
                      //
                      //
                      //       // setState(() {
                      //       //   tasksList =value;
                      //       //   print(tasksList);
                      //       //   isBottomSheetOpened = true;
                      //       // });
                      //
                      //     },);
                      //
                      //   },
                      // ).catchError((onError) {
                      //   print('error in $onError');
                      // });
                      cubit.insertIntoDatabase(
                          titleController.text,
                          dateController.text,
                          timeController.text);
                    }
                  } else {
                    scaffoldKey.currentState?.showBottomSheet((context) => Container(
                      width: double.infinity,
                      color: Colors.blueGrey[300],
                      child: Form(
                        key: fromKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: titleController,
                                decoration: const InputDecoration(
                                    prefix: Padding(
                                      padding:
                                      const EdgeInsets.only(right: 10.0),
                                      child: Icon(Icons.title),
                                    ),
                                    border: OutlineInputBorder(),
                                    fillColor: Colors.white,
                                    filled: true,
                                    label: Text('title')),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Title must not be empty';
                                  }
                                  return null; // إذا كان الحقل صحيحًا، لا تعرض أي رسالة خطأ
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: dateController,
                                readOnly:
                                true, // اجعل الحقل للعرض فقط لعدم السماح بإدخال يدوي
                                onTap: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate:
                                    DateTime.now(), // يجب تعيين initialDate
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2999),
                                  ).then((value) {
                                    if (value != null) {
                                      // تعيين التاريخ في الحقل بعد الاختيار
                                      dateController.text =
                                          DateFormat.yMMMd().format(value);
                                      print(
                                          'date issssss ${DateFormat.yMMMd().format(value)}');
                                    }
                                  }).catchError((onError) {
                                    print('errrrrrrrrrrror $onError');
                                  });
                                },
                                decoration: const InputDecoration(
                                  prefix: Padding(
                                    padding: EdgeInsets.only(right: 10.0),
                                    child: Icon(Icons.date_range),
                                  ),
                                  border: OutlineInputBorder(),
                                  fillColor: Colors.white,
                                  filled: true,
                                  labelText: 'Date',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Date must not be empty';
                                  }
                                  return null; // إذا كان الحقل صحيحًا، لا تعرض أي رسالة خطأ
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextFormField(
                                readOnly: true,
                                controller: timeController,
                                keyboardType: TextInputType.number,
                                onTap: () {
                                  showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now())
                                      .then(
                                        (value) {
                                      timeController.text =
                                          value!.format(context);
                                      print(value.format(context));
                                    },
                                  ).catchError((onError) {
                                    print('error $onError');
                                  });
                                },
                                decoration: const InputDecoration(
                                    prefix: Padding(
                                      padding:
                                      const EdgeInsets.only(right: 10.0),
                                      child: Icon(Icons.access_time_outlined),
                                    ),
                                    border: OutlineInputBorder(),
                                    fillColor: Colors.white,
                                    filled: true,
                                    label: Text('Time')),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Time must not be empty';
                                  }
                                  return null; // إذا كان الحقل صحيحًا، لا تعرض أي رسالة خطأ
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    )).closed.then(
                          (value) {

                        cubit.changeBottomSheetState(false, Icons.edit);
                      },
                    );

                    cubit.changeBottomSheetState(true, Icons.add);


                  }
                },
                child:  Icon(cubit.fabIcon),
              ),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: cubit.bnbSelected,
                onTap: (value) {
                  cubit.changeScreen(value);
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.square_stack_3d_up_fill),
                    label: 'Tasks',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.check_circle_outline_sharp),
                    label: 'Done',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.archive_outlined),
                    label: 'Archive',
                  ),
                ],
              ),
            );
          },

      )
    );
  }


}
