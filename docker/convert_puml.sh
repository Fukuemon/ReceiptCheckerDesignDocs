#!/bin/bash

# diagramsディレクトリ内のすべてのpumlファイルを処理
find /app/src/diagrams -name "*.puml" | while read puml_file; do
    # src/diagrams内の相対パスを取得
    relative_path="${puml_file#/app/src/diagrams/}"
    # svgファイルの保存先を設定
    svg_file="/app/src/diagrams-svg/${relative_path%.puml}.svg"
    # 保存先ディレクトリを作成（存在しない場合のみ）
    mkdir -p "$(dirname "$svg_file")"
    # pumlファイルをsvgに変換（文字のレイアウト崩れを防ぐために、Noto Sansを指定）
    java -DPLANTUML_LIMIT_SIZE=8192 -Dplantuml.font.notosans="Noto Sans" -jar /usr/local/bin/plantuml.jar -tsvg "$puml_file" -o "$(dirname "$svg_file")"
    echo "Converted $puml_file to $svg_file"
done
