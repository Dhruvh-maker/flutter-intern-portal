import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/intern_provider.dart';

class AnnouncementsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final announcements = Provider.of<InternProvider>(context).announcements;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '📢 Announcements',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        color: Colors.grey[100],
        child: announcements.isEmpty
            ? Center(
                child: Text(
                  'No announcements yet!',
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                ),
              )
            : ListView.builder(
                itemCount: announcements.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 20,
                      ),
                      leading: CircleAvatar(
                        backgroundColor: Colors.deepPurple,
                        child: Icon(Icons.campaign, color: Colors.white),
                      ),
                      title: Text(
                        announcements[index],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
