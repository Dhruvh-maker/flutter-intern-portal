import 'package:flutter/foundation.dart';

class InternProvider with ChangeNotifier {
  String internName = "Dhruv Srivastava";
  String referralCode = "dhruv2025";
  int totalDonations = 5000;
  List<Map<String, dynamic>> _donationHistory = [];

  List<Map<String, dynamic>> get donationHistory => _donationHistory;

  final List<Map<String, dynamic>> leaderboard = [
    {'name': 'Ananya', 'score': 7000},
    {'name': 'Dhruv', 'score': 5000},
    {'name': 'Mahi', 'score': 4000},
    {'name': 'Raj', 'score': 3000},
    {'name': 'Aditi', 'score': 2500},
  ];

  final List<String> announcements = [
    '🎉 Top 3 interns will get Amazon vouchers!',
    '📅 Next fundraising event is on Aug 10.',
    '📌 Remember to share your referral code!',
  ];

  void updateDonation(double amount) {
    totalDonations += amount.toInt();

    // Update the user's score in the leaderboard
    final index = leaderboard.indexWhere(
      (entry) => entry['name'] == internName.split(' ').first,
    ); // Assumes 'Dhruv' from 'Dhruv Srivastava'
    if (index != -1) {
      leaderboard[index]['score'] = totalDonations;
    }

    // Optional: Re-sort the leaderboard descending by score
    leaderboard.sort((a, b) => b['score'].compareTo(a['score']));

    notifyListeners();
  }

  void addDonationToHistory(double amount) {
    _donationHistory.insert(0, {
      'amount': amount,
      'date': DateTime.now().toString().substring(0, 10),
    });
    notifyListeners();
  }
}
