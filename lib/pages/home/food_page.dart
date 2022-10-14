import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mystore/controllers/popular_product_controller.dart';
import 'package:mystore/controllers/recommended_product_controller.dart';
import 'package:mystore/models/popular_product_mooel.dart';
import 'package:mystore/routes/routes_helper.dart';
import 'package:mystore/utils/app_constant.dart';
import 'package:mystore/utils/dimension.dart';
import 'package:mystore/widget/app_column.dart';
import 'package:mystore/widget/bigtext.dart';
import 'package:mystore/widget/colors.dart';
import 'package:mystore/widget/icon&text.dart';
import 'package:mystore/widget/smalltext.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  _FoodPageBodyState createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currtPaveValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimen.pageViewCont;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currtPaveValue = pageController.page!;
        // print("current page value is" + _currtPaveValue.toString());
      });
    });
  }

  @override
  // ignore: must_call_super
  void dispose() {
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("------------Food Page----------------");
    return Column(
      children: [
        //slider section
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return popularProducts.isloaded
              ? Container(
                  height: Dimen.pageView,
                  child: PageView.builder(
                      controller: pageController,
                      itemCount: popularProducts.popularProductList.length,
                      itemBuilder: (context, positiion) {
                        return _buildPageItem(positiion,
                            popularProducts.popularProductList[positiion]);
                      }),
                )
              : CircularProgressIndicator(
                  color: ApClrs.mainClr,
                );
        }),

        //Dots section

        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return new DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty
                ? 1
                : popularProducts.popularProductList.length,
            position: _currtPaveValue,
            decorator: DotsDecorator(
              activeColor: ApClrs.mainClr,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimen.radius5)),
            ),
          );
        }),

        //Recommended text
        SizedBox(
          height: Dimen.height30,
        ),
        Container(
          margin: EdgeInsets.only(
            left: Dimen.width30,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Recommended"),
              SizedBox(
                width: Dimen.width10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(
                  text: ".",
                  color: Colors.black26,
                ),
              ),
              SizedBox(
                width: Dimen.width10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SmallTxt(text: "Food Pairing"),
              ),
            ],
          ),
        ),

        //List of images

        GetBuilder<RecommendedProductController>(
            builder: (recommendedProducts) {
          return recommendedProducts.isloaded
              ? ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: recommendedProducts.recommendedProductList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getRecommendedFood(index));
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: Dimen.width20,
                            right: Dimen.width20,
                            bottom: Dimen.height10),
                        child: Row(
                          children: [
                            Container(
                              width: Dimen.listviewSize,
                              height: Dimen.listviewSize,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimen.radius20),
                                color: Colors.white38,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(AppConstants.BASE_URL +
                                      AppConstants.UPLOAD_URL +
                                      recommendedProducts
                                          .recommendedProductList[index].img!),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: Dimen.listviewTxt,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(Dimen.radius20),
                                      bottomRight:
                                          Radius.circular(Dimen.radius20),
                                    ),
                                    color: Colors.white),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: Dimen.width10,
                                      right: Dimen.width10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      BigText(
                                          text: recommendedProducts
                                              .recommendedProductList[index]
                                              .name!),
                                      SizedBox(
                                        height: Dimen.height10,
                                      ),
                                      SmallTxt(text: "With Chinese property"),
                                      SizedBox(
                                        height: Dimen.height10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconAndText(
                                            icon: Icons.circle_sharp,
                                            text: "Normal",
                                            iconColor: ApClrs.iconClr1,
                                          ),
                                          IconAndText(
                                            icon: Icons.location_on,
                                            text: "1.5km",
                                            iconColor: ApClrs.mainClr,
                                          ),
                                          IconAndText(
                                            icon: Icons.access_time_rounded,
                                            text: "Normal",
                                            iconColor: ApClrs.iconClr2,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  })
              : CircularProgressIndicator(
                  color: ApClrs.mainClr,
                );
        }),
      ],
    );
  }

  Widget _buildPageItem(int index, ProductModel popularProduct) {
    Matrix4 matrix = new Matrix4.identity();
    if (index == _currtPaveValue.floor()) {
      var currScale = 1 - (_currtPaveValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currtPaveValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currtPaveValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currtPaveValue.floor() - 1) {
      var currScale = 1 - (_currtPaveValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor / 2), 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getPopularFood(index));
            },
            child: Container(
              height: Dimen.pageViewCont,
              margin:
                  EdgeInsets.only(left: Dimen.width10, right: Dimen.width10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimen.radius30),
                color: index.isEven ? Colors.blueGrey : Color(0xff9294cc),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(AppConstants.BASE_URL +
                      AppConstants.UPLOAD_URL +
                      popularProduct.img!),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimen.pageViewtxtCont120,
              margin: EdgeInsets.only(
                left: Dimen.width30,
                right: Dimen.width30,
                bottom: Dimen.height30,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimen.radius20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xffe8e8e8),
                      blurRadius: 5.0,
                      offset: Offset(0, 5),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-5, 0),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(5, 0),
                    ),
                  ]),
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimen.width15,
                    left: Dimen.width15,
                    right: Dimen.width15),
                child: AppColumn(
                  text: popularProduct.name!,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
