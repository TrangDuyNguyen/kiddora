.PHONY: help setup test check-files build-android build-ios release gen analyze agents

help:
	@echo "======================================================="
	@echo "Kiddora Workspace Management Commands"
	@echo "======================================================="
	@echo "  make setup         : Tải dependencies và cấu hình môi trường"
	@echo "  make gen           : Chạy build_runner sinh mã nguồn Riverpod & AutoRoute"
	@echo "  make analyze       : Chạy flutter analyze kiểm tra 0 lỗi"
	@echo "  make test          : Chạy toàn bộ unit/widget tests"
	@echo "  make check-files   : Kiểm tra độ dài & độ phức tạp file (Ponytail)"
	@echo "  make gates         : Chạy kiểm thử chất lượng qua script gate_pipeline.sh"
	@echo "  make agents        : Khởi động phiên tương tác Multi Sub-Agents"
	@echo "======================================================="

setup:
	flutter pub get

gen:
	dart run build_runner build --delete-conflicting-outputs

analyze:
	flutter analyze

test:
	flutter test

check-files:
	@bash scripts/check_file_length.sh

gates:
	@bash scripts/gate_pipeline.sh

agents:
	@bash scripts/launch_agent_session.sh all

agent-techlead:
	@bash scripts/launch_agent_session.sh tech-lead

agent-dev:
	@bash scripts/launch_agent_session.sh dev
