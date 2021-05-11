class Request {
  String? id;
  DateTime? createdTime;
  String? celebrityName;
  String requestFromName;
  String requestForName;
  String message;
  String requestDate;
  String requesterProfilePicture;
  bool isCompleted;
  String? fanProfileImage;
  String fanEmail;

  Request({
    this.id,
    required this.createdTime,
    required this.celebrityName,
    required this.requestFromName,
    required this.requestForName,
    required this.message,
    required this.requestDate,
    required this.requesterProfilePicture,
    required this.fanEmail,
    this.fanProfileImage,
    this.isCompleted = false,
  });
}

class RequestField {
  static const createdTime = 'createdTime';
}
