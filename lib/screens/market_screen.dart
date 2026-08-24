import 'package:flutter/material.dart';

import '../core/app_theme.dart';
import '../core/l10n.dart';
import '../data/mock_data.dart';
import '../data/models.dart';
import '../widgets/charts.dart';
import '../widgets/common.dart';

class MarketScreen extends StatelessWidget {
  const MarketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.tr('mkt.title')),
          actions: const <Widget>[LanguageButton(), SizedBox(width: 14)],
          bottom: TabBar(
            labelColor: AppColors.primary,
            unselectedLabelColor: context.subtleText,
            indicatorColor: AppColors.primary,
            indicatorSize: TabBarIndicatorSize.tab,
            dividerColor: Colors.transparent,
            labelStyle:
                const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            tabs: <Widget>[
              Tab(text: context.tr('mkt.prices')),
              Tab(text: context.tr('mkt.offers')),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[_PricesTab(), _OffersTab()],
        ),
      ),
    );
  }
}

class _PricesTab extends StatelessWidget {
  const _PricesTab();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 28),
      itemCount: MockData.prices.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (BuildContext context, int index) {
        final PriceSeries price = MockData.prices[index];
        final bool up = price.changePct >= 0;
        final Color color = up ? AppColors.primary : AppColors.danger;
        final Crop crop = MockData.cropById(price.cropId);

        return SectionCard(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: crop.color.withOpacity(0.13),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(crop.icon, size: 19, color: crop.color),
                  ),
                  const SizedBox(width: 11),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          context.pick(price.name),
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: context.strongText,
                          ),
                        ),
                        Text(
                          context.tr('mkt.today'),
                          style:
                              TextStyle(fontSize: 11.5, color: context.subtleText),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        price.today.toStringAsFixed(0),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: context.strongText,
                        ),
                      ),
                      Text(
                        context.tr('mkt.perTon'),
                        style: TextStyle(fontSize: 10.5, color: context.subtleText),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SparkLine(values: price.lastWeek, color: color, height: 54),
              const SizedBox(height: 12),
              Row(
                children: <Widget>[
                  Pill(
                    label:
                        '${context.tr('mkt.trend')}  ${up ? '+' : ''}${price.changePct.toStringAsFixed(1)}%',
                    color: color,
                    icon: up ? Icons.trending_up : Icons.trending_down,
                  ),
                  const SizedBox(width: 8),
                  Pill(
                    label:
                        '${context.tr('mkt.forecast')}  ${price.forecastPct >= 0 ? '+' : ''}${price.forecastPct.toStringAsFixed(1)}%',
                    color: price.forecastPct >= 0
                        ? AppColors.primary
                        : AppColors.danger,
                    icon: Icons.auto_graph,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: (price.shouldHold ? AppColors.sun : AppColors.primary)
                      .withOpacity(0.10),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: <Widget>[
                    Icon(
                      price.shouldHold ? Icons.schedule : Icons.sell_outlined,
                      size: 16,
                      color: price.shouldHold ? AppColors.sun : AppColors.primary,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        price.shouldHold
                            ? context.tr('mkt.hold')
                            : context.tr('mkt.sell'),
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                          color:
                              price.shouldHold ? AppColors.sun : AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _OffersTab extends StatelessWidget {
  const _OffersTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 28),
      children: <Widget>[
        SectionCard(
          accent: AppColors.sun,
          onTap: () => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(context.tr('common.soon'))),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.sun.withOpacity(0.14),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.photo_camera_outlined,
                    color: AppColors.sun, size: 21),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      context.tr('mkt.gradeCta'),
                      style: TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w700,
                        color: context.strongText,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      context.tr('mkt.gradeBody'),
                      style: TextStyle(
                        fontSize: 12.5,
                        height: 1.6,
                        color: context.subtleText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SectionTitle(title: context.tr('mkt.openOffers')),
        ...MockData.offers.map((MarketOffer offer) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: SectionCard(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: const Icon(Icons.storefront,
                            size: 20, color: AppColors.primary),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              context.pick(offer.buyer),
                              style: TextStyle(
                                fontSize: 14.5,
                                fontWeight: FontWeight.w700,
                                color: context.strongText,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              '${context.pick(offer.crop)} · ${context.pick(offer.location)}',
                              style: TextStyle(
                                fontSize: 12,
                                color: context.subtleText,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Pill(
                        label: '${context.tr('mkt.grade')} ${offer.grade}',
                        color: offer.grade == 'A'
                            ? AppColors.primary
                            : AppColors.warning,
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: _miniStat(
                          context,
                          value: offer.pricePerTon.toStringAsFixed(0),
                          caption: context.tr('mkt.perTon'),
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 30,
                        color: context.borderColor,
                      ),
                      Expanded(
                        child: _miniStat(
                          context,
                          value: '${offer.tons} ${context.tr('mkt.ton')}',
                          caption: context.tr('mkt.qty'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(context.tr('common.soon'))),
                      ),
                      icon: const Icon(Icons.chat_bubble_outline, size: 17),
                      label: Text(context.tr('mkt.contact')),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primary,
                        side: BorderSide(color: context.borderColor),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _miniStat(
    BuildContext context, {
    required String value,
    required String caption,
  }) {
    return Column(
      children: <Widget>[
        Text(
          value,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: context.strongText,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          caption,
          style: TextStyle(fontSize: 11, color: context.subtleText),
        ),
      ],
    );
  }
}
