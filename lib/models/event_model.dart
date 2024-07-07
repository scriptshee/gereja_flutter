class EventModel {
  int? id;
  String? thumbnail;
  String? title;
  String? description;
  String? content;
  String? startDatetime;
  dynamic endDatetime;
  bool? isEndedtime;
  int? userId;
  String? createdAt;
  String? updatedAt;

  EventModel({
    this.id,
    this.thumbnail,
    this.title,
    this.description,
    this.content,
    this.startDatetime,
    this.endDatetime,
    this.isEndedtime,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'],
      thumbnail: json['thumbnail'],
      title: json['title'],
      description: json['description'],
      content: json['content'],
      startDatetime: json['start_datetime'],
      endDatetime: json['end_datetime'],
      isEndedtime: json['is_endedtime'],
      userId: json['user_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'thumbnail': thumbnail,
      'title': title,
      'description': description,
      'content': content,
      'startDatetime': startDatetime,
      'endDatetime': endDatetime,
      'isEndedtime': isEndedtime,
      'userId': userId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
