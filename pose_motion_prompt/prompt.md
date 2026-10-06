# 手を下げた状態 → ポーズ になる動画の指示（プロンプト）

使い方: 動画生成AI（Kling など）に「開始画像 = 完成ポーズの画像」を渡し、下の英語プロンプトを貼る。
動画は「ポーズ → 手を下ろす」で生成し、`make_pose_video.sh` で時間を逆再生して
「手を下げた状態 → ポーズ」にする（最後のコマが元の画像のポーズと一致し、顔が崩れにくい）。

## プロンプト（英語・そのまま貼る）

Static locked-off camera, no zoom, no pan, no cuts. Everyone starts in the pose shown in the image and then slowly and
smoothly lowers their hands and arms down to a relaxed, neutral position, hands hanging naturally at their sides
(crouching people rest their hands on their knees). All six people move in perfect unison: they all begin lowering their
hands at exactly the same moment, move at the same speed, and all reach the neutral position at exactly the same moment,
like a synchronized, choreographed group action. No one starts earlier or later than the others, and no one lags behind.
Nobody changes position. Faces, expressions, hairstyles and the
gaze toward the camera stay exactly the same and unchanged for the entire clip. Clothing, background, lighting and
framing stay fixed. No text, no logos, no camera movement.

## ネガティブ（使える場合）

camera movement, zoom, face change, different person, morphing face, blur on face, extra people, text, logo, flicker, staggered timing, people moving at different times, someone moving earlier or later than the others

## 日本語版（意味の確認用）

カメラは完全固定（ズーム・パン・カット無し）。全員が画像のポーズから、ゆっくり滑らかに手と腕を下ろし、
自然に力を抜いた状態（しゃがんでいる人は膝に手を置く）になる。**全員が完全に同時に**手を下ろし始め、同じ速さで動き、
同じ瞬間に下ろし終える（振り付けされた一斉の動き。誰も先走ったり遅れたりしない）。立ち位置は変えない。顔・表情・髪型・カメラ目線は
最初から最後まで一切変えない。服・背景・光・構図も固定。文字・ロゴ・カメラの動きは入れない。

## 推奨設定

- 生成の長さ: 5秒前後（モデルの上限に合わせる）→ 後処理で約10秒にする
- 解像度: 1080p 以上、画像と同じ縦横比に近いもの（4:3 が無ければ 16:9 で生成し、後で比率を確認）
- 顔を絶対に変えたくない場合: 完成した動画の「最後のコマ」だけが元画像と一致するので、
  動き出し（手を下げた状態）の顔の違いが気になるときは、顔の貼り戻し（元画像の顔を各コマに合成）を別途行う

## 動きのタイミングをそろえるコツ（全員同時にするために）

- プロンプトに「完全に同時（in perfect unison）」と明記する（上記に入れてある）。
- 動画生成は5秒前後の短い長さで行う。長くすると人ごとにタイミングがずれやすい。
- ずれが出たら、同じプロンプトで複数本（3〜4本）生成して、いちばんそろっているものを選ぶ。
- 1本ずつ動きの開始コマを見て、そろっている動画を選んでから `make_pose_video.sh` で逆再生する。
  （逆再生すると「下ろす」が「上げる」になるので、下ろし始めの遅れは、そのまま上げ終わりの遅れになる）
