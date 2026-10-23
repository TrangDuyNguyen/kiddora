.PHONY: help setup test check-files build-android build-ios release gen analyze agents run run-android run-ios devices

help:
	@echo "======================================================="
	@echo "Kiddora Workspace Management Commands"
	@echo "======================================================="
	@echo "  make devices       : Liệt kê các thiết bị và emulator đang kết nối"
	@echo "  make run           : Chạy ứng dụng trên thiết bị mặc định"
	@echo "  make run-android   : Chạy trên Android Emulator hoặc máy thật Android"
	@echo "  make run-ios       : Mở iOS Simulator và chạy trên iOS"
	@echo "  make build-apk     : Build file APK cài trực tiếp lên thiết bị Android"
	@echo "  make build-ios     : Build bundle iOS"
	@echo "  make setup         : Tải dependencies và cấu hình môi trường"
	@echo "  make gen           : Chạy build_runner sinh mã nguồn Riverpod & AutoRoute"
	@echo "  make analyze       : Chạy flutter analyze kiểm tra 0 lỗi"
	@echo "  make test          : Chạy toàn bộ unit/widget tests"
	@echo "  make check-files   : Kiểm tra độ dài & độ phức tạp file (Ponytail)"
	@echo "  make pipeline      : Chạy relay pipeline theo tính năng (make pipeline FEATURE=<name>)"
	@echo "  make dashboard     : Mở Neobrutalism Mission Control web dashboard theo dõi thời gian thực"
	@echo "  make agents        : Khởi động phiên tương tác Multi Sub-Agents"
	@echo "======================================================="

devices:
	flutter devices

run:
	flutter run

run-android:
	flutter run -d android

run-ios:
	@open -a Simulator || true
	flutter run -d ios

build-apk:
	flutter build apk --debug

build-apk-release:
	flutter build apk --release

build-appbundle:
	flutter build appbundle --release

build-ios:
	flutter build ios --no-codesign

setup:
	flutter pub get

gen:
	flutter pub run build_runner build --delete-conflicting-outputs

analyze:
	flutter analyze

test:
	flutter test

check-files:
	@bash scripts/check_file_length.sh

backend-test:
	@if [ -d backend/.venv ]; then \
		PYTHONPATH=backend backend/.venv/bin/pytest backend/tests -v; \
	else \
		PYTHONPATH=backend pytest backend/tests -v; \
	fi

db-migrate:
	@if [ -d backend/.venv ]; then \
		cd backend && .venv/bin/alembic upgrade head; \
	else \
		cd backend && alembic upgrade head; \
	fi

db-rollback:
	@if [ -d backend/.venv ]; then \
		cd backend && .venv/bin/alembic downgrade -1; \
	else \
		cd backend && alembic downgrade -1; \
	fi


# =======================================================
# End-to-End Quality Gate Pipeline (Relay Race Hand-off)
# =======================================================
pipeline:
	@if [ -z "$(FEATURE)" ]; then \
		echo "❌ Vui lòng cung cấp tên tính năng: make pipeline FEATURE=ten-tinh-nang"; \
	else \
		bash scripts/gate_pipeline.sh start "$(FEATURE)"; \
	fi

pipeline-status:
	@bash scripts/gate_pipeline.sh status

pipeline-next:
	@bash scripts/gate_pipeline.sh next

pipeline-reset:
	@bash scripts/gate_pipeline.sh reset

# =======================================================
# Individual Sub-Agent CLI Session Launchers
# =======================================================
agents:
	@bash scripts/launch_agent_session.sh all

agent-tech-lead:
	@bash scripts/launch_agent_session.sh tech-lead

agent-po:
	@bash scripts/launch_agent_session.sh po

agent-ba:
	@bash scripts/launch_agent_session.sh ba

agent-design:
	@bash scripts/launch_agent_session.sh design

agent-dev:
	@bash scripts/launch_agent_session.sh dev

agent-qa:
	@bash scripts/launch_agent_session.sh qa

agent-reviewer:
	@bash scripts/launch_agent_session.sh reviewer

agent-security:
	@bash scripts/launch_agent_session.sh security

agent-pm:
	@bash scripts/launch_agent_session.sh pm

# =======================================================
# Real-Time Visual Neobrutalism Agent Mission Control
# =======================================================
dashboard:
	@bash scripts/dashboard.sh
