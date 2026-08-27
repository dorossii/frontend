import 'package:flutter/material.dart';
import '../../../components/colors.dart';
import '../../../components/widgets/app_header.dart';
import '../../app.dart';
import 'setting_user_view_model.dart';

class ProfileEditView extends StatefulWidget {
  final String initialName;
  final String birthday;
  final Color initialBgColor;
  final String initialIconPath;

  const ProfileEditView({
    super.key,
    required this.initialName,
    required this.birthday,
    required this.initialBgColor,
    required this.initialIconPath,
  });

  @override
  State<ProfileEditView> createState() => _ProfileEditViewState();
}

class _ProfileEditViewState extends State<ProfileEditView> {
  // ViewModelのインスタンス
  final ProfileEditViewModel _viewModel = ProfileEditViewModel();

  late TextEditingController _nameController;
  late Color _selectedBgColor;
  late String _selectedIconPath;
  bool _isLoading = false; 

  final List<Color> _colorOptions = const [
    AppColors.icon1,
    AppColors.icon2,
    AppColors.icon3,
    AppColors.icon4,
    AppColors.icon5,
    AppColors.icon6,
    AppColors.icon7,
    AppColors.icon8,
  ];

  late final List<Map<String, String>> _iconOptions;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
    _selectedBgColor = widget.initialBgColor;
    _selectedIconPath = widget.initialIconPath;

    _iconOptions = [
      {'label': '現在のアイコン', 'path': widget.initialIconPath},
      {'label': 'ティッシュ', 'path': 'images/icons/tissue.png'},
      {'label': 'コントローラー', 'path': 'images/icons/game.png'},
      {'label': 'サボテン', 'path': 'images/icons/cactus.png'},
      {'label': '宇宙ニャンコ', 'path': 'images/icons/rocketCat.png'},
      {'label': 'お花', 'path': 'images/icons/flower.png'},
      {'label': 'トリ', 'path': 'images/icons/bird.png'},
      {'label': 'カフェ', 'path': 'images/icons/cafe.png'},
      {'label': 'PC', 'path': 'images/icons/pc.png'},
      {'label': '松', 'path': 'images/icons/pineTree.png'},
      {'label': '宇宙', 'path': 'images/icons/space.png'},
    ];
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  // 保存処理の実行
  void _onSave() async {
    final updatedName = _nameController.text.trim();

    if (updatedName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('名前を入力してください')),
      );
      return;
    }

    setState(() {
      _isLoading = true; // ボタン連打防止＆ぐるぐる表示
    });

    // ViewModel経由でPUTリクエストを実行
    final success = await _viewModel.saveProfile(
      name: updatedName,
      iconPath: _selectedIconPath,
      bgColor: _selectedBgColor,
    );

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('プロフィールを更新しました')),
      );
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('更新に失敗しました')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const darkTextColor = Color(0xFF1E3A34);
    const double fieldWidth = 280.0; // 入力ボックスの横幅

    return Scaffold(
      appBar: AppHeader(currentPage: PageType.setting),
      backgroundColor: AppColors.subWhiteBackground,
      body: SafeArea(
        child: Column(
          children: [
            // 左上の戻るボタンエリア
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 12, top: 8, bottom: 4),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: darkTextColor,
                    size: 28,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),

            // メインコンテンツエリア
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // 1. プレビュー表示
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: _selectedBgColor,
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        _selectedIconPath,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.person, size: 54, color: Colors.white);
                        },
                      ),
                    ),
                    const SizedBox(height: 16),

                    // 2. 名前入力（SizedBoxで幅を制限）
                    SizedBox(
                      width: fieldWidth,
                      child: Column(
                        children: [
                          _buildInputLabel('名前', '8文字以内'),
                          const SizedBox(height: 6),
                          TextField(
                            controller: _nameController,
                            maxLength: 8,
                            style: const TextStyle(
                              color: darkTextColor,
                              fontSize: 16,
                              fontFamily: 'textFont',
                            ),
                            decoration: InputDecoration(
                              counterText: '',
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Color(0xFF1E3A34), width: 1.5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Color(0xFF1E3A34), width: 2),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // 3. 誕生日（SizedBoxで幅を制限）
                    SizedBox(
                      width: fieldWidth,
                      child: Column(
                        children: [
                          _buildInputLabel('誕生日', '変更不可'),
                          const SizedBox(height: 6),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: const Color(0xFF1E3A34), width: 1.5),
                            ),
                            child: Text(
                              widget.birthday,
                              style: const TextStyle(
                                fontSize: 16,
                                color: darkTextColor,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'textFont',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),

                    // 4. 背景色選択
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'アイコンの背景色',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: darkTextColor,
                          fontFamily: 'textFont',
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 48,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _colorOptions.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 10),
                        itemBuilder: (context, index) {
                          final color = _colorOptions[index];
                          final isSelected = _selectedBgColor == color;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedBgColor = color;
                              });
                            },
                            child: Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: color,
                                shape: BoxShape.circle,
                                border: isSelected
                                    ? Border.all(color: darkTextColor, width: 3)
                                    : null,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Divider(color: Colors.black26, thickness: 1),
                    const SizedBox(height: 20),

                    // 5. アイコン選択グリッド
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 0.85,
                      ),
                      itemCount: _iconOptions.length,
                      itemBuilder: (context, index) {
                        final iconData = _iconOptions[index];
                        final isSelected = _selectedIconPath == iconData['path'];

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedIconPath = iconData['path']!;
                            });
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: _selectedBgColor,
                                  shape: BoxShape.circle,
                                  border: isSelected
                                      ? Border.all(color: darkTextColor, width: 3)
                                      : null,
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Image.asset(
                                      iconData['path']!,
                                      fit: BoxFit.contain,
                                      errorBuilder: (context, error, stackTrace) {
                                        return const Icon(Icons.stars, color: Colors.white, size: 48);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                iconData['label']!,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: darkTextColor,
                                  fontFamily: 'textFont',
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            // 保存ボタンエリア
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              color: AppColors.subWhiteBackground,
              child: Center(
                child: SizedBox(
                  width: 180,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _onSave, // 通信中は押せないように制御
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF005A54),
                      foregroundColor: Colors.white,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.5,
                            ),
                          )
                        : const Text(
                            '保存',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'textFont',
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.0,
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputLabel(String label, String subLabel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            fontFamily: 'textFont',
            color: Color(0xFF1E3A34),
          ),
        ),
        Text(
          subLabel,
          style: const TextStyle(
            fontSize: 12,
            fontFamily: 'textFont',
            color: Color(0xFF1E3A34),
          ),
        ),
      ],
    );
  }
}