# Quy Tắc Đồng Bộ Hóa Tài Liệu Bắt Buộc (Continuous Doc-Sync & Zero Drift)

> **Nguyên tắc Tối Cao Của Dự Án Kiddora**:  
> *"Mỗi khi có bất kỳ sự thay đổi nào về tính năng (logic, UI, routing, state, parameters, validation, data model hoặc scope), BẮT BUỘC phải cập nhật đồng thời vào tài liệu trong cùng phiên làm việc."*

---

## 🎯 1. Kích Hoạt & Phạm Vi Áp Dụng (Mandatory Triggers)
Mọi AI Sub-Agent và trợ lý lập trình (Dev FE, BA, PM, PO, QA, Tech Lead) **bắt buộc tuân thủ** quy tắc này khi thực hiện:
1. Thêm mới, chỉnh sửa hoặc xóa bất kỳ màn hình (Screen/Page) hay widget nào.
2. Thay đổi luồng nghiệp vụ (Business Flow), điều hướng (Routing), hoặc điều kiện rẽ nhánh (Guards).
3. Thêm/sửa trường dữ liệu trong Entity, DTO hoặc Local Storage.
4. Điều chỉnh giao diện, bo góc, màu sắc hoặc trạng thái UI (UI States).
5. Sửa lỗi logic (Bug Fix) ảnh hưởng đến hành vi người dùng.

---

## 📋 2. Ma Trận Cập Nhật Tài Liệu Bắt Buộc (Sync Checklist)

Khi thay đổi code, Sub-Agent phải thực hiện kiểm tra và cập nhật các file tài liệu sau:

| Loại Thay Đổi | Tài Liệu Bắt Buộc Cập Nhật | Nội Dung Cần Đồng Bộ |
| :--- | :--- | :--- |
| **Logic nghiệp vụ / Quy tắc người dùng** | `docs/03-prd-features/<feature>/prd-*.md` & `user-stories.md` | Cập nhật mục tiêu, kịch bản BDD `Given-When-Then`, Acceptance Criteria. |
| **Giao diện / Tokens / 5 UI States** | `docs/03-prd-features/<feature>/ui-ux-screen-specs.md` | Cập nhật layout spec, tokens màu sắc, padding, hiệu ứng xúc giác. |
| **Dữ liệu thực thể / Entity Fields** | `docs/04-specifications/data-dictionary.md` | Thêm/sửa tên trường, kiểu dữ liệu, ràng buộc giá trị hợp lệ. |
| **Kiến trúc / Thư viện / Tech Stack** | `docs/04-specifications/adr/adr-*.md` | Ban hành hoặc bổ sung Quyết định Kiến trúc của Tech Lead. |
| **Phạm vi Sprint / Phân rã Task** | `docs/00-project-management/wbs-task-matrix.md` & `sprint-backlog.md` | Cập nhật trạng thái task (`[x] DONE`), Story Points, DoD. |
| **Yêu cầu thay đổi phạm vi / Tính năng** | `docs/05-change-management/change-request-log.md` | Ghi nhận mã CR mới, người đề xuất, lý do và trạng thái phê duyệt. |
| **Phát hành phiên bản mới** | `docs/05-change-management/release-v*.md` & `00-roadmap/product-roadmap.md` | Công bố Release Notes và nâng phiên bản trên Roadmap 3 Chân trời. |

---

## 🚫 3. Điều Cấm Tuyệt Đối (Zero-Tolerance Violations)
1. **Cấm Báo Cáo Xong Khi Chưa Cập Nhật Doc**: Tuyệt đối không được báo cáo cho người dùng rằng tính năng đã hoàn thành ("DONE") nếu tài liệu trong `docs/03-prd-features/` chưa phản ánh đúng mã nguồn thực tế.
2. **Cấm Doc-Code Drift (Lệch Pha)**: Không để xảy ra tình trạng code chạy một đằng (ví dụ: đã đổi dải tuổi thành 6-12) nhưng tài liệu vẫn ghi cái cũ (dải tuổi 7-10).
3. **Cấm Viết Doc Ảo (Ghost Documentation)**: Mọi mô tả trong PRD/BDD phải tương ứng với code đã hoặc đang được triển khai, có gắn nhãn trạng thái minh bạch (`Planned`, `In Progress`, `Completed`).
