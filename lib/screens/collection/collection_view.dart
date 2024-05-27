import 'package:flutter/material.dart';

import 'package:test_drive/components/collection_header.dart';

import 'tabs/inventory_tab.dart';
import 'tabs/selling_tab.dart';
import 'tabs/sold_tab.dart';
import 'tabs/vault_tab.dart';

class CollectionView extends StatefulWidget {
  const CollectionView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CollectionViewState createState() => _CollectionViewState();
}

class _CollectionViewState extends State<CollectionView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: CollectionHeader(),
        body: TabBarView(
          children: [
            InventoryTab(),
            VaultTab(),
            SellingTab(),
            SoldTab(),
          ],
        ),
      ),
    );
  }
}
