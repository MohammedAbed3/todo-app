import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:untitled2/Modules/ShopApp/Login/ShopLoginScreen.dart';
import 'package:untitled2/shared/Components/components.dart';

import '../../../shared/Styles/colors.dart';

class OnBoardingScreen extends StatefulWidget {


  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var pageViewController = PageController();

  List<PageViewModel> modelList = [
    PageViewModel(
        image: 'assets/images/onboarding.png',
        titel: 'Welcome',
        description: 'Shop App Easy Shop'),
    PageViewModel(
        image: 'assets/images/onboarding.png',
        titel: 'Welcome 2',
        description: 'Shop App Easy Shop'),
    PageViewModel(
        image: 'assets/images/onboarding.png',
        titel: 'Welcome 3',
        description: 'Shop App Easy Shop'),
  ];

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: () {
            navgetToKill(context,  ShopLoginScreen());
          }, child: const Text('SKIP',
            style: TextStyle(
              color: primaryColor
            ),

          ))
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (index) {
                  if(index == modelList.length - 1){
                    print('lastt');

                    setState(() {
                      isLast =true;

                    });
                  }else{
                    setState(() {
                      isLast = false;

                    });
                  }
                },
                physics: BouncingScrollPhysics(),
                controller: pageViewController,
                  itemBuilder: (context, index) => PageViewItem(modelList[index]),
                  itemCount: modelList.length,
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  effect:const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: primaryColor,
                    dotWidth: 10,
                    expansionFactor: 4,
                    dotHeight: 10
                  ),
                    controller: pageViewController,
                    count: modelList.length),
                const Spacer(),
                FloatingActionButton(onPressed: () {

                  if(isLast){
                    navgetToKill(context, ShopLoginScreen());
                  }else{
                    pageViewController.nextPage(
                        duration: const Duration(
                            milliseconds: 750
                        ),
                        curve: Curves.easeInOutCubicEmphasized);
                  }


                },

                  child: const Icon(Icons.arrow_forward_ios_sharp,color: Colors.white,),
                )
              ],
            )

          ],
        ),
      ),

    );
  }
}

class PageViewModel{

  String image;
  String titel;
  String description;

  PageViewModel({required this.image,required this.titel,required this.description});
}

Widget PageViewItem (PageViewModel model)=>Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [


    Image.asset(model.image),
    const SizedBox(height: 40,),
    Text('${model.titel}',
    style:const TextStyle(
      fontSize: 35,


    ),),
    Text('${model.description}',
      style:const TextStyle(
        fontSize: 20,


      ),),




  ],
);
