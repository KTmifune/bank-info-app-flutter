class UserBankInfoDetail {
  final int id;
  final int userId;
  final String name;
  final int balance;

  UserBankInfoDetail(
      {required this.id,
      required this.userId,
      required this.name,
      required this.balance});

  factory UserBankInfoDetail.fromJson(Map<dynamic, dynamic> json) {
    return UserBankInfoDetail(
        id: json['id'],
        userId: json['user_id'],
        name: json['name'],
        balance: json['balance']);
  }
}
