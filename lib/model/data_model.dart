class DataModel {
  String name;
  String email;
  String body;

  DataModel({required this.name, required this.body, required this.email});

  Map<String, dynamic> toMap() {
    return {'name': name, 'email': email, 'body': body};
  }
}
