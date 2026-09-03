import 'dart:async';
import 'dart:io';
import 'package:authbase_mobile/components/Colors.dart';
import 'package:authbase_mobile/models/task_info.dart';
import 'package:authbase_mobile/views/component/task/take_picture_design.dart';
import 'package:authbase_mobile/views/splash/task/splash_screen.dart';
import 'package:authbase_mobile/views/task/task_view_model.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

// 写真を撮る画面
class TakePictureView extends StatefulWidget {
  final TaskViewModel viewModel;
  final String selectedTaskId;

  const TakePictureView({
    super.key,
    required this.viewModel,
    required this.selectedTaskId,
  });

  @override
  State<TakePictureView> createState() => _TakePictureView();
}

class _TakePictureView extends State<TakePictureView> {
  late TaskInfo lavelTask;
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  late String imagePath;

  @override
  void initState() {
    super.initState();

    // タスクの名前を取得
    lavelTask = widget.viewModel.taskList.firstWhere(
      (t) => t.taskId == widget.selectedTaskId,
    );

    checkCamera();
  }

  Future<void> checkCamera() async {
    try {
      final cameras = await availableCameras();

      // カメラが存在しない場合の処理
      if (cameras.isEmpty) {
        _showCameraError('カメラの権限をONにしてください');
        return;
      }

      final firstCamera = cameras.first;
      _controller = CameraController(firstCamera, ResolutionPreset.medium);

      // 初期化エラーをキャッチ
      _initializeControllerFuture = _controller?.initialize().catchError((
        error,
      ) {
        _showCameraError('カメラの初期化に失敗しました');
        return Future.error(error);
      });

      setState(() {});
    } on CameraException catch (e) {
      // カメラ固有のエラーを処理
      _showCameraError('カメラエラー: ${e.description}');
    } catch (e) {
      // 予期しないエラーを処理
      _showCameraError('予期しないエラーが発生しました');
    }
  }

  // ユーザーにエラーを通知するメソッド
  Future<void> _showCameraError(String message) async {
    if (mounted) {
      await showDialog(
        context: context,
        barrierColor: Colors.transparent,
        builder: (_) {
          Future.delayed(const Duration(seconds: 3), () {
            Navigator.of(context).pop();
          });
          return Center(
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  message,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        },
      );

      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    // ウィジェットが破棄されたら、コントローラーを破棄
    _controller?.dispose();
    super.dispose();
  }

  // 完了したタスクの写真を撮る画面
  @override
  Widget build(BuildContext context) {
    return TakePictureDesign(
      viewModel: widget.viewModel,
      taskName: lavelTask.taskName,
      lavelText: "完了した場所の写真を撮ろう！！",
      imgContainer: _imgContainer,
      buttomBtn: _buttomBtn,
    );
  }

  // 写真撮影の画像を表示する部分
  Widget _imgContainer() {
    if (_initializeControllerFuture == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        // ✅ エラー状態をチェック
        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'カメラが利用できません\n\n${snapshot.error}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14, color: Colors.red),
                  ),
                ),
              ],
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return CameraPreview(_controller!);
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  // 撮影ボタン
  Widget _buttomBtn() {
    return GestureDetector(
      onTap: () async {
        // 写真を撮る
        final image = await _controller?.takePicture();
        // 画像のパスを格納
        imagePath = image!.path;
        // モーダル表示
        _buildShowDialog();
      },
      child: Container(
        height: 64,
        width: 64,
        margin: EdgeInsets.only(top: 32),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.white,
          border: Border.all(color: AppColors.subBackground, width: 6),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 3),
            ),
          ],
        ),
      ),
    );
  }

  // 撮影後のモーダル
  Future<void> _buildShowDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.subWhiteBackground,
              borderRadius: BorderRadius.circular(5),
            ),
            padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "この写真でよろしいですか？",
                  style: TextStyle(fontSize: 16, fontFamily: 'textFont'),
                ),
                SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: AppColors.subWhiteBackground,
                  ),
                  // ignore: unnecessary_null_comparison
                  child: (imagePath != null)
                      ? Image.file(File(imagePath), fit: BoxFit.cover)
                      : Text("写真取得に失敗しました。"),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // 両端に寄せる
                  children: [
                    SizedBox(
                      width: 114,
                      child: ElevatedButton(
                        onPressed: () => {Navigator.pop(context)},
                        style: ElevatedButton.styleFrom(
                          foregroundColor: AppColors.subWhiteBackground,
                          backgroundColor: AppColors.subBackground,
                          elevation: 4, // 影の高さ
                          shadowColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'textFont',
                          ),
                        ),
                        child: const Text('撮り直す'),
                      ),
                    ),
                    SizedBox(
                      width: 114,
                      child: ElevatedButton(
                        onPressed: () => {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              // ToDO: 設定してるゴミを投げつける相手の名前に変更
                              builder: (context) => TaskAnimationScreen(labelText: "まつえもんさんにゴミを渡しています"),
                            ),
                          ),
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: AppColors.subWhiteBackground,
                          backgroundColor: AppColors.darkBackground,
                          elevation: 4, // 影の高さ
                          shadowColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'textFont',
                          ),
                        ),
                        child: const Text('完了'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
