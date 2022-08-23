import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:user_bank_info_app_flutter/data/model/user.dart';
import 'package:user_bank_info_app_flutter/data/model/user_bank_info_detail.dart';
import 'package:user_bank_info_app_flutter/data/repogitory.dart';

final userBankInfoDetailProvider =
    FutureProvider.family<List<UserBankInfoDetail>, int>((ref, userId) async {
  final data = await Repository().fetchUserBankInfoDetail(userId: userId);
  return data;
});

class UserBankInfoDetailScreen extends ConsumerWidget {
  const UserBankInfoDetailScreen({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<UserBankInfoDetail>> userBankInfoList =
        ref.watch(userBankInfoDetailProvider(user.id));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail"),
      ),
      body: Center(
        child: userBankInfoList.when(
            data: (bankInfo) {
              return userBankInfoDetailBody(bankInfo);
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

  Widget userBankInfoDetailBody(List<UserBankInfoDetail> bankInfo) {
    var totalBalance = 0;
    for (var element in bankInfo) {
      totalBalance += element.balance;
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "User:",
                  style: TextStyle(color: Colors.black, fontSize: 18.0),
                ),
                Text(
                  user.name,
                  style: const TextStyle(color: Colors.black, fontSize: 18.0),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total:",
                  style: TextStyle(color: Colors.black, fontSize: 18.0),
                ),
                Text(
                  '${NumberFormat("#,###").format(totalBalance)}円',
                  style: const TextStyle(color: Colors.black, fontSize: 18.0),
                )
              ],
            ),
            const SizedBox(
              height: 100,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: bankInfo.length,
              itemBuilder: (BuildContext context, int index) {
                if (bankInfo.isEmpty) {
                  return const Text("登録している銀行はありません。");
                }
                return bankInfoTile(bankInfo[index]);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget bankInfoTile(UserBankInfoDetail bankInfo) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              bankInfo.name,
              style: const TextStyle(color: Colors.black, fontSize: 18.0),
            ),
            Text(
              '${NumberFormat("#,###").format(bankInfo.balance)}円',
              style: const TextStyle(color: Colors.black, fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}
