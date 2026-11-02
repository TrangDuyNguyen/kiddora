import '../../../../core/constants/app_assets.dart';
import '../../domain/models/course.dart';
import '../../domain/models/lesson.dart';

class MockCourseDatasource {
  static const List<Lesson> amazingAnimalsLessons = [
    Lesson(
      id: 'lesson_anim_01',
      orderIndex: 1,
      title: 'Meet the Animals',
      durationMins: 10,
      thumbnailUrl: AppAssets.avatarLion,
      isUnlocked: true,
      isCompleted: true,
    ),
    Lesson(
      id: 'lesson_anim_02',
      orderIndex: 2,
      title: 'Animals and Their Habitats',
      durationMins: 12,
      thumbnailUrl: AppAssets.avatarBear,
      isUnlocked: true,
      isCompleted: false,
    ),
    Lesson(
      id: 'lesson_anim_03',
      orderIndex: 3,
      title: 'Food and Eating Habits',
      durationMins: 10,
      thumbnailUrl: AppAssets.avatarDino,
      isUnlocked: false,
      isCompleted: false,
    ),
    Lesson(
      id: 'lesson_anim_04',
      orderIndex: 4,
      title: 'Animal Life Cycles',
      durationMins: 15,
      thumbnailUrl: AppAssets.zodiacDragon,
      isUnlocked: false,
      isCompleted: false,
    ),
    Lesson(
      id: 'lesson_anim_05',
      orderIndex: 5,
      title: 'How We Can Help',
      durationMins: 10,
      thumbnailUrl: AppAssets.avatarBunny,
      isUnlocked: false,
      isCompleted: false,
    ),
  ];

  static List<Course> getBenchmarkCourses() {
    return [
      const Course(
        id: 'course_amazing_animals',
        title: 'Amazing Animals',
        subtitle: 'Discover the wonderful world of animals and their habitats!',
        description:
            'Join us on an exciting journey to learn about different animals, their habitats, and how they live in our amazing world. This course is designed to be fun, interactive, and easy to understand!',
        category: 'science',
        minAge: 7,
        maxAge: 10,
        level: 'beginner',
        totalLessons: 5,
        rating: 4.8,
        reviewCount: 320,
        thumbnailUrl: AppAssets.courseAmazingAnimals,
        isFeatured: true,
        lessons: amazingAnimalsLessons,
      ),
      const Course(
        id: 'course_space_exploration',
        title: 'Space Exploration',
        subtitle: 'Blast off into outer space to explore planets, stars, rockets, and astronauts!',
        description:
            'Blast off into outer space to explore planets, stars, rockets, and astronauts in our solar system!',
        category: 'science',
        minAge: 8,
        maxAge: 12,
        level: 'intermediate',
        totalLessons: 5,
        rating: 4.9,
        reviewCount: 215,
        thumbnailUrl: AppAssets.courseSpaceExploration,
        isFeatured: true,
      ),
      const Course(
        id: 'course_math_fun_numbers',
        title: 'Math Fun with Numbers',
        subtitle: 'Master mental math and playful number puzzles!',
        description:
            'Master mental math, addition, subtraction, and fun number puzzles through interactive games!',
        category: 'math',
        minAge: 7,
        maxAge: 10,
        level: 'beginner',
        totalLessons: 5,
        rating: 4.7,
        reviewCount: 180,
        thumbnailUrl: AppAssets.courseMathFun,
        isFeatured: true,
      ),
      const Course(
        id: 'course_creative_drawing',
        title: 'Creative Drawing',
        subtitle: 'Unleash your artistic imagination with shapes and colors!',
        description:
            'Unleash your imagination with shapes, colors, and step-by-step character drawing lessons!',
        category: 'arts',
        minAge: 7,
        maxAge: 12,
        level: 'beginner',
        totalLessons: 5,
        rating: 4.8,
        reviewCount: 145,
        thumbnailUrl: AppAssets.courseCreativeDrawing,
        isFeatured: true,
      ),
      const Course(
        id: 'course_our_planet',
        title: 'Our Planet',
        subtitle: 'Discover oceans, continents, weather, and protect Earth!',
        description:
            'Discover oceans, continents, weather, and how we can protect our beautiful Earth!',
        category: 'science',
        minAge: 8,
        maxAge: 12,
        level: 'intermediate',
        totalLessons: 6,
        rating: 4.6,
        reviewCount: 98,
        thumbnailUrl: AppAssets.zodiacDragon,
        isFeatured: false,
      ),
      const Course(
        id: 'course_intro_technology',
        title: 'Intro to Technology',
        subtitle: 'Learn how computers, robots, and smart inventions work!',
        description:
            'Learn how computers, robots, and smart inventions work in our daily lives!',
        category: 'technology',
        minAge: 9,
        maxAge: 12,
        level: 'advanced',
        totalLessons: 5,
        rating: 4.9,
        reviewCount: 260,
        thumbnailUrl: AppAssets.zodiacMonkey,
        isFeatured: false,
      ),
    ];
  }
}

