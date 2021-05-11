import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livefeed/advertising/bloc/current_ads/current_ads_bloc.dart';
import 'package:livefeed/advertising/models/current_ad.dart';
import 'package:livefeed/theme.dart';

class CurrentAds extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mainColumn = Column(
      children: [
        _CardHeader(),
        _AdsDisplay(),
      ],
    );

    return Container(
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(4.0),
        border: Border.all(width: 1.0, color: Colors.grey[400]),
        color: Colors.white,
      ),
      child: mainColumn,
    );
  }
}

class _CardHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          title: Text(
            'MY ADS',
            style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
              color: Colors.grey[800],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Divider(
          height: 1,
          thickness: 1,
        ),
      ],
    );
  }
}

class _AdsDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentAdsBloc, CurrentAdsState>(
      builder: (context, state) {
        var items = <Widget>[];
        state.ads.forEach((ad) {
          items.add(_AdDisplay(ad));
          items.add(VerticalDivider(
            width: 30,
            thickness: 1,
          ));
        });
        return ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 220),
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: 20),
            children: [
              const Padding(padding: EdgeInsets.only(left: 20)),
              ...items,
            ],
          ),
        );
      },
    );
  }
}

class _AdDisplay extends StatelessWidget {
  final CurrentAd ad;
  _AdDisplay(this.ad);

  Widget _buildTitle() {
    var title = '';
    switch (ad.targetMarket) {
      case TargetMarket.worldwide:
        title = 'Worldwide';
        return Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        );
      case TargetMarket.local:
        title = 'Local';
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Wrap(
              children: [
                Icon(
                  Icons.location_pin,
                  size: 12,
                  color: LiveFeedTheme.theme.highlightColor,
                ),
                Text(
                  '${ad.address} ${ad.zipCode}',
                  style: TextStyle(
                    color: LiveFeedTheme.theme.highlightColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        );
      case TargetMarket.hyperlocal:
        title = 'Hyperlocal';
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Wrap(
              children: [
                Icon(
                  Icons.location_pin,
                  size: 12,
                  color: LiveFeedTheme.theme.highlightColor,
                ),
                Text(
                  '${ad.address} ${ad.zipCode}',
                  style: TextStyle(
                    color: LiveFeedTheme.theme.highlightColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        );
    }
  }

  Widget _buildImage() {
    return Container(
      height: 135,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        image: DecorationImage(
          fit: ad.targetMarket == TargetMarket.worldwide
              ? BoxFit.contain
              : BoxFit.fitWidth,
          image: AssetImage(ad.imagePath),
        ),
      ),
    );
  }

  Widget _buildControls(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () =>
              context.read<CurrentAdsBloc>().add(AdEnableToggled(ad.id)),
          child: Icon(
            ad.enabled ? Icons.pause : Icons.play_arrow,
            color: LiveFeedTheme.theme.highlightColor,
            size: 25,
          ),
        ),
        const Padding(padding: EdgeInsets.only(left: 15)),
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.contain,
              image: AssetImage('assets/images/pen3x.png'),
            ),
          ),
        ),
        const Padding(padding: EdgeInsets.only(left: 20)),
        GestureDetector(
          onTap: () => context.read<CurrentAdsBloc>().add(AdDeleted(ad.id)),
          child: Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage('assets/images/delete3x.png'),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ad.targetMarket == TargetMarket.worldwide ? 140 : 220,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(padding: EdgeInsets.only(top: 10)),
          _buildTitle(),
          const Padding(padding: EdgeInsets.only(top: 10)),
          _buildImage(),
          const Padding(padding: EdgeInsets.only(top: 10)),
          _buildControls(context),
        ],
      ),
    );
  }
}
