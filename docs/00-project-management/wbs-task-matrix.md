# Ma Trận Phân Rã Công Việc WBS (Work Breakdown Structure)
## Sprint 1: Interactive Onboarding & Kid Profile Identity
**Scrum Master / PM**: Sub-Agent Project Manager (PM) — *"The Clockwork Disciplinarian"*  
**Ngày lập**: 2026-10-19  

```
[PRD Approved (Gate 1)] 
          │
          ▼ (PM Phân rã WBS)
┌──────────────────────────────────────────────────────────────────────────────────┐
│ Gate 2 (Design)  : UI Spec, 4pt Grid, Claymorphism Tokens & 5 States              │
│ Gate 3 (QA)      : Master Test Plan, EP/BVA TCs & Gherkin .feature                │
│ Gate 4 (Dev FE)  : Feature-First Clean Code, Riverpod, AutoRoute & Ponytail UI    │
│ Gate 5 (Reviewer): Ponytail Diff Review, Cut Bloat & Over-engineering             │
│ Gate 6 (QA)      : 100% Pass Automated Test, 60 FPS, 0 Memory Leak               │
│ Gate 6.5 (Sec)   : COPPA Kid Privacy & Local Storage Encryption Audit             │
│ Gate 7 (Release) : Supreme Release Sign-off & Clean Git Branch                    │
└──────────────────────────────────────────────────────────────────────────────────┘
```

---

## 📋 Chi Tiết Phân Rã WBS Theo 6 Cổng Chất Lượng

### Giai Đoạn 1: Thiết Kế & Kiểm Thử Sớm (Gates 2 & 3)
| Task ID | Hạng Mục Công Việc | Cổng | Người Phụ Trách | SP | Tiêu Chuẩn Hoàn Thành (DoD) |
| :---: | :--- | :---: | :---: | :---: | :--- |
| **WBS-01** | Thiết kế UI Layout Spec cho 3 Slide Onboarding & Kid Profile Setup | Gate 2 | `ui-ux-designer` | 3 | File `gate2-ui-ux-spec.md`, bố cục lưới 4pt, 5 UI states đầy đủ. |
| **WBS-02** | Xây dựng bộ testcase BDD Gherkin (`.feature`) & Traceability Matrix | Gate 3 | `qa-tester` | 3 | File `gate3-test-plan.feature`, 100% kịch bản bao phủ Happy & Edge cases. |

### Giai Đoạn 2: Phát Triển Mã Nguồn Sạch (Gate 4 — Dev FE)
| Task ID | Hạng Mục Công Việc | Cổng | Người Phụ Trách | SP | Tiêu Chuẩn Hoàn Thành (DoD) |
| :---: | :--- | :---: | :---: | :---: | :--- |
| **WBS-03** | Khởi tạo AutoRoute 9.x & Cấu trúc Onboarding Guard | Gate 4 | `dev` | 3 | `app_router.dart` tạo mới, chạy `make gen` thành công không lỗi compile. |
| **WBS-04** | Xây dựng Entity & Repository Freezed cho `KidProfile` & Local Datasource | Gate 4 | `dev` | 3 | Pure Dart domain model, JSON serializable, SharedPreferences datasource. |
| **WBS-05** | Phát triển Màn hình 3 Slide Onboarding tương tác (kèm Clay Smooth Page Indicator) | Gate 4 | `dev` | 5 | Visual khớp 100% ảnh tham chiếu, vuốt 60 FPS mượt mà. |
| **WBS-06** | Phát triển Màn hình Thiết lập Hồ sơ Bé (Age Selector 7-10 & 3D Clay Avatar Picker) | Gate 4 | `dev` | 5 | Chọn tuổi, chọn mascot, validate input và lưu vào Riverpod State. |
| **WBS-07** | Tích hợp Haptic Feedback & Hiệu ứng Squish khi ấn nút | Gate 4 | `dev` | 3 | Hiệu ứng co giãn `scale(0.96)` và rung xúc giác khi nhấn. |

### Giai Đoạn 3: Rà Soát, Kiểm Định & An Ninh (Gates 5, 6, 6.5 & 7)
| Task ID | Hạng Mục Công Việc | Cổng | Người Phụ Trách | SP | Tiêu Chuẩn Hoàn Thành (DoD) |
| :---: | :--- | :---: | :---: | :---: | :--- |
| **WBS-08** | Ponytail Diff Review (Quét bloat, boilerplate, dead code) | Gate 5 | `code-reviewer` | 1 | Phán quyết tối cao: *"Lean already. Ship."*. Không có abstraction rác. |
| **WBS-09** | Chạy toàn bộ Test tự động (Unit & Widget Test) & Kiểm chuẩn 60 FPS | Gate 6 | `qa-tester` | 2 | `flutter test` đạt 100% pass, biên bản `gate6-qa-signoff.md`. |
| **WBS-10** | Kiểm toán An ninh Quyền riêng tư Trẻ em (COPPA) & Dữ liệu máy | Gate 6.5 | `security-auditor` | 1 | Biên bản `gate6.5-security-signoff.md` xác nhận không thu thập PII. |
| **WBS-11** | Nghiệm thu và phát hành Sprint 1 | Gate 7 | `product-owner` / `tech-lead` | - | Ký duyệt Release Sign-off, sẵn sàng cho Sprint 2. |
