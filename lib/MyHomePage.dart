import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/calculateScareen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isMale = true;
  double heigth = 150;
  int age = 19;
  int whigte = 60;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('BIM Calculator',
        style: TextStyle(
          color: Colors.white
        ),
        ),


      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(

              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isMale = true;
                      });

                    },
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(

                        color: isMale ? Colors.amber :  Colors.grey,
                        borderRadius: const BorderRadius.all(Radius.circular(20))
                      ),
                      child: const Column(
                        children: [
                          Icon(Icons.male,
                            size: 150,
                          ),
                          Text('Male',
                          style: TextStyle(
                            fontSize: 30
                          ),)
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {

                      setState(() {
                        isMale = false;
                      });
                    },
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                  
                          color: !isMale ? Colors.amber : Colors.grey,
                          borderRadius: const BorderRadius.all(Radius.circular(20))
                      ),
                      child: const Column(
                        children: [
                          Icon(Icons.female,
                            size: 150,
                          ),
                          Text('Female',
                            style: TextStyle(
                                fontSize: 30
                            ),)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(

                decoration: const BoxDecoration(
                  color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(20))


                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Heigth',
                    style: TextStyle(
                      fontSize: 40,
                    ),),
                     Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline:TextBaseline.alphabetic ,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${heigth.round()}',
                          style: const TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold
                          ),),
                        const Text('CM',
                          style: TextStyle(
                            fontSize: 30,
                          ),),
                      ],
                    ),
                    Slider(
                      value: heigth,
                      max: 220,
                      min: 50,
                      onChanged: (value) {
                        setState(() {
                          heigth = value;
                        });

                      },)
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all( 15),
              child: Row(
                children: [
                  Expanded(
                    child: Container(

                      decoration: const BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(20))


                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                           const Text('Age',
                            style: TextStyle(
                              fontSize: 40,
                            ),),
                           Text('$age',
                            style: const TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold
                            ),),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              FloatingActionButton(onPressed: () {

                                setState(() {
                                  age++;
                                });
                              },
                              heroTag:'age+' ,
                              child: const Icon(CupertinoIcons.plus),
                              ),
                              const SizedBox(width: 20,),
                              FloatingActionButton(onPressed: () {

                                setState(() {
                                  age--;
                                });
                              },
                                  heroTag:'age-',
                                child: const Icon(CupertinoIcons.minus)
                              ),
                            ],
                          ),


                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 15,),
                  Expanded(
                    child: Container(

                      decoration: const BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(20))


                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           const Text('whigth',
                            style: TextStyle(
                              fontSize: 40,
                            ),),
                           Text('$whigte',
                            style: const TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold
                            ),),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              FloatingActionButton(onPressed: () {


                                setState(() {
                                  whigte++;
                                });
                              },
                                heroTag:'whigte+' ,
                                child: const Icon(CupertinoIcons.plus),
                              ),
                              const SizedBox(width: 20,),
                               FloatingActionButton(onPressed: () {

                                 setState(() {
                                   whigte--;
                                 });
                              },
                                  heroTag:'whigte-',
                                  child: const Icon(CupertinoIcons.minus)
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 70,
            decoration:const BoxDecoration(
              color: Colors.pink
            ),

            child: MaterialButton(onPressed: () {

              double bim2 = whigte/pow(heigth/100,2 );
              Navigator.push(context, MaterialPageRoute(builder: (context) => calculateScareen(isMale: isMale, heigth: heigth, bim: bim2.round(),),));

            },
            child: const Text('Calculate',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),

            ),
            ),
          )

        ],
      ),
    );
  }
}
