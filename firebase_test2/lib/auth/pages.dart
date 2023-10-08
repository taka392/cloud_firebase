import 'package:firebase_test2/auth/service.dart';
import 'package:firebase_test2/auth/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// ---------------------------------------------------------
/// サインイン画面    >> pages/sign_in.dart
/// ---------------------------------------------------------

/// ---------------------------------------------------------
/// サインイン画面    >> pages/sign_in.dart
/// ---------------------------------------------------------
class SignInPage extends ConsumerWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ボタン
    final button = ElevatedButton(
      onPressed: () async {
        // サービスを呼び出す
        final service = AuthService();
        debugPrint("dd");
        await service.signIn().catchError(
          (e) {
            debugPrint('サインインできませんでした $e');
          },
        );
      },
      child: const Text('サインイン'),
    );

    /// 画面全体
    return Scaffold(
      appBar: AppBar(title: const Text('サインイン画面')),
      body: Center(child: button),
    );
  }
}

/// ---------------------------------------------------------
/// ホーム画面    >> pages/home.dart
/// ---------------------------------------------------------
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ユーザーID
    final userId = ref.watch(userIdProvider);
    final userIdText = Text('ユーザーID: $userId');

    // ボタン
    final button = ElevatedButton(
      onPressed: () async {
        // サービスを呼び出す
        final service = AuthService();
        await service.signOut().catchError(
          (e) {
            debugPrint('サインアウトできませんでした $e');
          },
        );
      },
      child: const Text('サインアウト'),
    );

    // 画面全体
    return Scaffold(
      appBar: AppBar(
        title: const Text('ホーム画面'),
        backgroundColor: Colors.red,
      ),
      body: Center(
        // 縦に並べる
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // テキスト
            userIdText,
            // ボタン
            button,
          ],
        ),
      ),
    );
  }
}
