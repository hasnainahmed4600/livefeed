import 'package:flutter/material.dart';
import 'package:livefeed/theme.dart';
import 'package:livefeed/timeline_post/models/recommendation.dart';
import 'package:intl/intl.dart';
import 'package:livefeed/timeline_post/screen/timeline_post_screen.dart';

class RecommendationsPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'DID YOU SEE THIS?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          _RecommendationsList(),
        ],
      ),
    );
  }
}

class _RecommendationsList extends StatelessWidget {
  final List<Recommendation> recommendations = [
    Recommendation(
      category: 'POLITICS',
      imagePath: 'assets/images/rocket_car.png',
      message: 'Mike Pence Didn\'t Wear A Face Mask To The Mayo Clinic Even.',
      postDate: DateTime(DateTime.now().year, DateTime.now().month - 3,
          DateTime.now().day - 2),
    ),
    Recommendation(
      category: 'POLITICS',
      imagePath: 'assets/images/rocket_car.png',
      message: 'Mike Pence Didn\'t Wear A Face Mask To The Mayo Clinic Even.',
      postDate: DateTime(DateTime.now().year, DateTime.now().month - 3,
          DateTime.now().day - 2),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    var cards = <_RecommendationCard>[];
    recommendations.forEach((recommendation) {
      cards.add(_RecommendationCard(recommendation));
    });
    return Container(
      height: 250,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(top: 10),
        children: cards,
      ),
    );
  }
}

class _RecommendationCard extends StatelessWidget {
  final Recommendation recommendation;
  _RecommendationCard(this.recommendation);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(TimelinePostScreen.route()),
      child: Container(
        width: 270,
        margin: EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(width: 1.0, color: Colors.grey[400]),
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                width: double.infinity,
                height: 120,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Image(
                    image: AssetImage(
                      recommendation.imagePath,
                    ),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 5)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    recommendation.category.toUpperCase(),
                    style: TextStyle(
                      color: LiveFeedTheme.theme.highlightColor,
                    ),
                  ),
                  Text(
                    '${DateFormat.MMMMd().format(recommendation.postDate)}',
                    style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.only(top: 10)),
              Text(
                recommendation.message,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 3)),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'See more...',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: LiveFeedTheme.theme.highlightColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
