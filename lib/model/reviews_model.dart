class Reviews {
  final String? id;
  final String celebrityName;
  final String fanName;
  final double rating;
  final String? message;

  Reviews({
    this.id,
    required this.celebrityName,
    required this.fanName,
    required this.rating,
    this.message,
  });
}
