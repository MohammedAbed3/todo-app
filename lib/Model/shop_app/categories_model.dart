class CategoriesModel{

  bool? status;
  CategoriesDataModel? data;

  CategoriesModel.fromJson(Map<String,dynamic> json){

    status = json['status'];
    data = json['data'] !=null ? CategoriesDataModel.fromJson(json['data']) : null;
  }
}

class CategoriesDataModel{

  int? current_page;

  List<CategoriesData> data = [];

  CategoriesDataModel.fromJson(Map<String,dynamic> json){

    current_page = json['current_page'];
     json['data'].forEach((e){
       data.add(CategoriesData.fromJson(e));
     });
  }


}

class CategoriesData{
  int? id;
  String? name;
  String? image;

  CategoriesData.fromJson(Map <String,dynamic> json){

    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

}