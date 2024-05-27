import 'package:flutter/material.dart';

class TimelineButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;

  const TimelineButton(
      {super.key,
      required this.text,
      required this.isSelected,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey.withOpacity(0.2) : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: GestureDetector(
          onTap: onPressed,
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.black,
                fontWeight:
                    FontWeight.w800, // Set font weight to 800 for all buttons
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TimelineButtonsRow extends StatefulWidget {
  const TimelineButtonsRow({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TimelineButtonsRowState createState() => _TimelineButtonsRowState();
}

class _TimelineButtonsRowState extends State<TimelineButtonsRow> {
  String _selectedButton = '6M';

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: ['2W', '1M', '3M', '6M', '1Y', 'ALL'].map((text) {
        return TimelineButton(
          text: text,
          isSelected: _selectedButton == text,
          onPressed: () {
            setState(() {
              _selectedButton = text;
            });
          },
        );
      }).toList(),
    );
  }
}
