import 'package:flutter/material.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';

class AvatarPresets {
  static const List<Map<String, dynamic>> classicAvatars = [
    {
      'id': 'lion',
      'name': AppStrings.avatarLeo,
      'path': AppAssets.avatarLion,
      'auraColor': AppColors.brandAmberContainer,
    },
    {
      'id': 'bear',
      'name': AppStrings.avatarBarnaby,
      'path': AppAssets.avatarBear,
      'auraColor': Color(0xFFFED7AA),
    },
    {
      'id': 'dino',
      'name': AppStrings.avatarDino,
      'path': AppAssets.avatarDino,
      'auraColor': AppColors.brandMintContainer,
    },
    {
      'id': 'bunny',
      'name': AppStrings.avatarBunny,
      'path': AppAssets.avatarBunny,
      'auraColor': AppColors.brandPinkContainer,
    },
  ];

  static const List<Map<String, dynamic>> zodiacAvatars = [
    {
      'id': 'zodiac_mouse',
      'name': AppStrings.zodiacTy,
      'path': AppAssets.zodiacMouse,
      'auraColor': AppColors.brandAmberContainer,
    },
    {
      'id': 'zodiac_buffalo',
      'name': AppStrings.zodiacSuu,
      'path': AppAssets.zodiacBuffalo,
      'auraColor': AppColors.brandMintContainer,
    },
    {
      'id': 'zodiac_tiger',
      'name': AppStrings.zodiacDan,
      'path': AppAssets.zodiacTiger,
      'auraColor': Color(0xFFFED7AA),
    },
    {
      'id': 'zodiac_cat',
      'name': AppStrings.zodiacMao,
      'path': AppAssets.zodiacCat,
      'auraColor': AppColors.brandIndigoContainer,
    },
    {
      'id': 'zodiac_dragon',
      'name': AppStrings.zodiacThin,
      'path': AppAssets.zodiacDragon,
      'auraColor': AppColors.brandMintContainer,
    },
    {
      'id': 'zodiac_snake',
      'name': AppStrings.zodiacTy2,
      'path': AppAssets.zodiacSnake,
      'auraColor': Color(0xFFECFDF5),
    },
    {
      'id': 'zodiac_horse',
      'name': AppStrings.zodiacNgo,
      'path': AppAssets.zodiacHorse,
      'auraColor': AppColors.brandSkyContainer,
    },
    {
      'id': 'zodiac_goat',
      'name': AppStrings.zodiacMui,
      'path': AppAssets.zodiacGoat,
      'auraColor': Color(0xFFF3E8FF),
    },
    {
      'id': 'zodiac_monkey',
      'name': AppStrings.zodiacThan,
      'path': AppAssets.zodiacMonkey,
      'auraColor': Color(0xFFFED7AA),
    },
    {
      'id': 'zodiac_rooster',
      'name': AppStrings.zodiacDau,
      'path': AppAssets.zodiacRooster,
      'auraColor': Color(0xFFFEF08A),
    },
    {
      'id': 'zodiac_dog',
      'name': AppStrings.zodiacTuat,
      'path': AppAssets.zodiacDog,
      'auraColor': AppColors.brandAmberContainer,
    },
    {
      'id': 'zodiac_pig',
      'name': AppStrings.zodiacHoi,
      'path': AppAssets.zodiacPig,
      'auraColor': AppColors.brandPinkContainer,
    },
  ];

  static String suggestedZodiacForAge(int age) {
    switch (age) {
      case 6:
        return 'zodiac_mouse'; // 2020 - Tý
      case 7:
        return 'zodiac_pig'; // 2019 - Hợi
      case 8:
        return 'zodiac_dog'; // 2018 - Tuất
      case 9:
        return 'zodiac_rooster'; // 2017 - Dậu
      case 10:
        return 'zodiac_monkey'; // 2016 - Thân
      case 11:
        return 'zodiac_goat'; // 2015 - Mùi
      case 12:
        return 'zodiac_horse'; // 2014 - Ngọ
      default:
        return 'zodiac_dog';
    }
  }
}
