# Gate 0: Architecture Decision Record (ADR-005)
## Chi Phí & Lộ Trình Song Ngữ (Bilingual UI Strategy & AppStrings Architecture)

- **Mã tài liệu**: `ADR-005`
- **Tác giả**: Sub-Agent Tech Lead & System Architect — *"The Pragmatic System Architect"*
- **Phê duyệt**: Sub-Agent PO — *"The Strategic Tyrant"*
- **Trạng thái**: **APPROVED**
- **Ngày**: 2026-10-30

---

## 1. Bối Cảnh & Động Lực (Context & Forces)

Tại cuộc họp Căn chỉnh Sprint 5 (29/10/2026), PO đã phê duyệt quyết định chiến lược P1: đưa song ngữ Việt–Anh vào lộ trình từ Sprint 5 để chuẩn bị mở rộng người dùng quốc tế và hỗ trợ học tập đa ngôn ngữ.

### Dữ Liệu Đo Đạc Hiện Tại
- Chuỗi hằng số tập trung tại `AppStrings` (`lib/core/constants/app_strings.dart`): ~370 dòng, ~250 hằng số.
- Số lượng file và widget đang tiêu thụ `AppStrings`: 36 files, 194 lượt gọi trực tiếp.
- Hiện trạng: Toàn bộ `AppStrings` là `static const String`, được gọi trực tiếp mà không cần truyền `BuildContext`.
- Hệ thống kiểm thử hiện hành: 83 widget tests đều đang dùng `find.text(...)` đối sánh trực tiếp với chuỗi trong `AppStrings`.

---

## 2. So Sánh Các Giải Pháp Kiến Trúc (Options Evaluated)

| Tiêu Chí | Phương Án 1: Flutter `gen-l10n` + `.arb` toàn diện | Phương Án 2: Lai `gen-l10n` cho Sprint 5 | Phương Án 3 (Được chọn): Tokenized `AppStrings` + English Fallback |
| :--- | :--- | :--- | :--- |
| **Cách tiếp cận** | Di chuyển toàn bộ ~250 chuỗi sang `intl_vi.arb` & `intl_en.arb`, refactor 36 files sang `AppLocalizations.of(context)`. | Giữ chuỗi cũ, chỉ tạo ARB cho các màn Sprint 5. | Giữ `AppStrings` làm Single Source of Truth (SSOT), bổ sung bảng tra cứu song ngữ và hằng số tiếng Anh tương ứng. |
| **Tác động tới 83 tests cũ** | ❌ Phá vỡ toàn bộ 83 tests (lỗi thiếu Localizations delegate trong pumpWidget). | ⚠️ Phân mảnh kiến trúc, 2 cách dùng chuỗi song song. | 🟢 100% 83 tests pass nguyên vẹn, zero breaking changes. |
| **Chi phí Story Points** | ❌ 6–8 SP (Vượt ngân sách Sprint 5). | ❌ 3–4 SP. | 🟢 0 SP phát sinh ngoài ngân sách 23 SP đã cam kết. |
| **Tuân thủ Ponytail (YAGNI)** | ❌ Over-engineering cho giai đoạn MVP. | ❌ Nửa vời. | 🟢 Tinh gọn, đáp ứng ngay lập tức, chuyển đổi mượt mà. |

---

## 3. Quyết Định Kiến Trúc (Decision)

1. **Giai đoạn Sprint 5**:
   - Duy trì `AppStrings` làm nguồn tập trung duy nhất cho mọi chuỗi văn bản của ứng dụng.
   - Các màn hình Sprint 5 (Domain 04 & Domain 05) được định nghĩa đầy đủ 100% chuỗi tại `AppStrings`.
   - Với các thành phần trực quan cần thể hiện nguyên bản tiếng Anh theo benchmark Dribbble (VD: banner *"A Brighter Future Starts Here!"*, môn học *"Science"*, *"Math"*, *"Arts"*, cấp độ *"Beginner"*, *"Intermediate"*, *"Advanced"*), `AppStrings` cung cấp cả hai cặp hằng số rõ ràng để UI tùy biến phù hợp với ngữ cảnh trẻ em Việt Nam hoặc quốc tế.
2. **Lộ trình Chuyển Đổi Tự Động (Sprint 5.5 / Sprint 6)**:
   - Sẽ triển khai công cụ sinh tự động file ARB từ `AppStrings` khi có màn hình Cài đặt Đổi Ngôn ngữ (Language Switcher) tại Domain 13 (Settings).
   - Kiểm thử tự động sẽ sử dụng `find.text(AppStrings.xxx)` để đảm bảo kiểm thử chạy đúng ở bất kỳ ngôn ngữ nào mà không cần sửa code test.

---

## 4. Hệ Quả & Trách Nhiệm (Consequences & Ownership)

- **Tech Lead**: Đảm bảo 100% chuỗi của Sprint 5 được khai báo tại `AppStrings`, 0 hardcoded text.
- **Dev FE**: Tuân thủ triệt để việc import và sử dụng `AppStrings`.
- **QA Tester**: Viết test assertions dựa trên `AppStrings.*` để test luôn đồng bộ và miễn nhiễm với việc tinh chỉnh ngôn ngữ.

