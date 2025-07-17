import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  static const routeName = '/history';
  final String role;
  final String username;

  const HistoryPage({Key? key, this.role = 'Agent', this.username = ''}) : super(key: key);

  // MOCK history list
final List<Map<String, String>> history = const [
  {'plate': 'ABC1234', 'date': '2024-06-01 10:12'},
  {'plate': 'XYZ9876', 'date': '2024-06-01 09:45'},
  {'plate': 'TEST000', 'date': '2024-05-31 18:22'},
];


  @override
  Widget build(BuildContext context) {
    final primaryColor = Color(0xFF0D47A1);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.history, color: primaryColor, size: 32),
                  SizedBox(width: 10),
                  Text(
                    'Historique des recherches',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 28),
              Expanded(
                child: history.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.inbox, size: 64, color: Colors.grey[400]),
                            SizedBox(height: 16),
                            Text(
                              'Aucune recherche enregistrée',
                              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      )
                    : ListView.separated(
                        itemCount: history.length,
                        separatorBuilder: (_, __) => SizedBox(height: 14),
                        itemBuilder: (ctx, i) {
                          final item = history[i];
                          return Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: ListTile(
                              leading: Icon(Icons.directions_car, color: primaryColor),
                              title: Text(
                                item['plate']!,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              subtitle: Text(
                                item['date']!,
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                              onTap: () async {
                                await showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: Text('Détails du matricule'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Matricule : ${item['plate']}'),
                                        SizedBox(height: 8),
                                        Text('Date : ${item['date']}'),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(ctx),
                                        child: Text('Fermer'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(ctx);
                                          Navigator.pushNamed(
                                            context,
                                            '/result',
                                            arguments: {
                                              'plate': item['plate'],
                                              'role': role,
                                              'username': username,
                                            },
                                          );
                                        },
                                        child: Text('Voir le résultat'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
