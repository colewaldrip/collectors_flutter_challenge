import 'package:flutter/material.dart';

class SalesHistoryItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String date;
  final String price;
  final VoidCallback onTap;

  const SalesHistoryItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.date,
    required this.price,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: double.infinity,
          height: 80,
          child: Center(
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imageUrl,
                  width: 56,
                  height: 56,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
              ),
              subtitle: Text(
                date,
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black.withOpacity(0.6),
                    fontWeight: FontWeight.w600),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    price,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(width: 10),
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}
