#!/bin/bash
set -e
UNITY_OVERRIDE="$1"

run_unity() {
  local unity_exec="$1"
  echo "⏳ Running Unity: $unity_exec"
  "$unity_exec" -batchmode -nographics -quit -projectPath . -executeMethod BuildScript.BuildAndroid -logFile /dev/stdout
  return $?
}

if [ -n "$UNITY_OVERRIDE" ] && [ -x "$UNITY_OVERRIDE" ]; then
  if run_unity "$UNITY_OVERRIDE"; then
    echo "✅ Built with override Unity"
    exit 0
  fi
fi

candidates=$(find /Applications/Unity/Hub/Editor -type f -name "Unity" 2>/dev/null || true)
for c in $candidates; do
  if [ -x "$c" ]; then
    if run_unity "$c"; then
      echo "✅ Built with $c"
      exit 0
    fi
  fi
done

for cmd in unity-editor Unity unity; do
  if command -v $cmd >/dev/null 2>&1; then
    if run_unity "$(command -v $cmd)"; then
      echo "✅ Built with $(command -v $cmd)"
      exit 0
    fi
  fi
done

echo "❌ Could not build: no working Unity executable found or build failed."
exit 1
