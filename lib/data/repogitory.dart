import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user_bank_info_app_flutter/data/model/user.dart';
import 'package:user_bank_info_app_flutter/data/model/user_bank_info_detail.dart';

const String apiKey = '2S7v3LjCId8dd8zVcUFxJ8X9V8SAwrT5bBAckzJJ';
const String authority = 'mfx-recruit-dev.herokuapp.com';

class Repository {
  Future<List<User>> fetchUserList() async {
    const path = 'users';
    try {
      final result = await http.get(Uri.https(authority, path));
      if (result.statusCode != 200) {
        throw "取得に失敗しました。statusCode：${result.statusCode}${result.reasonPhrase}";
      }
      final resultBody =
          const Utf8Decoder(allowMalformed: true).convert(result.bodyBytes);
      final List jsonResult = jsonDecode(resultBody);

      final List<User> userList = [];
      for (var e in jsonResult) {
        userList.add(
            User(id: e['id'], name: e['name'], accountIds: e['account_ids']));
      }

      return userList;
    } catch (error) {
      throw "実行エラー：$error";
    }
  }

  Future<List<UserBankInfoDetail>> fetchUserBankInfoDetail(
      {required int userId}) async {
    final path = 'users' '/$userId' '/accounts';
    try {
      final result = await http.get(Uri.https(authority, path));
      if (result.statusCode != 200) {
        throw "取得に失敗しました。statusCode：${result.statusCode}${result.reasonPhrase}";
      }
      final resultBody =
          const Utf8Decoder(allowMalformed: true).convert(result.bodyBytes);
      final List jsonResult = jsonDecode(resultBody);

      final List<UserBankInfoDetail> userBankInfoList = [];
      for (var e in jsonResult) {
        userBankInfoList.add(UserBankInfoDetail(
            id: e['id'],
            userId: e['user_id'],
            name: e['name'],
            balance: e['balance']));
      }
      return userBankInfoList;
    } catch (error) {
      throw "実行エラー：$error";
    }
  }
}
