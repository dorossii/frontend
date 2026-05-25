import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../../../../components/colors.dart';
import '../../app.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int selectedIndex = 0;
  Timer? _animationTimer;
  Timer? _milkTimer;

  bool isMilkUp = false;

  final List<String> messages = [
    '誰も見てない部屋ほど、自分が見えてるんだよ？',
    '明日やる、って昨日も言ってたよね。',
    '床に置いた瞬間、それ家になるの？',
    'ちょっとだけ、が一番片付くんだよ。',
    '一人だからって、自分を雑に扱わなくていいんだよ。',
    'ゴミって、急に増えたんじゃなくて見ないふりしてただけかも。',
    '部屋って、今の自分が出るらしいよ。',
    'その服、本当にまた着るの？',
    '片付けない部屋って、気持ちまで置きっぱなしになるんだ。',
    '未来の自分に丸投げしすぎじゃない？',
    '洗い物って、放置するほど怖くなるの不思議だね。',
    '床に物置くの好きだね…床かわいそう。',
    '1個捨てるだけでも、ちゃんと前進だよ。',
    '自由って、散らかしていいって意味じゃないんだね。',
    '帰ってきて散らかってる部屋、ちょっと悲しくない？',
    '洗濯物の山って、見ないふり得意だよね。',
    '自分の部屋くらい、自分に優しくしてあげよ？',
    'そのゴミ、明日の自分も見たくないと思うな。',
    '片付けると、部屋が広いんじゃなくて余白が戻るんだ。',
    'カップ麺のゴミ、机の飾りじゃないよ？',
    '誰も怒らないけど、誰も片付けてくれないんだよ。',
    '後でやる、って万能ワードじゃないよ？',
    '見えない場所ほど、本性出るんだって。',
    'ゴミ袋いっぱいって、頑張った証拠だね。',
    '疲れてる時ほど、部屋に引っ張られるんだね。',
    'シンクに皿ためるの、育成ゲームじゃないよ？',
    '散らかってるのって、忙しいじゃなくて後回しかもね。',
    '部屋が汚いと、休んでても休んだ気しないね。',
    '今日の5分が、明日の自分を助けるんだよ？',
    '服の山って、椅子じゃないんだけどなぁ。',
    '少し整うだけで、ちょっと優しくなれるよ。',
    '冷蔵庫の奥、何か育ててない？',
    '使ったら戻す、それだけなのに難しいね。',
    '捨てると、案外困らないんだよね。',
    'また使うかも、って意外と来ないんだよ。',
    '散らかった部屋って、思ってるより気力削るんだね。',
    '誰も来なくても、自分は毎日ここに帰るんだよ。',
    '物を減らすと、考えることも少し減るよ。',
    'その“あとで”が山になるんだよ？',
    '自分しか住んでなくても、自分はちゃんと住人だよ。',
    '置きっぱなしって、気持ちまで止まりそうだね。',
    '生活って、こういう小さいことの積み重ねなんだね。',
    '片付いた部屋って、少しだけ心まで静かになるんだ。',
    '迷って置いてる物って、ずっと場所取ってるんだよ。',
    '今日の自分、未来の自分に優しくできそう？',
  ];

  late String currentMessage;

  @override
  void initState() {
    super.initState();

    currentMessage = messages[Random().nextInt(messages.length)];

    _startAnimation();
    _startMilkFloat();
    _goNext();
  }

  /// 上の4つアイコン
  void _startAnimation() {
    _animationTimer = Timer.periodic(const Duration(milliseconds: 450), (_) {
      if (!mounted) return;

      setState(() {
        selectedIndex = (selectedIndex + 1) % 4;
      });
    });
  }

  /// 吹き出し + milk ふわふわ
  void _startMilkFloat() {
    _milkTimer = Timer.periodic(const Duration(milliseconds: 800), (_) {
      if (!mounted) return;

      setState(() {
        isMilkUp = !isMilkUp;
      });
    });
  }

  /// 3秒後ホームへ
  void _goNext() {
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const App()),
      );
    });
  }

  @override
  void dispose() {
    _animationTimer?.cancel();
    _milkTimer?.cancel();
    super.dispose();
  }

  Widget _buildAnimatedItem(int index, String imagePath) {
    final isSelected = selectedIndex == index;

    return AnimatedScale(
      scale: isSelected ? 1.3 : 0.85,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Image.asset(imagePath, width: 55, height: 55),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 2),

            /// 上4つアイコン
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildAnimatedItem(0, 'images/splash/trash_blue.webp'),
                _buildAnimatedItem(1, 'images/splash/trash_green.webp'),
                _buildAnimatedItem(2, 'images/splash/trash_red.webp'),
                _buildAnimatedItem(3, 'images/splash/trash_yellow.webp'),
              ],
            ),

            const SizedBox(height: 40),

            /// Loading
            Column(
              children: const [
                GradientText(
                  'loading...',
                  gradient: AppColors.goldGradient,
                  style: TextStyle(
                    fontFamily: 'LogoFont',
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        offset: Offset(0, 3),
                        blurRadius: 5,
                        color: Colors.black26,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
              ],
            ),

            const Spacer(),

            /// 吹き出し + milk
            AnimatedSlide(
              offset: isMilkUp ? const Offset(0, -0.04) : const Offset(0, 0.04),
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeInOut,
              child: AnimatedScale(
                scale: isMilkUp ? 1.03 : 0.97,
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeInOut,
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      /// 吹き出し
                      Padding(
                        padding: const EdgeInsets.only(left: 50, right: 70),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 14,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                    color: Colors.black12,
                                  ),
                                ],
                              ),
                              child: Text(
                                currentMessage,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'TextFont',
                                  color: AppColors.text,
                                ),
                              ),
                            ),

                            /// 中央から右下へ斜めしっぽ
                            Align(
                              alignment: Alignment.center,
                              child: CustomPaint(
                                size: const Size(26, 18),
                                painter: BubbleTailPainter(),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 6),

                      /// milk 右寄せ
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Image.asset(
                          'images/splash/milk.webp',
                          width: 150,
                          height: 150,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class BubbleTailPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path();

    /// 上左
    path.moveTo(0, 0);

    /// 上右
    path.lineTo(size.width, 0);

    /// 右下（milk方向）
    path.lineTo(size.width * 1.8, size.height * 1.7);

    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
