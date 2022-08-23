import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_bank_info_app_flutter/data/model/user.dart';
import 'package:user_bank_info_app_flutter/data/repogitory.dart';
import 'package:user_bank_info_app_flutter/screen/user_bank_info_detail_screen.dart';

final userListProvider = FutureProvider<List<User>>((ref) async {
  //final List<User> data = await Repository().fetchUserList();
  final data = await Repository().fetchUserList();
  return data;
});

class UserListScreen extends ConsumerWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<User>> userList = ref.watch(userListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("User"),
      ),
      body: Center(
        child: userList.when(
            data: (userList) {
              return userListBody(userList);
            },
            error: (error, stack) => Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text("$error"),
                  ),
                ),
            loading: () => const CircularProgressIndicator()),
      ),
    );
  }

  Widget userListBody(List<User> data) {
    return Center(
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          if (data.isEmpty) {
            return const Text("ユーザーはまだいません。");
          }
          return userNameTile(context, data[index]);
        },
      ),
    );
  }

  Widget userNameTile(BuildContext context, User user) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
      child: ListTile(
        title: Text(
          user.name,
          style: const TextStyle(color: Colors.black, fontSize: 18.0),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return UserBankInfoDetailScreen(user: user);
              },
            ),
          );
        },
      ),
    );
  }
}
