class Assets {
  // --------------- APP IMAGES --------------
  static final String _appImagesSource = "assets/app_images/";
  static final String warehouseImage = "${_appImagesSource}warehouse.png";
  static final String marketImage = "${_appImagesSource}market.png";
  static final String cityImage = '${_appImagesSource}city.png';
  static final String liveImage = '${_appImagesSource}live_stream.png';
  static final String officeImage = '${_appImagesSource}office.png';
  static final String globalMarketImage =
      '${_appImagesSource}global_market.png';
  static final String factoryImage = '${_appImagesSource}factory.png';
  static final String cityBigImage = '${_appImagesSource}city_big.png';
  static final String cityBackgroundImage =
      '${_appImagesSource}city_background.jpeg';

  // --------------- PRODUCT IMAGES --------------
  static final String productImagesSource = "assets/product_images/";

  // --------------- SOUNDS --------------
  static final String _soundsSource =
      "sounds/"; // this should have been "assets/sounds/" but "assets/" part is already put for us by the package we are using
  static final String moneyEarnedSound = '${_soundsSource}money_earned.mp3';
}
