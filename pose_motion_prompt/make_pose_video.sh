#!/usr/bin/env bash
# 使い方:
#   ./make_pose_video.sh 生成した動画.mp4 出力.mp4 [全体の秒数=10] [動き出し前の静止秒=1.0]
#
# 生成した動画は「ポーズ → 手を下ろす」の向きを想定。
# 処理: 逆再生 →「手を下げた状態 → ポーズ」にする。
#       最初に静止(動き出しを遅らせる)、最後にポーズを静止して全体を指定秒数に揃える。
# カメラ固定のまま（ズーム・パン無し）。音声は無し。
set -euo pipefail

IN="${1:?入力動画(生成した「ポーズ→手を下ろす」)を指定}"
OUT="${2:?出力ファイル名を指定}"
TOTAL="${3:-10}"
START_HOLD="${4:-1.0}"
FPS=24

DUR=$(ffprobe -v error -show_entries format=duration -of csv=p=0 "$IN")
END_HOLD=$(python3 - "$TOTAL" "$START_HOLD" "$DUR" <<'PY'
import sys
total, start, dur = map(float, sys.argv[1:4])
end = total - start - dur
if end < 0:
    sys.exit("全体の秒数が短すぎます（動画 %.2f 秒 + 静止 %.2f 秒）" % (dur, start))
print("%.3f" % end)
PY
)

ffmpeg -v error -y -i "$IN" \
  -vf "reverse,fps=${FPS},tpad=start_duration=${START_HOLD}:start_mode=clone:stop_duration=${END_HOLD}:stop_mode=clone,format=yuv420p" \
  -an -c:v libx264 -preset slow -crf 15 -movflags +faststart "$OUT"

echo "出力: $OUT  (動画 ${DUR}s + 先頭静止 ${START_HOLD}s + 末尾静止 ${END_HOLD}s = 約${TOTAL}s)"
