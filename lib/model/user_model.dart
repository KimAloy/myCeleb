class UserModel {
  String name;
  String? email;
  String? profileImage;
  List<String>? category;
  int? price;
  int? estimatedDeliveryTime;
  bool isCelebrity;
  // List<Reviews>? reviews;
  String? description;
  // List<Request>? requests;
  int accountBalance;
  String? phoneNumber;

  UserModel({
    required this.isCelebrity,
    this.email,
    required this.name,
    this.profileImage,
    this.category,
    this.price,
    this.estimatedDeliveryTime,
    // this.reviews,
    this.description,
    // this.requests,
    required this.accountBalance,
    this.phoneNumber,
  });
}
