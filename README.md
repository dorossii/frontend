# DOROSSII

> **邪魔し合うから、動ける。**

家事をゲーム要素に変換し、友達との「邪魔し合い」を通して、
楽しみながら最低限の生活習慣を維持できるアプリです。

---

## Overview

DOROSSIIは、一人暮らしを始めた大学生・新社会人を対象にした、自堕落防止アプリです。

家事を後回しにしがちな人でも、ゲーム感覚で家事を続けられる仕組みを提供します。

家事を完了するとポイントを獲得でき、そのポイントを使って友達へ「ゴミ」を送り合うことができます。

ただし、友達が困っている時は邪魔をするだけではありません。
瀕死状態の友達をレスキューすることで、お互いに助け合いながら生活習慣を維持できます。

---

## Background

一人暮らしでは

- 家事を後回しにしてしまう
- 生活習慣が乱れやすい
- 孤独感を感じやすい

という課題があります。

DOROSSIIは「人とのつながり」を利用して、家事を自然と続けられる体験を目指しました。

---

# Features

## Home

- キャラクターの状態を表示
- HP・汚さレベルを管理
- 部屋の状態を確認

---

## Task Management

生活環境に応じて必要な家事を提案します。

家事を完了すると

- 自分の汚さレベルが減少
- 攻撃ポイントを獲得
- フレンドへゴミを送れるようになります。

---

## Task Verification

家事完了時には写真を撮影し、
フレンドが本当に家事をしたかを確認します。

不正があった場合は再度撮影が必要になります。

---

## Friend

- フレンド一覧
- HP・汚さレベル確認
- 状態確認

HPが低いほど部屋が汚れている状態になります。

---

## Rescue

瀕死状態になったフレンドはレスキュー可能です。

通常はゴミを送りますが、
レスキュー中は相手のゴミを回収し、助けることができます。

助けてもらうと通知が届きます。

---

# Character System

| 項目 | 内容 |
|------|------|
| HP | 0〜100 |
| 汚さレベル | 0〜700 |
| 通常 | ゴミを受け取り汚くなる |
| タスク完了 | 汚さレベル減少 |
| レスキュー | ゴミを回収してもらう | 

---

# Tech Stack

## Frontend

- Flutter
- Dart
- Provider

## Backend

- Go
- gRPC

## Other

- Docker
- LiveKit
- Protocol Buffers

---

# Project Structure

```
lib/
├── models/
├── services/
├── view/
├── view_models/
├── widgets/
└── main.dart
```

---

# Getting Started

```bash
git clone https://github.com/your-repository/DOROSSII.git

flutter pub get

flutter run
```

---

# Screenshots

| Home | Tasks | Friends | Rescue |
|------|--------|---------|---------|
| <img width="220" alt="image" src="https://github.com/user-attachments/assets/2383495b-ff73-4678-9cf4-035b7b0ce139" />| <img width="220" alt="image" src="https://github.com/user-attachments/assets/8d3448e6-8d38-4090-9973-eec0c8d83ad7" />| <img width="220" alt="image" src="https://github.com/user-attachments/assets/a7f25beb-9c86-4b02-87c0-9fea2b5e4915" /> | <img width="220" alt="image" src="https://github.com/user-attachments/assets/7c6ac65a-2fb4-4942-b06b-2ced278ca966" />|

※ スクリーンショットを追加予定

---

# Monetization

- UIテーマスキン
- 背景変更
- アイコン変更
- フォント変更
- 日用品レコメンド
- 家事代行・便利家電の紹介

---

# Future Work

- 通知機能
- 実機テスト
- Apple Developer Program対応

---

# Team

**Team：食欲旺盛**

ECCコンピュータ専門学校

---

# Concept

> **邪魔し合うから、動ける。**

「家事 × ゲーム × フレンド」

家事をゲーム要素へ変換し、
友達とのつながりを活用して生活習慣を自然と続けられる世界を目指しています。

---
