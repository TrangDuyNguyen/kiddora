# Gate 3: Master Test Plan & BDD Gherkin Test Scenarios
# Feature: Sprint 1 — Onboarding & Kid Profile Identity
# QA Lead: Sub-Agent QA/QC Tester — "The Paranoid Inquisitor"
# Status: APPROVED

@sprint1 @onboarding @kid_profile
Feature: Toàn Bộ Kịch Bản Kiểm Thử Chức Năng & Phi Chức Năng Sprint 1

  Background:
    Given ứng dụng Kiddora đã được cài đặt trên thiết bị
    And bộ nhớ ứng dụng ở trạng thái ban đầu sạch sẽ

  # =========================================================================
  # NHÓM 1: KIỂM THỬ TRẢI NGHIỆM ONBOARDING 3 BƯỚC (US-03)
  # =========================================================================

  @smoke @happy_path
  Scenario: TC-ONB-01: Người dùng trượt qua tuần tự 3 slide Onboarding thành công
    Given cờ 'has_completed_onboarding' trong SharedPreferences là false
    When ứng dụng khởi chạy
    Then màn hình Onboarding hiển thị Slide 1
    And tiêu đề chứa "Fun Learning for a Brighter Tomorrow"
    And ảnh minh họa cậu bé áo vàng và linh vật ngôi sao xuất hiện
    And nút điều hướng hiển thị icon mũi tên tiến
    When người dùng bấm nút điều hướng
    Then màn hình chuyển sang Slide 2 "Discover & Learn"
    And chấm tròn chỉ báo trang thứ 2 sáng lên
    When người dùng tiếp tục bấm nút điều hướng
    Then màn hình chuyển sang Slide 3 "Learn with Live Coaches"
    And nút điều hướng mở rộng thành nút có chữ "Bắt đầu học ngay 🚀"
    When người dùng bấm "Bắt đầu học ngay 🚀"
    Then hệ thống chuyển sang màn hình "Thiết Lập Hồ Sơ Bé"

  @boundary @navigation
  Scenario: TC-ONB-02: Bỏ qua (Skip) nhanh từ Slide 1 vào thẳng Màn hình Hồ sơ bé
    Given người dùng đang ở Slide 1 của Onboarding
    When người dùng bấm nút "Bỏ qua" ở góc trên bên phải
    Then hệ thống bỏ qua Slide 2 và Slide 3
    And hiển thị ngay lập tức màn hình "Thiết Lập Hồ Sơ Bé"

  @interaction @gesture
  Scenario: TC-ONB-03: Vuốt lùi (Swipe Back) từ Slide 2 về Slide 1
    Given người dùng đang ở Slide 2 của Onboarding
    When người dùng thực hiện thao tác vuốt từ trái sang phải
    Then màn hình hiển thị lại Slide 1
    And chấm tròn chỉ báo trang thứ 1 sáng lên

  # =========================================================================
  # NHÓM 2: KIỂM THỬ THIẾT LẬP HỒ SƠ BÉ & VALIDATION (US-04)
  # =========================================================================

  @validation @negative
  Scenario: TC-PRF-01: Bỏ trống tên bé không cho phép tiếp tục
    Given người dùng đang ở màn hình Thiết Lập Hồ Sơ Bé
    When người dùng để trống ô Biệt danh
    And chọn tuổi 8
    And chọn linh vật "Leo Thông Thái"
    Then nút "Khám Phá Kiddora 🚀" ở trạng thái disabled
    When người dùng cố gắng chạm vào nút
    Then hệ thống không điều hướng và hiển thị gợi ý nhập tên

  @validation @boundary
  Scenario: TC-PRF-02: Tên bé vượt quá độ dài tối đa 16 ký tự
    Given người dùng đang ở màn hình Thiết Lập Hồ Sơ Bé
    When người dùng nhập chuỗi 20 ký tự "NguyenHoangMinhKhoi"
    Then ô nhập chỉ giữ lại tối đa 16 ký tự "NguyenHoangMinhK"

  @happy_path @persistence
  Scenario: TC-PRF-03: Nhập hợp lệ và hoàn tất lưu trữ hồ sơ bé
    Given người dùng đang ở màn hình Thiết Lập Hồ Sơ Bé
    When người dùng nhập biệt danh "Alex"
    And người dùng chọn nhóm tuổi "9 tuổi"
    And người dùng chọn linh vật "Dino Siêu Trí Tuệ"
    And người dùng bấm nút "Khám Phá Kiddora 🚀"
    Then hiệu ứng xúc giác (Haptic) được kích hoạt
    And dữ liệu 'KidProfile' được lưu vào SharedPreferences
    And cờ 'has_completed_onboarding' được gán bằng true
    And người dùng được chuyển tới màn hình HomeScreen
    And màn hình HomeScreen hiển thị lời chào "Chào Alex! 🚀"

  # =========================================================================
  # NHÓM 3: KIỂM THỬ PHI CHỨC NĂNG (NON-FUNCTIONAL & RESILIENCE)
  # =========================================================================

  @performance @sla
  Scenario: TC-NFR-01: Kiểm tra SLA Cold Start và Frame Rate khi vuốt
    When ứng dụng khởi động từ trạng thái tắt hoàn toàn
    Then thời gian hiển thị khung hình đầu tiên phải <= 1.8 giây
    When người dùng vuốt liên tục qua lại giữa các slide Onboarding
    Then tỷ lệ khung hình phải duy trì ổn định >= 55 FPS (không có drop frame)

  @offline @airplane_mode
  Scenario: TC-NFR-02: Hoạt động trơn tru 100% trong chế độ Máy bay (Offline)
    Given thiết bị đang bật Airplane Mode (không có WiFi, không có 4G/5G)
    When người dùng thực hiện toàn bộ luồng Onboarding và tạo hồ sơ
    Then mọi thao tác chuyển trang và lưu hồ sơ thành công không có ngoại lệ mạng
