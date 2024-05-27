import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CollectionListItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String grade;
  final String price;
  final String priceChange;

  const CollectionListItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.grade,
    required this.price,
    required this.priceChange,
  });

  @override
  Widget build(BuildContext context) {
    bool isPriceChangePositive = !priceChange.startsWith('-');
    String displayPriceChange =
        isPriceChangePositive ? priceChange : priceChange.substring(1);

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(
                4.0), // Adjust the border radius as needed
            child: Image.network(
              imageUrl,
              width: 80,
              height: 110,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  grade,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          WidgetSpan(
                            child: Transform.translate(
                              offset: const Offset(0, 3),
                              child: const Text(
                                '\$',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                          const WidgetSpan(
                            child: SizedBox(width: 2),
                          ),
                          TextSpan(
                            text: price.substring(1),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.only(top: 3),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 2),
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              isPriceChangePositive
                                  ? 'assets/icons/arrow_up_icon.svg'
                                  : 'assets/icons/arrow_down_icon.svg',
                              // ignore: deprecated_member_use
                              color: isPriceChangePositive
                                  ? Colors.green
                                  : Colors.red,
                              width: 14,
                              height: 14,
                            ),
                          ),
                          Text(
                            '$displayPriceChange%',
                            style: TextStyle(
                              color: isPriceChangePositive
                                  ? Colors.green
                                  : Colors.red,
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
