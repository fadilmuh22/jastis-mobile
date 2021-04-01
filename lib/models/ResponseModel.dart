part of 'models.dart';

class ResponseModel<T> {
  ResponseModel({
    this.success,
    this.message,
    this.token,
  });

  bool success;
  String message;
  String token;
  T data;

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        success: json["success"],
        message: json["message"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "token": token,
      };
}
