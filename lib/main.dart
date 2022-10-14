import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:get/get.dart';
import 'package:mystore/controllers/popular_product_controller.dart';
import 'package:mystore/controllers/recommended_product_controller.dart';
import 'package:mystore/models/popular_product_mooel.dart';
import 'package:mystore/pages/home/food/popular_food_details.dart';
import 'package:mystore/pages/home/food/recomended_food_detai.dart';
import 'package:mystore/pages/home/mianpage.dart';
import 'package:mystore/routes/routes_helper.dart';
import 'helper/dependecies.dart' as dep;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.find<PopularProductController>().getPopulaProductList();
    Get.find<RecommendedProductController>().getRecommendedProductList();

    print("-------------App Started---------------");
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nvida',
      home: MainPage(),
      initialRoute: RouteHelper.inittial,
    );
  }
}
