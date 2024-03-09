class PostModel {
  final String title;
  final String body;
  final int id;
  final int userId;
  PostModel(
      {required this.id,
      required this.userId,
      required this.title,
      required this.body});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
        title: json['title'],
        body: json['body'],
        id: json['id'],
        userId: json['userId']);
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
      'id': id,
      'userId': userId,
    };
  }
}
