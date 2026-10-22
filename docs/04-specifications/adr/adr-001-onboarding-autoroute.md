# Gate 0: Technical Spike & Architecture Decision Record (ADR)
## Feature: Sprint 1 — Onboarding & Kid Identity Engine
**Project**: Kiddora (Kids Learning & Live Classes)  
**Author**: Sub-Agent Tech Lead & System Architect — *"The Pragmatic System Architect"*  
**Date**: 2026-10-19  
**Status**: APPROVED  
**Related Epics**: US-01, US-02, US-03, US-04, US-05, US-06, US-07  

---

## 🔬 1. Technical Spikes & PoC Findings

### Spike 1: AutoRoute 9.x Guard vs Direct Splash Resolver
- **Vấn đề**: Cần xác định điều hướng ngay khi khởi động: nếu trẻ mở app lần đầu $\rightarrow$ vào `OnboardingRoute`, nếu đã hoàn thành $\rightarrow$ vào `HomeRoute`.
- **Thử nghiệm PoC**:
  - *Phương án A*: Dùng `AutoRouteGuard` chặn `HomeRoute` và redirect về `OnboardingRoute`.
  - *Phương án B*: `SplashRoute` / Native Initial Router đọc nhanh `SharedPreferences` trong hàm `main()` hoặc initState của Provider rồi điều hướng trực tiếp bằng router replacement.
- **Kết luận**: Chọn **Phương án A kết hợp Pre-warm SharedPreferences**: Khởi tạo instance `SharedPreferences` đồng bộ trước khi `runApp()` trong `main.dart` để tránh flash màn hình (0ms delay), sau đó truyền vào Riverpod ProviderScope.

### Spike 2: 3D Clay Rendering & SLA Ngân Sách Hiệu Năng
- **Vấn đề**: Hình mẫu tham khảo [kiddora_full_shot.png](../../assets/design_references/kiddora_full_shot.png) chứa các nhân vật 3D đất sét lớn và nhiều icon nổi. Nguy cơ: gây lag khung hình khi chuyển PageView hoặc làm chậm thời gian Cold Start ($> 1.8$s).
- **Thử nghiệm PoC & Phân loại Asset**:
  1. *Khung giao diện (Cards, Buttons, Badges)*: Code thuần bằng Flutter `BoxDecoration` + dual `BoxShadow` (specular highlight + ambient shadow) và `Transform.scale` cho hiệu ứng squish. **Tuyệt đối không dùng ảnh chụp màn hình làm nền**.
  2. *Nhân vật 3D & Mascots*: Định dạng PNG/WebP tách nền sắc nét `@2x` ($\le 150\text{KB}$ mỗi nhân vật).
  3. *Tải trước (Pre-caching)*: Gọi `precacheImage(AssetImage(...), context)` trong microtask đầu tiên để nạp sẵn 3 slide vào GPU texture cache $\rightarrow$ Đảm bảo duy trì **60 FPS** khi swipe.

---

## 🏛️ 2. Architecture Decision Records (ADRs)

### ADR-001: Bộ Định Tuyến Khai Báo AutoRoute 9.x
- **Bối cảnh**: Kiddora cần luồng điều hướng phân lớp rõ ràng, hỗ trợ Nested Routes cho Bottom Navigation và Deep Linking cho phòng học Live Class sau này.
- **Quyết định**: Sử dụng `auto_route: ^9.2.2` kết hợp `auto_route_generator: ^9.0.0`.
- **Hệ quả**: Tất cả màn hình tuân thủ quy ước `@RoutePage()`, tạo router tại `lib/core/router/app_router.dart`. Chạy `make gen` để sinh file `app_router.gr.dart`.

### ADR-002: Quản Lý Trạng Thái Bất Biến Với Riverpod 2.x & Freezed
- **Bối cảnh**: Trạng thái hồ sơ của bé (`KidProfile`) gồm tên, tuổi (7-10), avatar mascot và tiến độ onboarding cần được quản lý tập trung, bất biến (immutable) và dễ dàng mock khi viết Widget Test.
- **Quyết định**: 
  - Mô hình dữ liệu: Sử dụng `@freezed` cho Entity và Value Objects trong `domain/models`.
  - Quản lý trạng thái: Sử dụng `@riverpod` Notifier code-gen (`AsyncNotifier` cho luồng bất đồng bộ hoặc `Notifier` cho synchronous state).

### ADR-003: Cấu Trúc Mã Nguồn Feature-First Clean Architecture
- **Bối cảnh**: Đảm bảo tuân thủ nguyên tắc Ponytail (YAGNI, không abstraction rác) nhưng vẫn bảo đảm tính module hóa cao.
- **Quyết định**: Cấu trúc thư mục theo chuẩn:
```
lib/features/onboarding/
├── domain/
│   ├── models/           # kid_profile.dart (@freezed)
│   └── repositories/     # i_onboarding_repository.dart (Pure Dart contract)
├── data/
│   ├── datasources/      # onboarding_local_datasource.dart (SharedPreferences)
│   └── repositories/     # onboarding_repository_impl.dart
└── presentation/
    ├── controllers/      # onboarding_controller.dart (@riverpod)
    ├── pages/            # onboarding_screen.dart, kid_profile_setup_screen.dart
    └── widgets/          # onboarding_slide_item.dart, clay_avatar_picker.dart
```

---

## 📊 3. Cam Kết Ngân Sách Hiệu Năng (Performance SLA)

| Chỉ Số Đo Lường | Ngưỡng Giới Hạn (SLA) | Phương Án Kỹ Thuật Đảm Bảo |
| :--- | :---: | :--- |
| **Cold Start Time** | $\le 1.8\text{s}$ | Pre-warm SharedPreferences, nạp async các dependency không trọng yếu. |
| **Frame Rate khi Swipe Onboarding** | $60\text{ FPS}$ (Zero Jank) | Precache asset ảnh nhân vật, dùng `PageView.builder` thay vì khởi tạo đồng loạt. |
| **Memory Footprint sau Onboarding** | $\le 65\text{MB}$ | Tự động giải phóng bộ nhớ texture không dùng đến, không giữ static reference. |
| **Mức Độ Rò Rỉ RAM (Memory Leak)** | $0$ | Hủy tất cả `PageController` và `AnimationController` trong `dispose()`. |

---

## ✅ BIÊN BẢN PHÊ DUYỆT KHẢ THI KỸ THUẬT (Feasibility Sign-Off)
- **Người thẩm định**: Sub-Agent Tech Lead & System Architect — *"The Pragmatic System Architect"*
- **Trạng thái**: **APPROVED (100% Khả thi)**
- **Chỉ dẫn cho Sub-Agent BA & Dev FE**:
  1. *Sub-Agent BA*: Tiến hành soạn thảo PRD Gate 1 dựa trên luồng 3 bước Onboarding và chọn hồ sơ bé đã chốt.
  2. *Sub-Agent Dev FE*: Tuân thủ triệt để cấu trúc thư mục Feature-First, sử dụng widget trong `lib/shared/ui_kit/` để tái sử dụng tối đa.
