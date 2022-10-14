import 'package:flutter/material.dart';
import 'package:mystore/controllers/cart_controller.dart';
import 'package:mystore/controllers/popular_product_controller.dart';
import 'package:mystore/utils/app_constant.dart';
import 'package:mystore/utils/dimension.dart';
import 'package:mystore/widget/app_column.dart';
import 'package:mystore/widget/app_icon.dart';
import 'package:mystore/widget/bigtext.dart';
import 'package:mystore/widget/colors.dart';
import 'package:mystore/widget/expandble_text.dart';
import 'package:mystore/widget/icon&text.dart';
import 'package:mystore/widget/smalltext.dart';
import 'package:get/get.dart';

class PopularFoodDetails extends StatelessWidget {
  final int pageId;
  const PopularFoodDetails({Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularProductList[pageId];

    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            // food details image section
            Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimen.dettailsFood,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(AppConstants.BASE_URL +
                        AppConstants.UPLOAD_URL +
                        product.img!),
                  ),
                ),
              ),
            ),

            // food details icon section
            Positioned(
              top: Dimen.height45,
              left: Dimen.width20,
              right: Dimen.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: AppIcon(icon: Icons.arrow_back_ios),
                  ),
                  GetBuilder<PopularProductController>(builder: (controller) {
                    return Stack(
                      children: [
                        AppIcon(
                          icon: Icons.shopping_cart_outlined,
                        ),
                        Get.find<PopularProductController>().totalItems >= 1
                            ? Positioned(
                                right: 0,
                                top: 0,
                                child: AppIcon(
                                  icon: Icons.circle,
                                  size: 20,
                                  iconColor: Colors.transparent,
                                  backgound: ApClrs.mainClr,
                                ),
                              )
                            : Container(),
                        Get.find<PopularProductController>().totalItems >= 1
                            ? Positioned(
                                right: 4,
                                top: 4,
                                child: BigText(
                                  text: Get.find<PopularProductController>()
                                      .totalItems
                                      .toString(),
                                  size: 12,
                                  color: Colors.amber,
                                ),
                              )
                            : Container(),
                      ],
                    );
                  }),
                ],
              ),
            ),

            // food details header
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: Dimen.dettailsFood - 20,
              child: Container(
                  padding: EdgeInsets.only(
                      left: Dimen.width20,
                      right: Dimen.width20,
                      top: Dimen.height20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimen.radius20),
                      topRight: Radius.circular(Dimen.radius20),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppColumn(text: product.name!),
                      SizedBox(
                        height: Dimen.height20,
                      ),
                      BigText(text: "Introduce"),
                      SizedBox(
                        height: Dimen.height20,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: ExpandbleText(text: product.description!),
                        ),
                      ),
                    ],
                  )),
            ),

            //
          ],
        ),
        bottomNavigationBar:
            GetBuilder<PopularProductController>(builder: (popularProduct) {
          return Container(
            height: Dimen.bottomNav,
            padding: EdgeInsets.only(
                top: Dimen.height30,
                bottom: Dimen.height30,
                right: Dimen.width20,
                left: Dimen.width20),
            decoration: BoxDecoration(
              color: ApClrs.btnbackgroundClr,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimen.radius20 * 2),
                topRight: Radius.circular(Dimen.radius20 * 2),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                      top: Dimen.height20,
                      bottom: Dimen.height20,
                      left: Dimen.width20,
                      right: Dimen.width20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Dimen.radius20),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          popularProduct.setQuantity(false);
                        },
                        child: Icon(
                          Icons.remove,
                          color: ApClrs.signClr,
                        ),
                      ),
                      SizedBox(
                        width: Dimen.width5,
                      ),
                      BigText(text: popularProduct.inCartItem.toString()),
                      SizedBox(
                        width: Dimen.width5,
                      ),
                      GestureDetector(
                        onTap: () {
                          popularProduct.setQuantity(true);
                        },
                        child: Icon(
                          Icons.add,
                          color: ApClrs.signClr,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    popularProduct.addItem(product);
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        top: Dimen.height20,
                        bottom: Dimen.height20,
                        left: Dimen.width20,
                        right: Dimen.width20),
                    child: BigText(
                      text: "\$${product.price!}|Add to Cart",
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                      color: ApClrs.mainClr,
                      borderRadius: BorderRadius.circular(Dimen.radius20),
                    ),
                  ),
                ),
              ],
            ),
          );
        }));
  }
}
