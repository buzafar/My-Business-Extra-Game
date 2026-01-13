import 'package:riverpod/riverpod.dart';

enum BottomBarPages { office, city, warehouse, global, factories }

final bottomBarProvider = NotifierProvider<BottomBarNotifier, BottomBarPages>(
  () {
    return BottomBarNotifier();
  },
);

class BottomBarNotifier extends Notifier<BottomBarPages> {
  @override
  BottomBarPages build() {
    return BottomBarPages.office;
  }

  void toCity() {
    state = BottomBarPages.city;
  }

  void toWarehouse() {
    state = BottomBarPages.warehouse;
  }

  void toOffice() {
    state = BottomBarPages.office;
  }

  void toGlobal() {
    state = BottomBarPages.global;
  }

  void toFactories() {
    state = BottomBarPages.factories;
  }
}
