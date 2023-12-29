// review_model.dart
class Review {
  final String userId;
  final String username;
  final String movieId;
  final String subject;
  final String detail;

  Review({
    required this.userId,
    required this.username,
    required this.movieId,
    required this.subject,
    required this.detail,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      userId: json['userId'],
      username: json['username'],
      movieId: json['movieId'],
      subject: json['subject'],
      detail: json['detail'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'username': username,
      'movieId': movieId,
      'subject': subject,
      'detail': detail,
    };
  }
}
