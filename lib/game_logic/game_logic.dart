import 'dart:math' as Math;

class GameLogic {
  /*
    Calculates the price of a product in a city based on demand & supply.
    - Prices rise sharply under scarcity
    - Prices fall fast under oversupply
    - Changes are smoothed over time for realism & dopamine
  */
  static double calculateProductPrice({
    required double normalPrice,
    required double lowestPrice,
    required double highestPrice,
    required double currentPrice,
    required int demand,
    required int supply,
  }) {
    if (demand <= 0) return lowestPrice;

    // 1️⃣ Demand coverage ratio
    double r = supply / demand;
    r = r.clamp(0.0, 1.0);

    // 2️⃣ Base non-linear pricing (scarcity curve)
    const double alpha = 2.0; // Higher = more aggressive scarcity
    double basePrice =
        lowestPrice + (1 - Math.pow(r, alpha)) * (highestPrice - lowestPrice);

    // 3️⃣ Scarcity spike (dopamine moment)
    double scarcityMultiplier = 1.0;
    if (r < 0.3) {
      const double beta = 1.5;
      scarcityMultiplier += beta * (0.3 - r);
    }

    double targetPrice = basePrice * scarcityMultiplier;

    // 4️⃣ Soft pull toward normal price when market is balanced
    if (r > 0.9 && r < 1.1) {
      targetPrice = (targetPrice * 0.7) + (normalPrice * 0.3);
    }

    // 5️⃣ Clamp hard limits
    targetPrice = targetPrice.clamp(lowestPrice, highestPrice);

    // 6️⃣ Momentum (smooth price changes)
    const double momentum = 0.2; // 0.1 slow, 0.3 fast
    double newPrice = currentPrice + momentum * (targetPrice - currentPrice);

    return newPrice.clamp(lowestPrice, highestPrice);
  }
}
