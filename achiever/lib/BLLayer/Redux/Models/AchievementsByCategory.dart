import 'package:achiever/BLLayer/Models/Achievement/Achievement.dart';
import 'package:meta/meta.dart';

class AchievementsByCategory {
  List<Achievement> all, my;

  AchievementsByCategory({
    @required this.all, 
    @required this.my
  });
}