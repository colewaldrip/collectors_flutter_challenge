import 'package:flutter/material.dart';

class CollectorItem extends StatelessWidget {
  final String imagePath;
  final String name;
  final String grade;

  const CollectorItem({
    super.key,
    required this.imagePath,
    required this.name,
    required this.grade,
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
                    ClipOval(
                      child: Image.asset(
                        imagePath,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
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
                  ],
                ))));
  }
}
