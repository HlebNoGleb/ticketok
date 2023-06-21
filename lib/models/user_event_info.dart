class UserEventInfo {

  num id;
  String title;

  UserEventInfo({required this.id, required this.title});

  factory UserEventInfo.fromJson(Map <String, dynamic> json) => UserEventInfo(
    id: json['id'],
    title: json['title']
  );
}