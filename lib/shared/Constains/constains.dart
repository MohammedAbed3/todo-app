import 'package:untitled2/Modules/ShopApp/Login/ShopLoginScreen.dart';
import 'package:untitled2/shared/Components/components.dart';
import 'package:untitled2/shared/Networks/local/CacheHelper.dart';

void signOutShopApp(context){

  CacheHelper.removeDate(key: 'token',).then((value) {
    print('token delet Succuse ');
    navgetToKill(context, ShopLoginScreen());
  },);
}

String? token = '';