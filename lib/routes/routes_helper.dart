import 'package:get/get.dart';
import 'package:mystore/pages/home/food/popular_food_details.dart';
import 'package:mystore/pages/home/food/recomended_food_detai.dart';
import 'package:mystore/pages/home/mianpage.dart';

class RouteHelper {
  static const String inittial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";

  static String getInitial() => "$inittial";
  static String getPopularFood(int pageId) => "$popularFood?pageId=$pageId";
  static String getRecommendedFood(int pageId) =>
      "$recommendedFood?pageId=$pageId";

  static List<GetPage> routes = [
    GetPage(name: inittial, page: () => MainPage()),
    GetPage(
        name: popularFood,
        page: () {
          var pageId = Get.parameters["pageId"];
          return PopularFoodDetails(pageId: int.parse(pageId!));
        },
        transition: Transition.fadeIn),
    GetPage(
        name: recommendedFood,
        page: () {
          var pageId = Get.parameters["pageId"];
          return RecomendedFoodDetails(pageId: int.parse(pageId!));
        },
        transition: Transition.fadeIn),
  ];
}
