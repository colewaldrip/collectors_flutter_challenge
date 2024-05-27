import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';
import 'package:intl/intl.dart';

import 'package:test_drive/screens/collection/collection_item_detail_modal.dart';

import 'package:test_drive/components/collection_list_item.dart';
import 'package:test_drive/components/gradient_overlay.dart';

class InventoryTab extends StatefulWidget {
  const InventoryTab({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _InventoryTabState createState() => _InventoryTabState();
}

class _InventoryTabState extends State<InventoryTab> {
  List<dynamic> items = [];
  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;
  bool isRefreshing = false;
  int page = 1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        _loadMoreItems();
      }
    });
    _loadMoreItems();
  }

  Future<void> _loadMoreItems() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    // Fetch data from the API
    final response = await http.get(
      Uri.parse(
          'https://api.pokemontcg.io/v2/cards?q=set.name:skyridge&page=$page&pageSize=20'),
      headers: {
        'X-Api-Key': '7308315e-d5e7-40c7-bf90-4918520b5401',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final newItems = jsonResponse['data'];

      setState(() {
        items.addAll(newItems);
        isLoading = false;
        page++;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to load cards');
    }
  }

  Future<void> _refreshItems() async {
    setState(() {
      items.clear();
      isRefreshing = true;
      page = 1;
    });
    await _loadMoreItems();
    setState(() {
      isRefreshing = false;
    });
  }

  String generatePrice() {
    final random = Random();
    final price = (random.nextDouble() * 10000)
        .toStringAsFixed(2); // Generate prices in the thousands
    final numberFormat = NumberFormat("#,##0.00", "en_US");
    return '\$${numberFormat.format(double.parse(price))}';
  }

  String generatePriceChange() {
    final random = Random();
    final change =
        (random.nextDouble() * 20 - 10); // Random value between -10 and 10
    return change.toStringAsFixed(2);
  }

  String formatTitle(dynamic card) {
    final releaseDate = card['set']['releaseDate'];
    final year =
        releaseDate != null ? releaseDate.split('/')[0] : 'Unknown Year';
    return '$year ${card['set']['name']} ${card['name']} - ${card['rarity']} #${card['number']}';
  }

  void _showCollectionItemDetailModal(
      BuildContext context, dynamic card, List<dynamic> similarItems) {
    final releaseDate = card['set']['releaseDate'];
    final year =
        releaseDate != null ? releaseDate.split('/')[0] : 'Unknown Year';
    final price = generatePrice();
    final title = '${card['name']} - ${card['rarity']} #${card['number']}';
    final subtitle = '$year ${card['set']['name']}';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: DraggableScrollableSheet(
            initialChildSize: 0.9,
            minChildSize: 0.9,
            maxChildSize: 1,
            expand: false,
            snap: false,
            shouldCloseOnMinExtent: false,
            builder: (BuildContext context, ScrollController scrollController) {
              return Stack(
                children: [
                  SingleChildScrollView(
                    controller: scrollController,
                    child: CollectionItemDetailModal(
                      imageUrl: card['images']['large'],
                      title: title,
                      subtitle: subtitle,
                      ungradedPrice: price,
                      psa10Price: generatePrice(),
                      psa9Price: generatePrice(),
                      similarItems: similarItems,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        Container(
                          height: 32,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.white.withOpacity(0),
                                Colors.white.withOpacity(1),
                                Colors.white,
                              ],
                            ),
                          ),
                        ),
                        Material(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                ),
                                onPressed: () {},
                                child: const Text(
                                  'Submit for Grading',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                    _loadMoreItems();
                  }
                  return true;
                },
                child: RefreshIndicator(
                  onRefresh: _refreshItems,
                  color: Colors.red,
                  backgroundColor: Colors.white,
                  displacement: 20,
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: items.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      if (isRefreshing) {
                        return const SizedBox.shrink();
                      } else if (isLoading && index == items.length) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: CircularProgressIndicator(
                              color: Colors.grey,
                            ),
                          ),
                        );
                      } else if (index == 0) {
                        return Container(
                          width: double.infinity,
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              side: const BorderSide(
                                  color: Color.fromARGB(255, 230, 228, 228),
                                  width: 1),
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Text('Add to Collection'),
                          ),
                        );
                      } else {
                        final card = items[index - 1];
                        final price = generatePrice();
                        final priceChange = generatePriceChange();
                        final title = formatTitle(card);
                        final similarItems = items.take(5).toList();

                        return InkWell(
                          onTap: () => _showCollectionItemDetailModal(
                              context, card, similarItems),
                          child: CollectionListItem(
                            imageUrl: card['images']['large'],
                            title: title,
                            grade: 'UNGRADED',
                            price: price,
                            priceChange: priceChange,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        const GradientOverlay(),
      ],
    );
  }
}
