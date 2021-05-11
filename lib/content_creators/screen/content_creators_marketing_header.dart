import 'package:flutter/material.dart';

class ContentCreatorsMarketingHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(width: 1.0, color: Colors.grey[400]),
        color: Colors.white,
      ),
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              height: 80,
              width: 120,
              margin: EdgeInsets.only(left: 40),
              child: FittedBox(
                fit: BoxFit.fill,
                child: Image(
                  image: AssetImage('assets/images/blogger_girl3x.png'),
                ),
              ),
            ),
          ),
          // const Padding(padding: EdgeInsets.only(left: 15)),
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.only(left: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Share and monetize',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'the content you created',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
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
