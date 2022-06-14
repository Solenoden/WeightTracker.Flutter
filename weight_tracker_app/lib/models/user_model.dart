class User {
  String? id;
  String? name;
  String? surname;
  String? emailAddress;

  User({this.id, this.name, this.surname, this.emailAddress});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> user = new Map<String, dynamic>();

    user['id'] = this.id;
    user['name'] = this.name;
    user['surname'] = this.surname;
    user['emailAddress'] = this.emailAddress;

    return user;
  }
}