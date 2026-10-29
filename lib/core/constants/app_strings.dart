class AppStrings {
  AppStrings._();

  static const String appName = 'Kiddora';
  static const String appTagline = 'Học tương tác & Lớp học trực tuyến';

  // Common Actions
  static const String skip = 'Bỏ qua';
  static const String next = 'Tiếp tục';
  static const String startNow = 'Bắt đầu ngay';
  static const String readyToExplore = 'Sẵn sàng khám phá!';
  static const String debugOnboarding = 'Onboarding';

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

  // Sprint 3 — Core Screens (Login, Home Dashboard, Daily Goal)
  static const String learnPlayAchieve = 'Learn • Play • Achieve';
  static const String welcomeBack = 'Welcome Back!';
  static const String welcomeBackSubtitle =
      "Let's continue your learning journey";
  static const String emailOrUsername = 'Email or Username';
  static const String password = 'Password';
  static const String rememberMe = 'Remember me';
  static const String forgotPassword = 'Forgot Password?';
  static const String logIn = 'Log In';
  static const String orContinueWith = 'Or continue with';
  static const String dontHaveAccount = "Don't have an account? ";
  static const String signUp = 'Sign Up';

  // Register & Sign Up
  static const String createAccount = 'Create Account';
  static const String createAccountSubtitle =
      'Start your fun learning journey today!';
  static const String fullName = 'Full Name';
  static const String fullNamePlaceholder = 'Enter parent or child name';
  static const String emailAddress = 'Email Address';
  static const String emailPlaceholder = 'Enter email address';
  static const String passwordPlaceholder = 'Create a secure password';
  static const String confirmPassword = 'Confirm Password';
  static const String confirmPasswordPlaceholder = 'Re-enter your password';
  static const String agreeTerms =
      'I agree to the Terms of Service & Privacy';
  static const String alreadyHaveAccount = 'Already have an account? ';
  static const String orSignUpWith = 'Or sign up with';
  static const String pleaseFillAllFields = 'Vui lòng nhập đầy đủ thông tin';
  static const String passwordsDoNotMatch = 'Mật khẩu xác nhận không khớp';
  static const String mustAgreeTerms =
      'Vui lòng đồng ý với Điều khoản & Chính sách';
  static const String registerSuccessAlert =
      'Tạo tài khoản thành công! Chào mừng đến với Kiddora.';

  // Student Home Dashboard
  static const String hiPrefix = 'Hi, ';
  static const String defaultKidName = 'Keil';
  static const String exclamationMark = '!';
  static const String greatToSeeYou = 'Great to see you again!';
  static const String notificationCount = '3';
  static const String keepLearningHeroTitle = 'Keep Learning\nKeep Growing!';
  static const String keepLearningHeroSubtitle =
      'Small steps make\nbig dreams!';
  static const String myProgress = 'My Progress';
  static const String myProgressSubtitle = "You're doing great!";
  static const String currentCourses = 'Current Courses';
  static const String currentCoursesSubtitle = '3 Active Courses';
  static const String upcomingSession = 'Upcoming Session';
  static const String upcomingSessionSubtitle = 'Math with Coach Alex';
  static const String myBadges = 'My Badges';
  static const String myBadgesSubtitle = '5 Badges Earned';
  static const String continueLearning = 'Continue Learning';
  static const String seeAll = 'See All';
  static const String courseScienceTag = 'Science';
  static const String courseAmazingAnimals = 'Amazing Animals';
  static const String courseLessonsProgress = '3 of 5 lessons';
  static const String mathFunWithNumbers = 'Math Fun with Numbers';
  static const String coachSarah = 'Coach Sarah';
  static const String sessionTodayTime = 'Today, 4:00 PM';
  static const String join = 'Join';
  static const String navHome = 'Home';
  static const String navCourses = 'Courses';
  static const String navSessions = 'Sessions';
  static const String navTests = 'Tests';
  static const String navProfile = 'Profile';
  static const String notificationsAlert =
      '3 thông báo mới từ Coach Sarah & Math Fun!';
  static const String joiningSessionAlert =
      'Đang tham gia lớp học với Coach Sarah...';

  // Today's Learning Goal
  static const String todaysLearningGoal = "Today's Learning Goal";
  static const String todaysGoalSubtitle = 'Small steps make big progress!';
  static const String tasksCompleted = 'Tasks Completed';
  static const String ofSeparator = ' of ';
  static const String taskWatchLesson = 'Watch a lesson';
  static const String taskCompleteQuiz = 'Complete a quiz';
  static const String taskAnimalFactsQuiz = 'Animal Facts Quiz';
  static const String taskJoinLiveSession = 'Join a live session';
  static const String taskReadStory = 'Read a story';
  static const String taskMysteryOfSpace = 'The Mystery of Space';
  static const String taskEarnPoints = 'Earn 10 points';
  static const String taskKeepGoing = 'Keep going!';
  static const String youCanDoIt = 'You can do it!';
  static const String reachGoalToday =
      'Keep learning and reach your goal today!';

  // Guest Mode & Hybrid Conversion
  static const String guestModeTitle = 'Chế độ Trải nghiệm thử';
  static const String guestBannerTitle = 'Lưu tiến trình & sao thưởng của con!';
  static const String guestBannerSubtitle =
      'Đăng ký tài khoản phụ huynh để lưu giữ sao và đồng bộ khi đổi máy.';
  static const String registerNow = 'Đăng ký ngay';
  static const String exploreAsGuest = 'Trải nghiệm thử không cần tài khoản';
  static const String loginToSync = 'Đã có tài khoản? Đăng nhập';
  static const String networkError = 'Không thể kết nối đến máy chủ. Vui lòng kiểm tra lại mạng.';
  static const String networkTimeout = 'Máy chủ phản hồi quá chậm. Vui lòng thử lại sau.';
  static const String serverUnavailable = 'Máy chủ đang gặp sự cố. Vui lòng thử lại sau.';
  static const String badCertificate = 'Kết nối không an toàn tới máy chủ.';
  static const String requestCancelled = 'Yêu cầu đã bị hủy.';
  static const String unexpectedResponse = 'Phản hồi từ máy chủ không hợp lệ.';
  static const String unknownError = 'Đã có lỗi xảy ra. Vui lòng thử lại.';
  static const String loginFailed = 'Đăng nhập thất bại';
  static const String registerFailed = 'Không thể đăng ký tài khoản';
  static const String saveKidProfileFailed = 'Không thể lưu hồ sơ bé';
  static const String passwordTooShort = 'Mật khẩu phải từ 6 ký tự trở lên';
  static const String loginEmptyFields = 'Vui lòng nhập Email và Mật khẩu';

  // Network Debug Inspector & Logging
  static const String networkInspectorTitle = 'Nhật ký mạng (Network Inspector)';
  static const String copyResponse = 'Sao chép Response';
  static const String copyCurl = 'Sao chép cURL';
  static const String copyRequestBody = 'Sao chép Request';
  static const String copiedToClipboard = 'Đã sao chép vào bộ nhớ tạm!';
  static const String noNetworkLogs = 'Chưa có nhật ký mạng nào';
  static const String clearLogs = 'Xóa nhật ký';
  static const String close = 'Đóng';
  static const String requestTab = 'Request';
  static const String responseTab = 'Response';
  static const String statusCode = 'Mã trạng thái';
  static const String duration = 'Thời gian';

  // Tactile Clay Modal System (Vietnamese Kid-Friendly Copy)
  static const String closeDialogLabel = 'Đóng hộp thoại';
  static const String backButtonLabel = 'Quay lại';

  static const String modalLogoutTitle = 'Đăng xuất?';
  static const String modalLogoutBody =
      'Con có chắc muốn đăng xuất không? Con luôn có thể đăng nhập lại bất cứ lúc nào để tiếp tục hành trình học tập nhé.';
  static const String modalLogoutConfirm = 'Đồng ý đăng xuất';
  static const String modalCancel = 'Hủy bỏ';

  static const String modalNoSessionsTitle = 'Chưa có buổi học!';
  static const String modalNoSessionsBody =
      'Hiện chưa có buổi học trực tuyến nào sắp diễn ra. Khám phá khóa học và đặt lịch ngay để bắt đầu nhé!';
  static const String modalExploreCourses = 'Khám phá khóa học';
  static const String modalMaybeLater = 'Để sau nhé';

  static const String modalErrorTitle = 'Mất kết nối rồi!';
  static const String modalErrorBody =
      'Có vẻ thiết bị đang ngoại tuyến hoặc mạng chập chờn. Vui lòng kiểm tra kết nối Internet và thử lại nhé.';
  static const String modalRetry = 'Thử lại';
  static const String modalGoOffline = 'Học chế độ ngoại tuyến';

  // Courses Hub & Smart Discovery (Domain 04)
  static const String coursesHubTitle = 'Khám phá & Học hỏi';
  static const String coursesHubExploreHero = 'Explore, Learn and Grow!';
  static const String coursesSearchHint = 'Tìm khóa học, chủ đề...';
  static const String filterTooltip = 'Lọc khóa học';
  static const String popularCourses = 'Khóa học nổi bật';
  static const String allCourses = 'Tất cả khóa học';
  static const String lessonsCountSuffix = 'bài học';
  static const String agesPrefix = 'Độ tuổi';

  // Subject Category Chips
  static const String subjectAll = 'Tất cả';
  static const String subjectScience = 'Khoa học STEM';
  static const String subjectMath = 'Toán tư duy';
  static const String subjectLanguage = 'Ngôn ngữ';
  static const String subjectArts = 'Nghệ thuật & Sáng tạo';
  static const String subjectCoding = 'Lập trình';

  // Course Search Screen (04_courses_02)
  static const String searchResultsTitle = 'Kết quả tìm kiếm';
  static const String noCoursesFoundTitle = 'Không tìm thấy khóa học nào!';
  static const String noCoursesFoundSubtitle =
      'Thử tìm kiếm với từ khóa khác như Toán, Khoa học nhé!';
  static const String clearSearch = 'Xóa tìm kiếm';

  // Course Filter Bottom Sheet (04_courses_03)
  static const String filterCoursesTitle = 'Bộ lọc khóa học';
  static const String filterSectionProgram = 'Chương trình / Môn học';
  static const String filterSectionAgeGroup = 'Nhóm tuổi';
  static const String filterSectionLevel = 'Cấp độ';
  static const String filterAge6to8 = '6 - 8 tuổi';
  static const String filterAge9to10 = '9 - 10 tuổi';
  static const String filterAge11to12 = '11 - 12 tuổi';
  static const String levelBeginner = 'Cơ bản';
  static const String levelIntermediate = 'Trung bình';
  static const String levelAdvanced = 'Nâng cao';
  static const String filterClearAll = 'Xóa bộ lọc';
  static const String filterApply = 'Áp dụng bộ lọc';

  // Course Detail & Curriculum (Domain 05)
  static const String courseDetailTitle = 'Chi tiết khóa học';
  static const String bookmarkCourse = 'Lưu yêu thích';
  static const String startLearning = 'Bắt đầu học ngay';
  static const String tabLessons = 'Bài học';
  static const String tabAbout = 'Giới thiệu';
  static const String tabReviews = 'Đánh giá';
  static const String reviewsCountSuffix = 'đánh giá';
  static const String featureFunVideos = 'Fun Videos';
  static const String featureInteractiveQuizzes = 'Interactive Quizzes';
  static const String featureActivitySheets = 'Activity Sheets';
  static const String featureEarnBadges = 'Earn Badges';
  static const String whatYouWillLearn = 'Con sẽ học được gì?';
  static const String aboutCourseHeader = 'Mục tiêu khóa học';
  static const String coachHeader = 'Giáo viên hướng dẫn';
  static const String verifiedEducator = 'Chuyên gia giáo dục';
  static const String bonusBadgePrefix = 'Hoàn thành khóa học để nhận';
  static const String lessonLockedAlert =
      'Con hãy hoàn thành các bài học trước để mở khóa bài này nhé!';
}

