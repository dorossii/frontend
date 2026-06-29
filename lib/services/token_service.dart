// JWT（JSON Web Token）の生成ライブラリをインポートする
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
// LiveKit の接続設定（APIキー・シークレット）を参照するためにインポートする
import '../config/livekit_config.dart';

// LiveKit 接続用アクセストークンをクライアント側で生成するサービスクラス
class TokenService {
  /// LiveKit用のアクセストークンをクライアント側で生成する
  ///
  /// [roomName]       : 参加するルームの名前
  /// [participantName]: ルーム内での表示名（JWT の sub クレームに設定される）
  /// [ttl]            : トークンの有効期限（デフォルト6時間）
  static String generate({
    required String roomName,
    required String participantName,
    // トークンの有効期限。デフォルトは6時間
    Duration ttl = const Duration(hours: 6),
  }) {
    // LiveKit が要求する JWT ペイロードを組み立てる
    final jwt = JWT(
      {
        // 発行者（iss）: LiveKit API キーを指定する
        'iss': LiveKitConfig.apiKey,
        // サブジェクト（sub）: 参加者の識別名（表示名）を指定する
        'sub': participantName,
        // Not Before（nbf）: このトークンが有効になるUNIX時刻（現在時刻）
        'nbf': DateTime.now().millisecondsSinceEpoch ~/ 1000,
        // Expiration（exp）: このトークンが失効するUNIX時刻（現在時刻 + ttl）
        'exp':
            DateTime.now().add(ttl).millisecondsSinceEpoch ~/ 1000,
        // LiveKit 独自のビデオ権限クレーム
        'video': {
          // このトークンでルームへの参加を許可する
          'roomJoin': true,
          // 参加するルーム名を指定する
          'room': roomName,
          // 映像・音声トラックの送信（パブリッシュ）を許可する
          'canPublish': true,
          // 他参加者のトラックの受信（サブスクライブ）を許可する
          'canSubscribe': true,
        },
      },
    );

    // HMAC-SHA256 アルゴリズムで API シークレットを使って JWT に署名し文字列として返す
    return jwt.sign(
      SecretKey(LiveKitConfig.apiSecret),
      algorithm: JWTAlgorithm.HS256,
    );
  }
}
