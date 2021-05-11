import 'package:flutter/material.dart';

class MarketingHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(width: 1.0, color: Colors.grey[400]),
        color: Colors.white,
      ),
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
      child: Row(
        children: [
          Container(
            height: 80,
            width: 140,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Image(
                image: AssetImage('assets/images/marketplace_browse3x.png'),
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.only(left: 15)),
          Container(
            width: MediaQuery.of(context).size.width / 2.5,
            child: Text(
              'LiveFEED Marketplace is where you buy the content created by LiveFEED users, or offer them a job!',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
