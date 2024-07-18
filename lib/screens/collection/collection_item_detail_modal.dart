import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:math';
import 'package:intl/intl.dart';

import 'package:test_drive/components/collection_list_item.dart';
import 'package:test_drive/components/collectors_list.dart';
import 'package:test_drive/components/sales_history_item.dart';
import 'package:test_drive/components/sales_line_chart.dart';
import 'package:test_drive/components/timeline_buttons.dart';

class CollectionItemDetailModal extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final String ungradedPrice;
  final String psa10Price;
  final String psa9Price;
  final List<dynamic> similarItems;

  CollectionItemDetailModal({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.ungradedPrice,
    required this.psa10Price,
    required this.psa9Price,
    required this.similarItems,
  });

  final List<Map<String, String>> salesHistory = [
    {
      'imageUrl': 'https://via.placeholder.com/56',
      'title': 'Auction',
      'date': 'Feb 13, 2024',
      'price': '\$44.00',
    },
    {
      'imageUrl': 'https://via.placeholder.com/56',
      'title': 'Buy it Now',
      'date': 'Feb 13, 2024',
      'price': '\$44.00',
    },
    {
      'imageUrl': 'https://via.placeholder.com/56',
      'title': 'Auction',
      'date': 'Feb 13, 2024',
      'price': '\$44.00',
    },
    {
      'imageUrl': 'https://via.placeholder.com/56',
      'title': 'Buy it Now',
      'date': 'Feb 13, 2024',
      'price': '\$44.00',
    },
  ];

  String generatePrice() {
    final random = Random();
    final price = (random.nextDouble() * 10000).toStringAsFixed(2);
    final numberFormat = NumberFormat("#,##0.00", "en_US");
    return '\$${numberFormat.format(double.parse(price))}';
  }

  String generatePriceChange() {
    final random = Random();
    final change = (random.nextDouble() * 20 - 10);
    return change.toStringAsFixed(2);
  }

  String formatTitle(dynamic card) {
    final releaseDate = card['set']['releaseDate'];
    final year =
        releaseDate != null ? releaseDate.split('/')[0] : 'Unknown Year';
    return '$year ${card['set']['name']} ${card['name']} - ${card['rarity']} #${card['number']}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 120),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 32,
                  height: 32,
                  child: Material(
                    color: Colors.grey.withOpacity(0.2),
                    shape: const CircleBorder(),
                    child: InkWell(
                      onTap: () => Share.share('Check out this amazing card!',
                          subject: 'My Collection'),
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: SvgPicture.asset('assets/icons/share_icon.svg'),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 32,
                  height: 32,
                  child: Material(
                    color: Colors.grey.withOpacity(0.2),
                    shape: const CircleBorder(),
                    child: InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child:
                            SvgPicture.asset('assets/icons/dismiss_icon.svg'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 0,
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.09),
                  spreadRadius: 0,
                  blurRadius: 3,
                  offset: const Offset(0, 3),
                ),
              ],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.network(imageUrl, height: 300),
          ),
          const SizedBox(height: 40),
          Text(title,
              style:
                  const TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
          Text(subtitle,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: Colors.black.withOpacity(0.5))),
          const SizedBox(height: 40),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: Transform.translate(
                    offset: const Offset(0, -1),
                    child: Divider(
                      color: Colors.grey.withOpacity(0.2),
                      thickness: 1,
                      endIndent: 10,
                    ),
                  ),
                ),
                Text('PRICE ESTIMATE',
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(0.6))),
                Expanded(
                  child: Transform.translate(
                    offset: const Offset(0, -1),
                    child: Divider(
                      color: Colors.grey.withOpacity(0.2),
                      thickness: 1,
                      indent: 10,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildPriceColumn('UNGRADED', ungradedPrice, 'Current value'),
                Container(
                  width: 1,
                  height: 60,
                  color: Colors.grey.withOpacity(0.2),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                ),
                _buildPriceColumn('PSA 10', psa10Price, 'Pop 124'),
                Container(
                  width: 1,
                  height: 60,
                  color: Colors.grey.withOpacity(0.2),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                ),
                _buildPriceColumn('PSA 9', psa9Price, 'Pop 718'),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Divider(
            color: Colors.grey.withOpacity(0.2),
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
          const SizedBox(height: 32),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            margin: const EdgeInsets.only(bottom: 10),
            child: const Text('Sales History',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: salesHistory.length,
            padding: const EdgeInsets.all(0),
            itemBuilder: (context, index) {
              final item = salesHistory[index];
              return SalesHistoryItem(
                imageUrl: item['imageUrl']!,
                title: item['title']!,
                date: item['date']!,
                price: item['price']!,
                onTap: () {},
              );
            },
          ),
          SizedBox(
            height: 60,
            child: Material(
              color: Colors.white,
              child: InkWell(
                  onTap: () {},
                  child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Show 45 more sales',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                decoration: TextDecoration.underline),
                          ),
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: Material(
                              color: Colors.grey.withOpacity(0.1),
                              shape: const CircleBorder(),
                              child: const Icon(Icons.chevron_right),
                            ),
                          ),
                        ],
                      ))),
            ),
          ),
          const SizedBox(height: 32),
          Divider(
            color: Colors.grey.withOpacity(0.2),
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
          const SizedBox(height: 32),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            margin: const EdgeInsets.only(bottom: 10),
            child: const Text('Auction Price Trend',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
          ),
          const Padding(
            padding: EdgeInsets.all(20),
            child: SalesLineChart(),
          ),
          const SizedBox(height: 16),
          const TimelineButtonsRow(),
          const SizedBox(height: 32),
          Divider(
            color: Colors.grey.withOpacity(0.2),
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
          const SizedBox(height: 32),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            margin: const EdgeInsets.only(bottom: 10),
            child: const Text('Collectors with this item',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
          ),
          CollectorsList(),
          const SizedBox(height: 32),
          Divider(
            color: Colors.grey.withOpacity(0.2),
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
          const SizedBox(height: 32),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            margin: const EdgeInsets.only(bottom: 10),
            child: const Text('Similar Items',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: similarItems.length,
            padding: const EdgeInsets.all(0),
            itemBuilder: (BuildContext context, int index) {
              final card = similarItems[index];
              final price = generatePrice();
              final priceChange = generatePriceChange();
              final title = formatTitle(card);

              return InkWell(
                onTap: () => {},
                child: CollectionListItem(
                  imageUrl: card['images']['large'],
                  title: title,
                  grade: 'UNGRADED',
                  price: price,
                  priceChange: priceChange,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPriceColumn(String grade, String price, String description) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(grade,
              style: TextStyle(
                  fontSize: 11,
                  color: Colors.black.withOpacity(0.6),
                  fontWeight: FontWeight.w800)),
          Text(price,
              style:
                  const TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
          Text(description,
              style: TextStyle(
                  fontSize: 11,
                  color: Colors.black.withOpacity(0.6),
                  fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }
}
