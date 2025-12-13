import 'dart:math';

int generateRandomNumberId() {
  // Define the minimum 6-digit number (inclusive)
  int min = 100000;
  // Define the maximum 6-digit number (inclusive)
  int max = 999999;

  // Create a random number generator instance
  // For production/security, consider Random.secure()
  var randomizer = Random();

  // The nextInt() method generates a number in the range [0, max - min)
  // Adding 'min' shifts the range to [min, max)
  // To include 'max', the range should be max - min + 1. But since max is 999999
  // and we want to include it, the max parameter for nextInt becomes 900000
  // (which gives numbers from 0 to 899999) + min (100000) which results in
  // numbers from 100000 to 999999 inclusive.
  int randomNumber = min + randomizer.nextInt(max - min + 1);

  return randomNumber;
}
