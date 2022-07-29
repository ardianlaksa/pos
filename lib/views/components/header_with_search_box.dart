import 'package:flutter/material.dart';
import 'package:POS/utils/colors.dart';
import 'package:POS/utils/sizes.dart';


class HeaderWithSearchBox extends StatelessWidget {
  const HeaderWithSearchBox({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: defaultPadding),
      height: size.height * 0.3 - 35,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: defaultPadding,
              right: defaultPadding,
            ),
            height: size.height * 0.2 - 27,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
            child: Row(
              children: <Widget>[
                Text(
                  'Hi Surya Tri',
                  style: Theme.of(context).textTheme.headline5.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Icon(Icons.person_pin, color: Colors.white, size: 64,)
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: defaultPadding),
              padding: EdgeInsets.symmetric(horizontal: defaultPadding),
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
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
                  HotDealCard1(
                    image: "assets/facebook2.png",
                    title: "Jam Digital",
                    location: "09 : 47",
                    price: 200090,
                    press: () {
                    },
                  ),
                  HotDealCard(
                    image: "assets/facebook2.png",
                    title: "+ Presentasi",
                    location: "Dolok Sanggul",
                    price: 238000,
                    press: () {
                    },
                  ),
                  HotDealCard(
                    image: "assets/facebook2.png",
                    title: "+ Aktivitas",
                    location: "Medan",
                    price: 420000,
                    press: () {},
                  )
                ],
              ),
            ),
          ),
        ],
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
    final double widthCard = size.width * 0.2;
    return Container(
      margin: EdgeInsets.only(
        left: defaultPadding,
        top: defaultPadding,
        bottom: defaultPadding,
      ),
      width: widthCard,
      child: GestureDetector(
        onTap: press,
        child: Column(
          children: <Widget>[
            Image.asset(image,
            scale: 1,
            width: 24,
            height: 24,),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child :Column(
                    children: [
                      Text(
                          title,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                          )
                      ),
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

class HotDealCard1 extends StatelessWidget {
  const HotDealCard1({
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
    final double widthCard = size.width * 0.2;
    return Container(
      margin: EdgeInsets.only(
        left: defaultPadding,
        top: defaultPadding,
        bottom: defaultPadding,
      ),
      width: widthCard,
      child: GestureDetector(
        onTap: press,
        child: Column(
          children: <Widget>[
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child :Column(
                    children: [
                      Text(
                          title,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                          )
                      ),
                    ],
                  ),
                )
            ),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child :Column(
                    children: [
                      Text(
                          location,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          )
                      ),
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
