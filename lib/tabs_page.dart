import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:my_business_extra/helpers/assets.dart';
import 'package:my_business_extra/router/app_router.gr.dart';

@RoutePage()
class TabsPage extends StatelessWidget {
  const TabsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: [
        HomeRoute(),
        CityMarketRoute(),
        CityMarketRoute(),
        CityMarketRoute(),
        CityMarketRoute(),
      ],
      bottomNavigationBuilder: (context, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.black,
          selectedLabelStyle: TextTheme.of(context).labelSmall,
          unselectedLabelStyle: TextTheme.of(context).labelSmall,
          showUnselectedLabels: true,
          items: [
            BottomNavigationBarItem(
              icon: SizedBox(
                width: 30,
                height: 30,
                child: Image.asset(Assets.officeImage),
              ),
              label: 'Office',
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                width: 30,
                height: 30,
                child: Image.asset(Assets.cityImage),
              ),
              label: 'City',
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                width: 30,
                height: 30,
                child: Image.asset(Assets.warehouseImage),
              ),
              label: 'Warehouse',
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                width: 30,
                height: 30,
                child: Image.asset(Assets.globalMarketImage),
              ),
              label: 'Global',
            ),

            BottomNavigationBarItem(
              icon: SizedBox(
                width: 30,
                height: 30,
                child: Image.asset(Assets.factoryImage),
              ),
              label: 'Factories',
            ),
          ],
        );
      },
    );
  }
}
