// screen_b.dart
import 'package:POS/utils/colors.dart';
import 'package:POS/utils/sizes.dart';
import 'package:flutter/material.dart';

class Notifikasi extends StatelessWidget {
  const Notifikasi({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: defaultPadding),
        padding: EdgeInsets.symmetric(horizontal: defaultPadding),
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white30,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 10),
              blurRadius: 50,
              color: primaryColor.withOpacity(0.23),
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            HotDealCard(
              image: "assets/facebook2.png",
              title: "Presentasi Pagi",
              location: "07.28",
              price: 200090,
              press: () {
              },
            ),
            HotDealCard(
              image: "assets/facebook2.png",
              title: "Ativitasi",
              location: "-",
              price: 238000,
              press: () {
              },
            ),
            HotDealCard(
              image: "assets/facebook2.png",
              title: "Presentasi Sore",
              location: "-",
              price: 420000,
              press: () {},
            )
          ],
        ),
      ),
    );
  }
}

class HotDealCard extends StatelessWidget {
  const HotDealCard({
    Key key,
    this.image,
    this.title,
    this.location,
    this.price,
    this.press,
  }) : super(key: key);

  final String image, title, location;
  final int price;
  final Function press;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double widthCard = size.width * 0.3 - 15;
    return Container(
      margin: EdgeInsets.only(
        left: 0,
        top: defaultPadding,
        bottom: defaultPadding - 4,
      ),
      width: widthCard,
      child: GestureDetector(
        onTap: press,
        child: Row(
          children: <Widget>[
            Image.asset(image,
              scale: 1,
              width: 24,
              height: 24,),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child :Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          title,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                          )
                      ),
                      Text(
                          location,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                          )
                      )
                    ],
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}
