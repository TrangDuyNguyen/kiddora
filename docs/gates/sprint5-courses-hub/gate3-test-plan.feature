# language: vi
Tính năng: Kiểm thử tự động & Nghiệm thu phân hệ Khám phá Khóa học & Giáo trình bài giảng
  Là một học sinh hoặc phụ huynh sử dụng Kiddora
  Tôi muốn khám phá, tìm kiếm, lọc các khóa học và theo dõi giáo trình bài giảng
  Để có thể chọn lựa và bắt đầu các khóa học phù hợp với độ tuổi và sở thích

  Bối cảnh:
    Có sẵn dữ liệu 6 khóa học benchmark trong hệ thống
    Và ứng dụng khởi chạy với tài khoản hợp lệ

  Kịch bản: Hiển thị Courses Hub với đầy đủ 4 khối nội dung
    Khi người dùng chuyển sang tab Khám phá Khóa học
    Thì màn hình hiển thị tiêu đề "Khóa học" và nút tìm kiếm tròn
    Và hiển thị Hero Banner "Tương lai tươi sáng bắt đầu từ đây!"
    Và hiển thị 5 thẻ danh mục môn học: Tất cả, Khoa học, Toán học, Ngôn ngữ, Nghệ thuật
    Và hiển thị lưới 2 cột Khóa học nổi bật kèm nút "Xem tất cả"

  Kịch bản: Tìm kiếm khóa học theo thời gian thực có debounce 300ms
    Khi người dùng mở màn hình Tìm kiếm Khóa học
    Và nhập từ khóa "Space" vào ô tìm kiếm
    Thì sau 300 mili-giây danh sách trả về khóa học "Space Exploration"
    Và hiển thị tiêu đề kết quả "Kết quả tìm kiếm (1)"
    Và không hiển thị các khóa học không liên quan

  Kịch bản: Lọc khóa học đa tiêu chí theo 4 chiều
    Khi người dùng mở màn hình Bộ lọc khóa học
    Thì nhìn thấy đủ 4 nhóm tiêu chí: Chủ đề, Độ tuổi, Cấp độ khó, Thời lượng khóa học
    Khi người dùng chọn môn "Khoa học" và cấp độ "Cơ bản"
    Và bấm nút "Áp dụng bộ lọc"
    Thì danh sách khóa học hiển thị các khóa học thỏa mãn cả hai điều kiện
    Khi người dùng bấm "Xóa bộ lọc"
    Thì toàn bộ các lựa chọn được đưa về "Tất cả"

  Kịch bản: Xem lưới tất cả khóa học và lưu yêu thích
    Khi người dùng mở màn hình Tất cả khóa học
    Thì nhìn thấy lưới 2 cột gồm 6 khóa học benchmark
    Và mỗi thẻ khóa học đều có nút tròn chứa icon Trái tim
    Khi người dùng bấm vào nút Trái tim của khóa học
    Thì icon chuyển sang màu đỏ và trạng thái yêu thích được lưu trong phiên

  Kịch bản: Xem chi tiết khóa học và chuyển sang giáo trình
    Khi người dùng chọn khóa học "Amazing Animals"
    Thì hiển thị ảnh bìa khủng long 3D với nút Quay lại và nút Yêu thích
    Và hiển thị tiêu đề "Amazing Animals", đánh giá 4.8 sao và 3 pill thông số
    Và hiển thị mục "Về khóa học này" kèm 4 ô tính năng nổi bật
    Khi người dùng bấm nút "Bắt đầu học ngay"
    Thì chuyển sang màn hình Giáo trình bài học gồm 3 tab
    Và tab "Bài học" hiển thị danh sách 5 bài học kèm trạng thái hoàn thành, mở khóa và khóa
    Và hiển thị banner cúp vàng thông báo nhận huy hiệu đặc biệt

