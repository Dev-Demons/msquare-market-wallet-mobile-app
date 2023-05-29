import 'package:msquare_market/v2/core/constants/colors.dart';
import 'package:msquare_market/v2/core/enums/view_state.dart';
import 'package:msquare_market/v2/ui/screens/p2p/p2p_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/style.dart';
import '../../widgets/p2p_widgets/asset_token_widget.dart';
import '../../widgets/p2p_widgets/decorated_tab_bar.dart';
import 'p2p_listing/p2p_user_screen.dart';

/// A [View] that displays the P2P Token (Buy and Sell) Orders
/// which any [User] can buy or sell.

class P2pScreen extends StatefulWidget {
  @override
  State<P2pScreen> createState() => _P2pScreenState();
}

class _P2pScreenState extends State<P2pScreen>
    with SingleTickerProviderStateMixin {
  /// [TabController] to handle tab change on the screen
  TabController? _tabController;

  /// [Integer] that let us know the current page/ tab we are on
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    // Initialize Tab Controller
    _tabController = TabController(length: 2, vsync: this);
    // Assign listeners to TabController which lets us now if the
    // current index of tab is changed than change the tab as well.
    _tabController!.addListener(() {
      // Checks if the tab has changed
      if (!_tabController!.indexIsChanging) {
        setState(() {
          // assign changed index to current Index
          currentIndex = _tabController!.index;
        });
      }
    });
  }

  @override
  void dispose() {
    // Dispose Tab Controller
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<P2PProvider>(
      builder: (context, model, child) {
        // checks if model tab and view tab are different than assign the view
        // tab to model tab.
        if (model.currentTab != currentIndex) model.changeTab(currentIndex);
        return ModalProgressHUD(
          progressIndicator: CircularProgressIndicator(
            color: Colors.blue,
          ),
          inAsyncCall: model.state == ViewState.busy,
          child: DefaultTabController(
            length: 2,
            initialIndex: 0,
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: true,
                iconTheme: IconThemeData(color: Colors.black),
                title: Text(
                  'P2P',
                  style: TextStyle(color: Colors.black),
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        Get.to(() => P2PUserScreen());
                      },
                      icon: Icon(Icons.menu))
                ],
                bottom: DecoratedTabBar(
                  tabBar: TabBar(
                    controller: _tabController!,
                    indicatorColor: primaryColor70,
                    labelColor: primaryColor70,
                    unselectedLabelColor: greyColor50,
                    labelStyle:
                        poppinsTextStyle(16, FontWeight.w500, primaryColor70),
                    unselectedLabelStyle:
                        poppinsTextStyle(16, FontWeight.w500, greyColor50),
                    onTap: (value) {
                      currentIndex = value;
                      setState(() {});
                      model.changeTab(value);
                    },
                    tabs: [
                      Tab(text: "MSQP"),
                      Tab(text: "P2UP"),
                    ],
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: greyColor20,
                      ),
                    ),
                  ),
                ),
              ),
              body: TabBarView(
                controller: _tabController!,
                children: [
                  AssetTokenWidget(),
                  AssetTokenWidget(),
                ],
              ),
              backgroundColor: greyColor0,
            ),
          ),
        );
      },
    );
  }
}
