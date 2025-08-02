import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/intern_provider.dart';

class LeaderboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final leaderboard = Provider.of<InternProvider>(context).leaderboard;

    return Scaffold(
      appBar: AppBar(title: Text('Leaderboard')),
      body: ListView.builder(
        itemCount: leaderboard.length,
        itemBuilder: (context, index) {
          var user = leaderboard[index];
          return ListTile(
            tileColor: index % 2 == 0 ? Colors.indigo.shade50 : Colors.white,
            leading: CircleAvatar(
              backgroundColor: Colors.indigoAccent,
              child: Text(
                '#${index + 1}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              user['name'],
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            trailing: Text(
              '₹${user['score']}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          );
        },
      ),
    );
  }
}
