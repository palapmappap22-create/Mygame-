#!/bin/bash
set -e

# دالة لبناء المشروع
build_project() {
  echo "🔄 المحاولة مع Unity version: $1"
  unity-editor -projectPath . -buildTarget Android -quit -batchmode -nographics -logFile build.log     -executeMethod BuildScript.BuildAndroid || return 1
}

# قائمة نسخ Unity المحتملة (يختار أي وحدة متاحة)
UNITY_VERSIONS=("2022.3.0f1" "2021.3.0f1" "2020.3.0f1")

for version in "${UNITY_VERSIONS[@]}"; do
  if build_project "$version"; then
    echo "✅ تم البناء بنجاح باستخدام Unity $version"
    exit 0
  fi
done

echo "❌ فشل البناء بكل النسخ المتاحة"
exit 1
