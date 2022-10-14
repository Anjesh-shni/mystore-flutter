import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mystore/controllers/cart_controller.dart';
import 'package:mystore/utils/app_constant.dart';
import 'package:mystore/utils/dimension.dart';
import 'package:mystore/widget/app_icon.dart';
import 'package:mystore/widget/bigtext.dart';
import 'package:mystore/widget/colors.dart';
import 'package:mystore/widget/smalltext.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: Dimen.width20,
            right: Dimen.width20,
            top: Dimen.height30 * 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                  icon: Icons.arrow_back_ios,
                  iconColor: Colors.white,
                  backgound: ApClrs.mainClr,
                  iconSize: Dimen.icon24,
                ),
                SizedBox(
                  width: Dimen.width20 * 2,
                ),
                AppIcon(
                  icon: Icons.home_outlined,
                  iconColor: Colors.white,
                  backgound: ApClrs.mainClr,
                  iconSize: Dimen.icon24,
                ),
                AppIcon(
                  icon: Icons.shopping_cart_outlined,
                  iconColor: Colors.white,
                  backgound: ApClrs.mainClr,
                  iconSize: Dimen.icon24,
                )
              ],
            ),
          ),
          Positioned(
            top: Dimen.height20 * 5,
            left: Dimen.width20,
            bottom: Dimen.width20,
            child: Container(
              margin: EdgeInsets.only(top: Dimen.height15),
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: GetBuilder<CartController>(builder: (cartController) {
                  return ListView.builder(
                      itemCount: cartController.getItems.length,
                      itemBuilder: (_, index) {
                        return Container(
                          height: Dimen.height20 * 5,
                          width: double.maxFinite,
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  bottom: Dimen.height10,
                                ),
                                height: Dimen.height20 * 5,
                                width: Dimen.height20 * 5,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(Dimen.radius20),
                                  color: Colors.white,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(AppConstants.BASE_URL +
                                        AppConstants.UPLOAD_URL +
                                        cartController.getItems[index].img!),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                }),
              ),
            ),
          ),
          SizedBox(
            width: Dimen.width10,
          ),
          Expanded(
            child: Container(
              height: Dimen.height20 * 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // BigText(text: cartController.getItems[index].name!),
                  SmallTxt(text: "text"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // BigText(text: cartController.getItems[index.name!]),
                      Container(
                        padding: EdgeInsets.only(
                            top: Dimen.height10,
                            bottom: Dimen.height10,
                            left: Dimen.width10,
                            right: Dimen.width10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(Dimen.radius20),
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                // popularProduct.setQuantity(false);
                              },
                              child: Icon(
                                Icons.remove,
                                color: ApClrs.signClr,
                              ),
                            ),
                            SizedBox(
                              width: Dimen.width5,
                            ),
                            // BigText(text: popularProduct.inCartItem.toString()),
                            SizedBox(
                              width: Dimen.width5,
                            ),
                            GestureDetector(
                              onTap: () {
                                // popularProduct.setQuantity(true);
                              },
                              child: Icon(
                                Icons.add,
                                color: ApClrs.signClr,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
