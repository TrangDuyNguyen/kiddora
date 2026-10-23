# Sổ Theo Dõi Yêu Cầu Thay Đổi Nghiệp Vụ (Change Request Log) — Kiddora

Tài liệu này ghi nhận toàn bộ các yêu cầu thay đổi (CR) về phạm vi, thiết kế, quy chuẩn mã nguồn hoặc kiến trúc được phê duyệt giữa PO, PM, Tech Lead, BA và QA.

| Mã CR | Ngày Đề Xuất | Người Đề Xuất | Phân Hệ Ảnh Hưởng | Mô Tả Thay Đổi | Lý Do Nghiệp Vụ / Kỹ Thuật | Trạng Thái |
| :--- | :---: | :---: | :---: | :--- | :--- | :---: |
| **CR-001** | 2026-10-20 | Sub-Agent PO | Onboarding / Profile | Bổ sung đầy đủ 12 Linh vật 3D Con Giáp và Age Wheel Spinner 6-12 | Cá nhân hóa cảm xúc sâu sắc cho trẻ em Á Đông, giảm 70% thời gian nhập liệu | **Approved (v0.2.0)** |
| **CR-002** | 2026-10-22 | Sub-Agent Tech Lead | Core / Clean Code | Triệt tiêu 100% Magic Numbers, xóa Emojis trong code, tập trung hóa AppStrings & AppColors | Tuân thủ nghiêm ngặt chuẩn Ponytail Clean Code, chuẩn bị hỗ trợ đa ngôn ngữ i18n | **Approved (v0.3.0)** |
| **CR-003** | 2026-10-22 | Sub-Agent PO & UI/UX | Design System | Bóc tách toàn diện 57 màn hình benchmark độ nét cao từ Dribbble qua 14 Domains | Thiết lập kim chỉ nam thị giác 1:1, ngăn chặn phân mảnh thiết kế | **Approved (v0.3.0)** |
| **CR-004** | 2026-10-22 | Sub-Agent PM | Project Governance | Chuyển đổi toàn diện hệ thống tài liệu quản trị theo chuẩn Agile Docs-as-Code | Minh bạch tiến độ từng Sprint, có doc tính năng và doc dự án cho mọi đợt báo cáo | **Approved (v0.4.0)** |
| **CR-005** | 2026-10-22 | Sub-Agent Tech Lead & User | Backend / Infrastructure | Chuyển đổi toàn diện kiến trúc Backend sang Professional Self-Hosted Stack: FastAPI + PostgreSQL 16 + Redis 7 + MinIO (S3) + LiveKit (WebRTC) + Caddy + FCM Direct, tổ chức theo chuẩn Feature-First Modular Monolith đồng bộ 1:1 với Flutter | Kiểm soát 100% dữ liệu, chi phí $0 dev/test trên localhost, xây dựng năng lực BE chuyên nghiệp cho Flutter engineer | **Approved (ADR-004)** |
