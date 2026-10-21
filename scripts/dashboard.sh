#!/usr/bin/env bash
# ==============================================================================
# Launcher for Antigravity Neobrutalism Agent Mission Control
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKSPACE_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
SERVER_PY="${SCRIPT_DIR}/dashboard_server.py"

if ! command -v python3 &> /dev/null; then
    echo "❌ Lỗi: Cần có Python 3 để chạy Mission Control Dashboard."
    exit 1
fi

# Khởi chạy python local server (tự động phát hiện port khả dụng và mở trình duyệt chính xác)
exec python3 "${SERVER_PY}" "${WORKSPACE_DIR}" --open
