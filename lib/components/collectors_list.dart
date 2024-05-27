import 'package:flutter/material.dart';
import 'collector_item.dart';

class CollectorsList extends StatelessWidget {
  final List<Map<String, String>> collectors = [
    {
      'imagePath': 'assets/images/avatar_5.png',
      'name': 'Pikachu',
      'grade': 'Raw',
      'forSale': 'false'
    },
    {
      'imagePath': 'assets/images/avatar_1.png',
      'name': 'Brock',
      'grade': 'PSA 9',
      'forSale': 'true'
    },
    {
      'imagePath': 'assets/images/avatar_2.png',
      'name': 'Ditto',
      'grade': 'Raw',
      'forSale': 'false'
    },
    {
      'imagePath': 'assets/images/avatar_3.png',
      'name': 'Ash',
      'grade': 'PSA 4',
      'forSale': 'true'
    },
    {
      'imagePath': 'assets/images/avatar_4.png',
      'name': 'Bulba',
      'grade': 'Raw',
      'forSale': 'false'
    },
    {
      'imagePath': 'assets/images/avatar_6.png',
      'name': 'Yikes',
      'grade': 'PSA 10',
      'forSale': 'true'
    },
  ];

  CollectorsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 130,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            itemCount: collectors.length,
            itemBuilder: (context, index) {
              final collector = collectors[index];

              return CollectorItem(
                imagePath: collector['imagePath']!,
                name: collector['name']!,
                grade: collector['grade']!,
                forSale: collector['forSale']! == 'true',
              );
            },
          ),
        ),
        const SizedBox(height: 10),
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
                          'Show 200 more collectors',
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
      ],
    );
  }
}
