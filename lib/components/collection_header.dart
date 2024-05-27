import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CollectionHeader extends StatelessWidget implements PreferredSizeWidget {
  const CollectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    String avatarUrl =
        'https://media.licdn.com/dms/image/D5603AQG3bZ1xjKdIhw/profile-displayphoto-shrink_400_400/0/1716481854980?e=1722470400&v=beta&t=CpYX2EF8lvrKFiCzWaFdb9e3V_-eHsDJRYsNE7j5aSw';

    return Container(
      color: Colors.red,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
              child: SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {},
                      child: CircleAvatar(
                        radius: 16,
                        backgroundImage: NetworkImage(avatarUrl),
                      ),
                    ),
                    const Text(
                      'COLLECTION',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    IconButton(
                      icon: SvgPicture.asset('assets/icons/search_icon.svg'),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            TabBar(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              isScrollable: false,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white,
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: const EdgeInsets.symmetric(vertical: 3),
              dividerHeight: 0,
              labelColor: Colors.red,
              unselectedLabelColor: Colors.white,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              labelPadding: const EdgeInsets.symmetric(horizontal: 0),
              tabs: const [
                Tab(text: 'Inventory'),
                Tab(text: 'Vault'),
                Tab(text: 'Selling'),
                Tab(text: 'Sold'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(112);
}
