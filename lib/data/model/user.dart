class User {
  final int id;
  final String name;
  final List<dynamic> accountIds;

  User({required this.id, required this.name, required this.accountIds});

  factory User.fromJson(Map<dynamic, dynamic> json) {
    return User(
        id: json['id'], name: json['name'], accountIds: json['account_ids']);
  }
}
