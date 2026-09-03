import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/Colors.dart';
import '../../components/extensions/user_view_model.dart';
import 'user/setting_user_view.dart';
import 'target/target_view_screen.dart';

class SettingsView extends StatelessWidget {
  final VoidCallback onLogoutPressed;

  const SettingsView({super.key, required this.onLogoutPressed});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<UserViewModel>();
    return Scaffold(
      backgroundColor: AppColors.subWhiteBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            children: [
              _buildCard(
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.getBackgroundColor(vm.bgColors),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Image(
                          image: AssetImage('images/icons/${vm.userIcon}.png',),
                          width: 48,
                          height: 48,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            vm.userName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'textFont',
                              color: AppColors.text,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            vm.birthDate,
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'textFont',
                              color: AppColors.text,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildPillButton(
                      icon: Icons.edit,
                      label: '編集',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileEditView(
                              initialName: vm.userName,
                              birthday: vm.birthDate,
                              initialBgColor: AppColors.getBackgroundColor(vm.bgColors),
                              initialIconPath: 'images/icons/${vm.userIcon}.png',
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              _buildCard(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '生活環境',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'textFont',
                              color: AppColors.text,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Center(
                            child: Text(
                              vm.livingType,
                              style: const TextStyle(
                                fontSize: 20,
                                fontFamily: 'textFont',
                                fontWeight: FontWeight.w500,
                                color: AppColors.text,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildPillButton(
                      icon: Icons.sync,
                      label: '変更',
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 3. フレンド設定
              _buildCard(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.people_outline,
                      size: 32,
                      color: AppColors.text,
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Text(
                        'フレンド設定',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'textFont',
                          fontWeight: FontWeight.bold,
                          color: AppColors.text,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: AppColors.background,
                      size: 24,
                    ),
                  ],
                ),
                onTap: () {
                },
              ),
              const SizedBox(height: 16),

              // 嫌がらせのターゲット変更
              _buildCard(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.delete_outline_rounded,
                      size: 32,
                      color: AppColors.text,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '嫌がらせのターゲット変更',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.text,
                              fontFamily: 'textFont',
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'タスクを完了した際に自分のゴミを渡すフレンドを変更します。',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.text.withOpacity(0.8),
                              fontFamily: 'textFont',
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: AppColors.background,
                      size: 24,
                    ),
                  ],
                ),
                onTap: () {
  // ターゲット変更画面に遷移
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const TargetListScreen(),
    ),
  );
},
              ),
              const SizedBox(height: 48),

              // 5. ログアウトボタン
              SizedBox(
                width: 140,
                height: 40,
                child: ElevatedButton(
                  onPressed: onLogoutPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.subBackground,
                    foregroundColor: AppColors.text,
                    elevation: 4,
                    shadowColor: Colors.black.withOpacity(0.3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'ログアウト',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'textFont',
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // カードの共通コンポーネント
  Widget _buildCard({
    required Widget child,
    EdgeInsetsGeometry? padding,
    VoidCallback? onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.subWhiteBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          // 下だけ影をつける
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            // 下方向に影をつける
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: padding ?? const EdgeInsets.all(20),
            child: child,
          ),
        ),
      ),
    );
  }

  // 「編集」「変更」のカプセル型ボタン
  Widget _buildPillButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 16, color: Colors.white), // アイコンの色を白に設定
      label: Text(
        label,
        style: const TextStyle(
          color: AppColors.text,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.subBackground,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
