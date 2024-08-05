import 'package:gereja_flutter/models/event_model.dart';

class AttendaceModel {
  int? id;
  int? eventId;
  EventModel? event;
  String? eventStart;
  String? endDatetime;

  AttendaceModel({
    this.id,
    this.eventId,
    this.event,
    this.eventStart,
    this.endDatetime,
  });

  factory AttendaceModel.fromJson(Map<String, dynamic> json) {
    return AttendaceModel(
      id: json['id'],
      eventId: json['event_id'],
      event: json['event'] as EventModel,
      eventStart: json['event_start'],
      endDatetime: json['end_datetime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'event_id': eventId,
      'event': event,
      'event_start': eventStart,
      'end_datetime': endDatetime
    };
  }
}
