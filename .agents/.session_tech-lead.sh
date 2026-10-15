# AstroBite Sub-Agent Session Init
export WORKSPACE_DIR="/Users/nguyenduytrang/flutter_project/AstroBite"
export AGENT_ROLE="tech-lead"
export AGENT_TITLE="Tech Lead __TITLE__ System Architect"
export AGENT_TIER="Tier S (Claude Opus 4.6 Thinking / Sonnet Thinking)"
export AGENT_GATES="Gate 0 (Tech Spike/ADR) __GATES__ Gate 1/2 Feasibility Sign-Off"
export AGENT_SKILL=".agents/skills/tech-lead/SKILL.md"

cd "$WORKSPACE_DIR"

# Banner hiển thị
clear
printf "\033[1;36m================================================================================\033[0m\n"
printf " ✨ \033[1mASTROBITE MULTI-AGENT WORKSPACE\033[0m — [\033[1;33m%s\033[0m]\n" "$AGENT_TITLE"
printf "\033[1;36m================================================================================\033[0m\n"
printf " 🤖 \033[1mAI Model Tier:\033[0m     %s\n" "$AGENT_TIER"
printf " 🚪 \033[1mGate Phụ Trách:\033[0m    %s\n" "$AGENT_GATES"
printf " 📜 \033[1mSkill Directive:\033[0m   %s\n" "$AGENT_SKILL"
printf "\033[1;36m--------------------------------------------------------------------------------\033[0m\n"
printf " 💡 \033[1;32mLệnh hỗ trợ trong phiên:\033[0m\n"
printf "    • \033[1mask \"<prompt>\"\033[0m    : Gửi yêu cầu tới agent (tự nạp Skill Directive & AGENTS.md)\n"
printf "    • \033[1mskill\033[0m              : Đọc toàn văn hướng dẫn & quy chuẩn của agent này\n"
printf "    • \033[1mgates\033[0m              : Xem tiêu chuẩn và điều kiện cấm du di của các Gate\n"
printf "    • \033[1mcheck-code\033[0m         : Chạy kiểm tra chuẩn Ponytail & độ dài file\n"
printf "\033[1;36m================================================================================\033[0m\n\n"

# Helper functions
ask() {
  if [[ $# -eq 0 ]]; then
    printf "\033[1;31m❌ Vui lòng nhập câu hỏi hoặc nhiệm vụ: ask \"<nhiệm vụ>\"\033[0m\n"
    return 1
  fi
  printf "\033[1;34m[AstroBite Agent] 🚀 Đang gửi yêu cầu tới %s...\033[0m\n" "$AGENT_TITLE"
  agy-ide chat -a "$WORKSPACE_DIR/$AGENT_SKILL" -a "$WORKSPACE_DIR/AGENTS.md" "$*"
}

skill() {
  if command -v bat &>/dev/null; then
    bat "$WORKSPACE_DIR/$AGENT_SKILL"
  else
    cat "$WORKSPACE_DIR/$AGENT_SKILL"
  fi
}

gates() {
  printf "\033[1;33m=== TRÍCH XUẤT TIÊU CHUẨN CỔNG TỪ AGENTS.md ===\033[0m\n"
  grep -A 10 -E "Chốt Chặn [0-7]" "$WORKSPACE_DIR/AGENTS.md" | head -n 35
}

check-code() {
  make check-files
}

# Đổi prompt terminal để nhận diện agent
export PS1="\[\033[1;35m\]astrobite\[\033[0m\]:\[\033[1;33m\]$AGENT_ROLE\[\033[0m\]$ "
