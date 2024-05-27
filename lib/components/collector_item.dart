import 'package:flutter/material.dart';

class CollectorItem extends StatelessWidget {
  final String imagePath;
  final String name;
  final String grade;
  final bool forSale;

  const CollectorItem({
    super.key,
    required this.imagePath,
    required this.name,
    required this.grade,
    required this.forSale,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white,
        child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(8),
            child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ClipOval(
                          child: Image.asset(
                            imagePath,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        if (forSale)
                          Positioned(
                            bottom: -2,
                            right: -2,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                border:
                                    Border.all(width: 1.5, color: Colors.white),
                                shape: BoxShape.circle,
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 18,
                                minHeight: 18,
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.attach_money,
                                  color: Colors.white,
                                  size: 14,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      name,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w800),
                    ),
                    Text(
                      grade,
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Colors.black.withOpacity(0.6)),
                    ),
                    // if (forSale) ...[
                    //   const Text(
                    //     'FOR SALE',
                    //     style: TextStyle(
                    //       fontSize: 10,
                    //       fontWeight: FontWeight.w900,
                    //       color: Colors.green,
                    //     ),
                    //   )
                    // ],
                  ],
                ))));
  }
}
