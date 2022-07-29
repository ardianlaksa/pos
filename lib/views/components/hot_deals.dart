import 'package:flutter/material.dart';
import 'package:POS/utils/colors.dart';
import 'package:POS/utils/sizes.dart';

class HotDeals extends StatelessWidget {
  const HotDeals({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            children: <Widget>[
              HotDealCard(
                image: "assets/porsche/porsche_911.png",
                title: "Presensi",
                location: "Toba Samosir",
                price: 200090,
                press: () {
                },
              ),
              HotDealCard(
                image: "assets/porsche/porsche_boxster.png",
                title: "Aktivitas",
                location: "Dolok Sanggul",
                price: 238000,
                press: () {
                },
              ),
              HotDealCard(
                image: "assets/porsche/porsche_cayman.png",
                title: "Kalender",
                location: "Medan",
                price: 420000,
                press: () {},
              )
            ],
          ),
          Row(
            children: <Widget>[
              HotDealCard(
                image: "assets/porsche/porsche_911.png",
                title: "Layanan TI",
                location: "Toba Samosir",
                price: 200090,
                press: () {
                },
              ),
              HotDealCard(
                image: "assets/porsche/porsche_boxster.png",
                title: "Cuti",
                location: "Dolok Sanggul",
                price: 238000,
                press: () {
                },
              ),
              HotDealCard(
                image: "assets/porsche/porsche_cayman.png",
                title: "Siap Data - Colector",
                location: "Medan",
                price: 420000,
                press: () {},
              )
            ],
          ),
        ],
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
    final double widthCard = size.width * 0.3;
    return Container(
      margin: EdgeInsets.only(
        left: 8,
        top: defaultPadding / 2,
        bottom: defaultPadding,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      width: widthCard,
      child: GestureDetector(
        onTap: press,
        child: Column(
          children: <Widget>[
            Image.asset(image),
            SizedBox(
              width: widthCard,
              child: FlatButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                color: primaryColor,
                onPressed: () {},
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
