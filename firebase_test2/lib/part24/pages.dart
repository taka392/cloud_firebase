import 'package:firebase_test2/part24/service.dart';
import 'package:firebase_test2/part24/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sign_in_button/sign_in_button.dart';

/// ---------------------------------------------------------
/// サインイン画面    >> pages/sign_in.dart
/// ---------------------------------------------------------
class SignInPage extends ConsumerWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ボタン
    final button = SizedBox(
      width: 200,
      height: 30,
      child: SignInButton(Buttons.google, onPressed: () {
        final service = AuthService();
        service.signInWithGoogle();
/*        final router = ref.watch(routerProvider);
        router.go(
          PagePath.home,
        );*/
      }),
    );

    /// 画面全体
    return Scaffold(
      appBar: AppBar(title: const Text('サインイン画面')),
      body: button,
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
