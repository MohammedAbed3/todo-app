import 'package:flutter/material.dart';

class calculateScareen extends StatelessWidget {

  bool isMale;
  double heigth;
  int bim;


  calculateScareen({super.key,
    required this.isMale,
  required this.heigth,
  required this.bim
  });


  @override
  Widget build(BuildContext context) {
    print('hhhhhh$bim');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('RESALTE'),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            Text('Gender :${isMale ? 'male':'female' }',
            style: const TextStyle(
              fontSize: 35,
            ),
            ),
            Text('hitgit :${heigth.round()} ',
              style: const TextStyle(
                fontSize: 35,
              ),),
            Text('BIM Calculate : $bim',
              style: const TextStyle(
                fontSize: 35,
              ),),

          ],

        ),
      ),
    );


  }
}
