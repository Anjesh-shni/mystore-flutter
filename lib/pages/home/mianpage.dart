import 'package:flutter/material.dart';
import 'package:mystore/pages/home/food_page.dart';
import 'package:mystore/utils/dimension.dart';
import 'package:mystore/widget/bigtext.dart';
import 'package:mystore/widget/colors.dart';
import 'package:mystore/widget/smalltext.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    print("---------Main Page------------------");
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Container(
              margin: EdgeInsets.only(
                top: Dimen.height45,
                bottom: Dimen.height15,
              ),
              padding:
                  EdgeInsets.only(left: Dimen.width20, right: Dimen.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      BigText(
                        text: "Kathmandu",
                        color: ApClrs.mainClr,
                      ),
                      Row(
                        children: [
                          SmallTxt(text: "Kapan"),
                          Icon(Icons.arrow_drop_down_rounded),
                        ],
                      ),
                    ],
                  ),
                  Center(
                    child: Container(
                      width: Dimen.height45,
                      height: Dimen.height45,
                      child: Icon(
                        Icons.search,
                        size: Dimen.icon24,
                        color: Colors.white,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimen.radius15),
                        color: ApClrs.mainClr,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // body ection
          Expanded(
              child: SingleChildScrollView(
            child: FoodPageBody(),
          )),
        ],
      ),
    );
  }
}
