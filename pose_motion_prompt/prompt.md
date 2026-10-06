# 手を下げた状態 → ポーズ になる動画の指示（プロンプト）

使い方: 動画生成AI（Kling など）に「開始画像 = 完成ポーズの画像」を渡し、下の英語プロンプトを貼る。
動画は「ポーズ → 手を下ろす」で生成し、`make_pose_video.sh` で時間を逆再生して
「手を下げた状態 → ポーズ」にする（最後のコマが元の画像のポーズと一致し、顔が崩れにくい）。

## プロンプト（英語・そのまま貼る）

Static locked-off camera, no zoom, no pan, no cuts. Everyone starts in the pose shown in the image and then slowly and
smoothly lowers their hands and arms down to a relaxed, neutral position, hands hanging naturally at their sides
(crouching people rest their hands on their knees). Nobody changes position. Faces, expressions, hairstyles and the
gaze toward the camera stay exactly the same and unchanged for the entire clip. Clothing, background, lighting and
framing stay fixed. No text, no logos, no camera movement.

## ネガティブ（使える場合）

camera movement, zoom, face change, different person, morphing face, blur on face, extra people, text, logo, flicker

## 日本語版（意味の確認用）

カメラは完全固定（ズーム・パン・カット無し）。全員が画像のポーズから、ゆっくり滑らかに手と腕を下ろし、
自然に力を抜いた状態（しゃがんでいる人は膝に手を置く）になる。立ち位置は変えない。顔・表情・髪型・カメラ目線は
最初から最後まで一切変えない。服・背景・光・構図も固定。文字・ロゴ・カメラの動きは入れない。

## 推奨設定

- 生成の長さ: 5秒前後（モデルの上限に合わせる）→ 後処理で約10秒にする
- 解像度: 1080p 以上、画像と同じ縦横比に近いもの（4:3 が無ければ 16:9 で生成し、後で比率を確認）
- 顔を絶対に変えたくない場合: 完成した動画の「最後のコマ」だけが元画像と一致するので、
  動き出し（手を下げた状態）の顔の違いが気になるときは、顔の貼り戻し（元画像の顔を各コマに合成）を別途行う
