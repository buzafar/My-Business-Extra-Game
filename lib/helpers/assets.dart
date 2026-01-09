class Assets {
  // --------------- APP IMAGES --------------
  static final String _appImagesSource = "assets/app_images/";
  static final String warehouseImage = "${_appImagesSource}warehouse.png";
  static final String marketImage = "${_appImagesSource}market.png";
  static final String cityImage = '${_appImagesSource}city.png';

  // --------------- PRODUCT IMAGES --------------
  static final String productImagesSource = "assets/product_images/";

  // --------------- SOUNDS --------------
  static final String _soundsSource =
      "sounds/"; // this should have been "assets/sounds/" but "assets/" part is already put for us by the package we are using
  static final String moneyEarnedSound = '${_soundsSource}money_earned.mp3';
}
