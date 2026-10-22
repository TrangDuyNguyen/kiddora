# Đặc Tả Giao Diện UI/UX Specs: Trang Chủ Học Sinh (FEAT-04)

- **Feature**: `FEAT-04`
- **Sub-Agent**: Sub-Agent UI/UX Designer
- **Asset đối sánh Dribbble**: `assets/design_references/screens/03_home_01_student_dashboard.png`

---

## 🎨 1. Bố Cục Lưới 4pt & Tokens Thành Phần

- **Top Bar**: Avatar bé tròn đường kính $44\text{ dp}$ có viền vàng, chuông thông báo có chấm đỏ, huy hiệu sao vàng tích lũy $120\text{ Stars}$.
- **Welcome Card**: Nền tím pastel `#EEF2FF`, vương miện đất sét vàng 3D, tiêu đề $20\text{ sp}$ đậm.
- **3 Summary Cards**: Kích thước chiều cao $84\text{ dp}$, bo góc $18\text{ dp}$, nền trắng tinh `#FFFFFF`, icon 3D nổi bật.
- **Continue Learning Card**: Banner hình ảnh động vật vui nhộn, thanh tiến độ xanh mint Meadow Mint `#10B981` dày $8\text{ dp}$.
- **Bottom Navigation Bar**: Chiều cao $72\text{ dp}$, nền trắng, bóng đổ ngược phía trên, icon chuyển tab có hiệu ứng chuyển màu và nảy nhẹ.

---

## 📱 2. Danh Sách 5 Trạng Thái Màn Hình
1. **Default**: Toàn bộ dữ liệu hiển thị phong phú, cuộn êm mượt 60 FPS.
2. **Loading / Shimmer**: Hiển thị khung xương xám nhạt bóng mờ trong lúc tải dữ liệu.
3. **Empty Learning**: Nếu bé chưa đăng ký khóa học nào, hiển thị nút [Explore Courses] lớn nổi bật.
4. **No Upcoming Live**: Thẻ Live thông báo lịch học tiếp theo vào ngày mai.
5. **Offline**: Hiển thị biểu tượng đám mây nhỏ báo hiệu các bài học đã tải về máy có thể học tiếp ngoại tuyến.
