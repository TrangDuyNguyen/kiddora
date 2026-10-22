# Đặc Tả Giao Diện UI/UX Specs: Mục Tiêu Hàng Ngày (FEAT-05)

- **Feature**: `FEAT-05`
- **Sub-Agent**: Sub-Agent UI/UX Designer
- **Asset đối sánh Dribbble**: `assets/design_references/screens/03_home_02_todays_learning_goals.png`

---

## 🎨 1. Tokens Thành Phần & Layout Lưới 4pt

- **Header Bar**: Nút Back đất sét bo tròn $14\text{ dp}$, tiêu đề *"Today's Learning Goal"* Quicksand Bold $18\text{ sp}$.
- **Vòng Tròn Tiến Độ 3D (Progress Gauge)**: Đường kính $160\text{ dp}$, độ dày nét vẽ $16\text{ dp}$, màu nền xám mờ `#EEF2FF`, vạch tiến độ tím Indigo `#4648D4` có đầu tròn (Round cap), tâm giữa hiển thị tỷ lệ lớn $28\text{ sp}$.
- **Danh Sách 5 Thẻ Nhiệm Vụ**: Chiều cao mỗi thẻ $64\text{ dp}$, lề dọc $10\text{ dp}$, nền trắng tinh `#FFFFFF`, bo góc $16\text{ dp}$, bóng đổ đất sét mềm.
- **Checkbox Đất Sét**: Đường kính $28\text{ dp}$, bo góc tròn $8\text{ dp}$. Trạng thái chưa tick: viền xám `#D1D5DB`. Trạng thái đã tick: nền Meadow Mint `#10B981` kèm dấu kiểm trắng.
- **Mascot Motivation Banner**: Chiều cao $90\text{ dp}$, nền vàng ấm Joyful Amber `#FEF3C7`, bo góc $18\text{ dp}$, hình ảnh linh vật giơ ngón cái.

---

## 📱 2. Danh Sách 5 Trạng Thái Màn Hình
1. **Default**: Hiển thị đầy đủ tiến độ hiện tại và danh sách 5 nhiệm vụ của ngày hôm nay.
2. **Task Toggling (Interactive)**: Khi chạm vào thẻ, hiệu ứng co nhẹ scale(0.98) và cập nhật tức thì.
3. **All Completed (100%)**: Vòng tròn sáng rực rỡ, chữ "All done for today! You're a superstar!".
4. **Offline Mode**: Trạng thái nhiệm vụ được lưu offline trong máy và tự động đồng bộ khi có mạng.
5. **New Day Reset**: Tự động đặt lại trạng thái 0/5 vào lúc 00:00 mỗi sáng.
