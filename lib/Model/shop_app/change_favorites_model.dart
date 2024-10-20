class ChangeFavoritesModel {
  bool? status;
  String? message;

  ChangeFavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] as bool?;
    message = json['message'] as String?;

  }
}

