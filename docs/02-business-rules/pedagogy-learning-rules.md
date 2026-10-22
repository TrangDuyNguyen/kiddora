# Quy Chuẩn Sư Phạm & Thuật Toán Trò Chơi Hóa (Pedagogy & Gamification Rules)

Tài liệu này chuẩn hóa các quy tắc phân nhóm độ tuổi, thiết kế độ khó bài giảng, và cơ chế tính điểm thưởng Gamification trong Kiddora.

---

## 1. Phân Nhóm Độ Tuổi & Lộ Trình Sư Phạm (Age Brackets)

Kiddora chia đối tượng người học thành 3 khung năng lực sư phạm:

| Nhóm Tuổi | Khung Năng Lực | Đặc Điểm Nhận Thức | Trọng Tâm Bài Học |
| :---: | :--- | :--- | :--- |
| **6 – 7 tuổi** | Cấp độ Khởi đầu (*Early Explorer*) | Tư duy trực quan hình tượng; nhận diện mặt số, hình khối, bảng chữ cái, màu sắc. | Bài học có âm thanh hướng dẫn, câu đố hình ảnh lớn, tối đa 3-5 phút/bài. |
| **8 – 9 tuổi** | Cấp độ Khám phá (*Active Learner*) | Bắt đầu tư duy logic cụ thể; thực hiện các phép tính cộng trừ nhân chia cơ bản, tò mò về thế giới động vật, khoa học tự nhiên. | Bài tập tương tác kéo thả, câu đố tính nhẩm (Mental Math), bài học 7-10 phút. |
| **10 – 12 tuổi** | Cấp độ Đột phá (*Junior Master*) | Tư duy trừu tượng, giải quyết vấn đề đa bước; hứng thú với STEM, lập trình logic và khoa học vũ trụ. | Thử thách câu đố logic đa tầng, bài học 10-15 phút, câu hỏi trắc nghiệm có đếm giờ. |

---

## 2. Quy Tắc Mục Tiêu Học Tập Hàng Ngày (Daily Goals Algorithm)

Mỗi ngày, hệ thống khởi tạo **5 Nhiệm Vụ Mục Tiêu** cho học sinh:
1. **Nhiệm vụ 1 (Bài học)**: Xem ít nhất 1 bài giảng lý thuyết ngắn ($+10\text{ Star Points}$).
2. **Nhiệm vụ 2 (Luyện tập)**: Hoàn thành 1 bài trắc nghiệm thực hành ($+10\text{ Star Points}$).
3. **Nhiệm vụ 3 (Lớp học hoặc Ôn tập)**: Tham gia 1 buổi Live Class hoặc ôn lại bài học cũ ($+10\text{ Star Points}$).
4. **Nhiệm vụ 4 (Đọc hiểu)**: Đọc 1 mẩu truyện khoa học hoặc câu đố vui ($+5\text{ Star Points}$).
5. **Nhiệm vụ 5 (Tích lũy)**: Đạt tổng cộng $10\text{ Điểm kinh nghiệm}$ trong ngày ($+5\text{ Star Points}$).

### Điều Kiện Tăng Chuỗi Ngày (Streak Increment):
- Hoàn thành tối thiểu **3 trong 5 nhiệm vụ** trong khoảng thời gian từ $00:00$ đến $23:59$ cùng ngày:
  - Ngọn lửa Streak tăng $+1\text{ ngày}$.
  - Kích hoạt hiệu ứng chúc mừng (Confetti) và lưu vào bộ nhớ cục bộ.
- Nếu không hoàn thành đủ 3 nhiệm vụ trước nửa đêm: Chuỗi Streak trở về $0$ (trừ khi phụ huynh kích hoạt bảo vệ Streak Shield).
