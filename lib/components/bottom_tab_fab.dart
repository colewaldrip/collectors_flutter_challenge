import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomTabFab extends StatelessWidget {
  final String iconPath;
  final Function onPressed;

  const BottomTabFab({
    super.key,
    required this.iconPath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      decoration: const BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: SvgPicture.asset('assets/icons/camera_icon.svg',
            // ignore: deprecated_member_use
            color: Colors.white),
        onPressed: () => onPressed(),
        splashColor: Colors.white,
        highlightColor: Colors.grey[800],
      ),
    );
  }
}
