class UserEvent {

  num id;
  String title;

  UserEvent({required this.id, required this.title});

  factory UserEvent.fromJson(Map <String, dynamic> json) => UserEvent(
    id: json['id'],
    title: json['title'],
    // events: json['events'],
  );
}