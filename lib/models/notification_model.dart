class NotificationModel {
  int? id;
  String? title;
  String? context;
  int? pin;
  String? created;

  NotificationModel({
    this.id,
    this.title,
    this.context,
    this.pin,
    this.created,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      title: json['title'],
      context: json['context'],
      pin: json['is_pin'],
      created: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'context': context,
      'pin': pin,
      'created_at': created
    };
  }
}
