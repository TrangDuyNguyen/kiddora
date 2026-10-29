#!/usr/bin/env bash
# ==============================================================================
# Launcher for Antigravity Neobrutalism Agent Mission Control
# ==============================================================================

set -euo pipefail

export PYTHONUTF8=1

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKSPACE_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
SERVER_PY="${SCRIPT_DIR}/dashboard_server.py"

PY_CMD=""
if command -v python3 &> /dev/null && python3 -c "import sys" &> /dev/null; then
    PY_CMD="python3"
elif command -v python &> /dev/null && python -c "import sys" &> /dev/null; then
    PY_CMD="python"
else
    echo "❌ Lỗi: Cần có Python 3 để chạy Mission Control Dashboard."
    exit 1
fi

# Khởi chạy python local server (tự động phát hiện port khả dụng và mở trình duyệt chính xác)
exec "${PY_CMD}" "${SERVER_PY}" "${WORKSPACE_DIR}" --open
