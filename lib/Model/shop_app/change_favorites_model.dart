class ChangeFavoritesModel {

  bool? status;
  String? message;
  FavoritesDataModel? favoritesDataModel;

  ChangeFavoritesModel.fromJson(Map<String,dynamic> json){

    status = json['status'];
    message = json['message'];
    favoritesDataModel = json['data'];
  }


}

class FavoritesDataModel{
  int? id;
  FavoritesProductModel? data;

  FavoritesDataModel.fromJson(Map<String,dynamic> json){
    id = json['id'];
    data = json['product'];

  }

}

class FavoritesProductModel{
  int? id;
  dynamic? price;
  dynamic? oldPrice;
  dynamic? discount;
  String? image;

  FavoritesProductModel.fromJson(Map<String,dynamic> json){

   id = json['id'];
   price = json['price'];
   oldPrice = json['old_price'];
   discount = json['discount'];
   image = json['image'];

  }


}