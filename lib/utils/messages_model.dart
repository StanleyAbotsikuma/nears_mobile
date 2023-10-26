class Messages {
  String? id;
  String? name;
  String? message;
  String? date;
  String? sender;
  int? level;
  bool? view;

  Messages(
      {this.id,
      this.name,
      this.message,
      this.date,
      this.sender,
      this.level,
      this.view});

  Messages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    message = json['message'];
    date = json['date'];
    sender = json['sender'];
    level = json['level'];
    view = json['view'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['message'] = message;
    data['date'] = date;
    data['sender'] = sender;
    data['level'] = level;
    data['view'] = view;
    return data;
  }
}
