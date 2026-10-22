class AppStrings {
  AppStrings._();

  static const String appName = 'Kiddora';
  static const String appTagline = 'Học tương tác & Lớp học trực tuyến';

  // Common Actions
  static const String skip = 'Bỏ qua';
  static const String next = 'Tiếp tục';
  static const String startNow = 'Bắt đầu ngay';
  static const String readyToExplore = 'Sẵn sàng khám phá!';

  // Onboarding Slide 1
  static const String onboardingSlide1HeroTitle = 'Fun Learning for a\n';
  static const String onboardingSlide1HeroSubtitle = 'Brighter Tomorrow';
  static const String onboardingSlide1Description =
      'Khám phá khoá học bổ ích, lớp học trực tuyến, chơi vui và rèn luyện tư duy mỗi ngày!';
  static const String learn = 'Learn';
  static const String play = 'Play';
  static const String achieve = 'Achieve';

  // Onboarding Slide 2
  static const String onboardingSlide2TitlePart1 = 'Discover\n';
  static const String onboardingSlide2TitlePart2 = '& Learn';
  static const String onboardingSlide2Description =
      'Chương trình học thú vị dành riêng cho con. Tự do học theo tốc độ cá nhân và phát triển kỹ năng.';
  static const String chipInteractiveCourses = 'Khóa học\ntương tác';
  static const String chipFunActivities = 'Hoạt động\nvui nhộn';
  static const String chipTrackProgress = 'Theo dõi\ntiến độ';

  // Onboarding Slide 3
  static const String onboardingSlide3TitlePart1 = 'Learn with\n';
  static const String onboardingSlide3TitlePart2 = 'Live ';
  static const String onboardingSlide3TitlePart3 = 'Coaches';
  static const String onboardingSlide3Description =
      'Tham gia lớp trực tiếp, bấm chuông trả lời câu hỏi và học hỏi từ các thầy cô xuất sắc.';
  static const String chipLiveClassroom = 'Lớp học\ntrực tiếp';
  static const String chipInteractiveQA = 'Hỏi đáp\ntương tác';
  static const String chipTopCoaches = 'Thầy cô\nxuất sắc';

  // Kid Profile Setup
  static const String setupProfileTitle = 'Thiết lập hồ sơ cho bé';
  static const String nicknameLabel = 'Tên hoặc biệt danh của con';
  static const String nicknameHint = 'Nhập tên con (ví dụ: Alex, Bo, Bắp...)';
  static const String quickNicknameSuggestion = 'Gợi ý:';
  static const String diceTooltip = 'Đổi tên ngẫu nhiên';
  static const String ageQuestion = 'Con mấy tuổi rồi?';
  static const String ageUnit = 'tuổi';
  static const String selectCompanion = 'Chọn bạn đồng hành 3D:';

  static String curriculumGradeForAge(int age) {
    switch (age) {
      case 6:
        return 'Lớp 1';
      case 7:
        return 'Lớp 2';
      case 8:
        return 'Lớp 3';
      case 9:
        return 'Lớp 4';
      case 10:
        return 'Lớp 5';
      case 11:
        return 'Lớp 6';
      case 12:
        return 'Lớp 7';
      default:
        return 'Tiểu học';
    }
  }

  static String curriculumHintForAge(int age) {
    switch (age) {
      case 6:
        return 'Chuẩn bị vào Lớp 1: Chữ số & Đố vui nhận thức';
      case 7:
        return 'Lớp 2: Phép tính vui nhộn & Thám hiểm STEM';
      case 8:
        return 'Lớp 3: Toán tư duy & Lớp học trực tuyến';
      case 9:
        return 'Lớp 4: Logic đố vui nâng cao & Bấm chuông';
      case 10:
        return 'Lớp 5: Thử thách khoa học & Chinh phục đỉnh cao';
      case 11:
        return 'Lớp 6: Toán ứng dụng & Dự án STEM khám phá';
      case 12:
        return 'Lớp 7: Tư duy logic phức hợp & Tinh hoa kiến thức';
      default:
        return 'Lộ trình học tập cá nhân hoá cùng Kiddora';
    }
  }

  // Subjects
  static const String mathTitle = 'Toán Tư Duy';
  static const String stemTitle = 'Khoa Học STEM';
  static const String logicTitle = 'Câu Đố Logic';
  static const String liveClassTitle = 'Lớp Trực Tuyến';

  // Gamification & Rewards
  static const String stars = 'Sao Thưởng';
  static const String streaks = 'Ngày Liên Tục';
  static const String startLesson = 'Bắt đầu học';
  static const String enterLiveClass = 'Vào lớp ngay';
  static const String parentGate = 'Cổng Phụ Huynh';

  // Mascot Companion Names
  static const String avatarLeo = 'Leo';
  static const String avatarBarnaby = 'Barnaby';
  static const String avatarDino = 'Dino';
  static const String avatarBunny = 'Bunny';

  // 12 Con Giáp Mascot Names (Vietnamese Zodiac)
  static const String zodiacTabTitle = '12 Con Giáp';
  static const String classicTabTitle = 'Bạn Nhỏ';
  static const String zodiacTy = 'Tý - Chuột';
  static const String zodiacSuu = 'Sửu - Trâu';
  static const String zodiacDan = 'Dần - Hổ';
  static const String zodiacMao = 'Mão - Mèo';
  static const String zodiacThin = 'Thìn - Rồng';
  static const String zodiacTy2 = 'Tỵ - Rắn';
  static const String zodiacNgo = 'Ngọ - Ngựa';
  static const String zodiacMui = 'Mùi - Dê';
  static const String zodiacThan = 'Thân - Khỉ';
  static const String zodiacDau = 'Dậu - Gà';
  static const String zodiacTuat = 'Tuất - Chó';
  static const String zodiacHoi = 'Hợi - Heo';

  // Wordmark Letters & Separator
  static const String wordmarkK = 'K';
  static const String wordmarkI = 'i';
  static const String wordmarkD1 = 'd';
  static const String wordmarkD2 = 'd';
  static const String wordmarkO = 'o';
  static const String wordmarkR = 'r';
  static const String wordmarkA = 'a';
  static const String wordmarkSeparator = ' • ';

  // Home Screen Daily Quest
  static const String dailyQuestTitle = 'Nhiệm Vụ Hôm Nay';
  static const String plusThirtyStars = '+30 Sao';
  static const String dailyQuestDescription =
      'Hoàn thành 3 câu đố tư duy toán học';
}
