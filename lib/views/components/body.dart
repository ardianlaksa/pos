import 'package:POS/views/components/notifikasi.dart';
import 'package:flutter/material.dart';
import 'package:POS/utils/colors.dart';
import 'package:POS/utils/sizes.dart';
import 'package:POS/views/components/hot_deals.dart';
import 'package:POS/views/components/title_with_view_all_btn.dart';
import 'package:POS/views/components/top_dealers.dart';
import 'header_with_search_box.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // It will provie us total height  and width of our screen
    Size size = MediaQuery.of(context).size;
    // it enable scrolling on small device
    return Container(
      child: SingleChildScrollView(
        child: Container(
          color: backgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              HeaderWithSearchBox(size: size),
              Notifikasi(),
              HotDeals(),
              TitleWithViewAllBtn(title: "Informasi", press: () {}),
              TopDealers(),
              SizedBox(height: defaultPadding),
            ],
          ),
        ),
      ),
    );
  }
}
