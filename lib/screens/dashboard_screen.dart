import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:confetti/confetti.dart';
import '../providers/intern_provider.dart';
import '../widgets/reward_card.dart';
import 'dart:math';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final TextEditingController _donationController = TextEditingController();
  final ConfettiController _confettiController = ConfettiController(
    duration: Duration(seconds: 2),
  );

  void _showDonationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Make a Donation'),
        content: TextField(
          controller: _donationController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Enter amount',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _donationController.clear();
              Navigator.of(ctx).pop();
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final amount = double.tryParse(_donationController.text);
              if (amount != null && amount > 0) {
                final provider = Provider.of<InternProvider>(
                  context,
                  listen: false,
                );
                provider.updateDonation(amount);
                provider.addDonationToHistory(amount);
                _confettiController.play();
                _donationController.clear();
                Navigator.of(ctx).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Thank you for your donation!')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Please enter a valid amount.')),
                );
              }
            },
            child: Text('Donate'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _donationController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final internProvider = Provider.of<InternProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Dashboard')),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: ListView(
              children: [
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 36,
                        backgroundColor: Colors.indigo.shade100,
                        child: Icon(
                          Icons.person,
                          size: 36,
                          color: Colors.indigo,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Welcome, ${internProvider.internName}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text('Referral Code: ${internProvider.referralCode}'),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.indigo.shade100,
                      child: Icon(Icons.currency_rupee, color: Colors.indigo),
                    ),
                    title: Text('Total Donations'),
                    subtitle: Text(
                      '₹${internProvider.totalDonations}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    trailing: ElevatedButton(
                      onPressed: () => _showDonationDialog(context),
                      child: Text('Donate'),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Rewards',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RewardCard(title: 'Bronze', color: Colors.brown),
                    RewardCard(title: 'Silver', color: Colors.grey),
                    RewardCard(title: 'Gold', color: Colors.amber),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'Donation History',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                internProvider.donationHistory.isEmpty
                    ? Text('No donations yet.')
                    : Column(
                        children: internProvider.donationHistory.map((
                          donation,
                        ) {
                          return ListTile(
                            leading: Icon(Icons.history, color: Colors.indigo),
                            title: Text('₹${donation['amount']}'),
                            subtitle: Text(donation['date']),
                          );
                        }).toList(),
                      ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: pi / 2,
              maxBlastForce: 20,
              minBlastForce: 5,
              emissionFrequency: 0.05,
              numberOfParticles: 20,
              gravity: 0.2,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) Navigator.pushNamed(context, '/leaderboard');
          if (index == 2) Navigator.pushNamed(context, '/announcements');
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: 'Leaderboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.announcement),
            label: 'Announcements',
          ),
        ],
      ),
    );
  }
}
