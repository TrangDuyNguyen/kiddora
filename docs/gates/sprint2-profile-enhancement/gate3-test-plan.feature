# Gate 3: Master Test Plan & BDD Gherkin Feature Matrix
## Feature: Sprint 2 — Kid Profile Setup Enhancement (US-04-v2)
**QA Lead**: Sub-Agent QA/QC Tester — *"The Paranoid Inquisitor"*  
**Verdict**: **TEST DESIGN APPROVED (100% Traceability)**  
**Date**: 2026-10-22  

---

## 🎯 1. Phân Tích Giá Trị Biên & Phân Vùng Tương Đương (EP & BVA)

### 1.1. Biên Độ Tuổi (Age Spinner Boundary Analysis)
| Trường dữ liệu | Giá trị kiểm thử | Loại kiểm thử | Kết quả mong đợi |
| :--- | :---: | :---: | :--- |
| `selectedAge` | `5` | Lỗi dưới biên (Invalid Min-1) | Bị chặn, bánh xe chỉ dừng tối thiểu ở 6 |
| `selectedAge` | `6` | Biên dưới hợp lệ (Valid Min) | Chấp nhận, hiển thị nhãn Chuẩn bị vào Lớp 1 |
| `selectedAge` | `8` | Giá trị trung tâm mặc định | Chấp nhận, hiển thị nhãn Lớp 3 |
| `selectedAge` | `12` | Biên trên hợp lệ (Valid Max) | Chấp nhận, hiển thị nhãn Lớp 7 |
| `selectedAge` | `13` | Lỗi trên biên (Invalid Max+1) | Bị chặn, bánh xe chỉ dừng tối đa ở 12 |

### 1.2. Biên Độ Dài Biệt Danh (Nickname Length Boundary Analysis)
| Trường dữ liệu | Giá trị kiểm thử | Loại kiểm thử | Nút CTA |
| :--- | :--- | :---: | :---: |
| `nickname` | `""` (Rỗng) | Dưới biên | Disabled (Mờ) |
| `nickname` | `"A"` (1 ký tự) | Dưới biên | Disabled (Mờ) |
| `nickname` | `"Bo"` (2 ký tự) | Biên dưới hợp lệ | **Active (Sáng)** |
| `nickname` | `"Bắp Của Mẹ Yêu"` (14 ký tự) | Giữa khoảng | **Active (Sáng)** |
| `nickname` | `"1234567890123456"` (16 ký tự) | Biên trên hợp lệ | **Active (Sáng)** |
| `nickname` | `"12345678901234567"` (17 ký tự) | Trên biên | Bị cắt ngắn về 16 ký tự |

---

## 🧪 2. Kịch Bản Kiểm Thử Chi Tiết (BDD Gherkin Scenarios)

```gherkin
Feature: Kiểm Thử Toàn Diện Màn Hình Thiết Lập Hồ Sơ Bé US-04-v2

  Background:
    Given người dùng đang ở màn hình Thiết Lập Hồ Sơ Bé
    And bộ nhớ SharedPreferences đã được khởi tạo sạch

  Scenario Outline: Chọn độ tuổi trên bánh xe Clay Wheel Spinner
    When người dùng cuộn bánh xe tuổi đến "<age>"
    Then bánh xe hiển thị "<age> tuổi" ở vị trí trung tâm
    And nhãn lộ trình hiển thị đúng "<curriculum_label>"
    And giá trị selectedAge trong state là <age_int>

    Examples:
      | age | curriculum_label                                              | age_int |
      | 6   | 🌱 Chuẩn bị vào Lớp 1: Làm quen chữ số & Đố vui nhận thức    | 6       |
      | 8   | 🧩 Lớp 3: Toán tư duy nhân chia & Lớp học trực tuyến          | 8       |
      | 10  | 🏆 Lớp 5: Thử thách khoa học & Chinh phục đỉnh cao            | 10      |
      | 12  | 🧠 Lớp 7: Tư duy logic phức hợp & Tinh hoa kiến thức          | 12      |

  Scenario: Chọn nhanh biệt danh từ Quick Nickname Chip
    When người dùng bấm vào chip "Bắp"
    Then ô nhập tên được điền chữ "Bắp"
    And nút "Sẵn sàng khám phá!" chuyển sang trạng thái kích hoạt

  Scenario: Đổi ngẫu nhiên biệt danh bằng nút Xúc Xắc
    When người dùng bấm nút Xúc Xắc
    Then ô nhập tên nhận một giá trị không rỗng có độ dài >= 2
    And nút "Sẵn sàng khám phá!" chuyển sang trạng thái kích hoạt

  Scenario Outline: Chọn linh vật mascot 3D không có viền hộp vuông
    When người dùng bấm chọn linh vật "<avatar_id>"
    Then bệ linh vật "<avatar_id>" được chọn với viền sáng và dấu check
    And giá trị selectedAvatarId là "<avatar_id>"

    Examples:
      | avatar_id |
      | lion      |
      | bear      |
      | dino      |
      | bunny     |

  Scenario: Hoàn tất lưu hồ sơ và chuyển sang HomeScreen
    Given ô tên đã được điền "Alex"
    And tuổi được chọn là 8
    And linh vật được chọn là "lion"
    When người dùng nhấn nút "Sẵn sàng khám phá!"
    Then trạng thái isCompleted chuyển sang true
    And dữ liệu KidProfile được ghi xuống SharedPreferences
    And hệ thống điều hướng người dùng tới HomeRoute
```

---

## 🛡️ KẾT LUẬN GATE 3: BÀN GIAO CHO DEV FE
Bộ test plan đã được bao phủ $100\%$ các luồng nghiệp vụ và giá trị biên. Sub-Agent QA Tester chính thức bàn giao cho Sub-Agent Dev FE triển khai mã nguồn tại Gate 4!
