class News {
  int? id;
  String? thumbnail;
  String? title;
  String? content;
  int? userId;
  String? userName;
  String? publishedDate;

  News({
    this.id,
    this.thumbnail,
    this.title,
    this.content,
    this.userId,
    this.userName,
    this.publishedDate,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['id'],
      thumbnail: json['thumbnail'],
      title: json['title'],
      content: json['content'],
      userId: json['user']['id'],
      userName: json['user']['name'],
      publishedDate: json['published_date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'thumbnail': thumbnail,
      'title': title,
      'content': content,
      'userId': userId,
      'userName': userName,
      'publishedDate': publishedDate
    };
  }
}
