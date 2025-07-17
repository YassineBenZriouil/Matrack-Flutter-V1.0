import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  static const routeName = '/result';
  final String role;
  final String username;

  const ResultPage({Key? key, this.role = 'Agent', this.username = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final String plate = args?['plate'] ?? 'Inconnu';
    final String role = args?['role'] ?? this.role;
    final String username = args?['username'] ?? this.username;

    // MOCK: Simulate plate found if ends with even digit
    final found = plate.isNotEmpty && int.tryParse(plate.substring(plate.length - 1))?.isEven == true;
    final primaryColor = Color(0xFF0D47A1);

    if (found) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Matricule trouvé!'),
            backgroundColor: Colors.green,
          ),
        );
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: found
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle, size: 80, color: Colors.green),
                    SizedBox(height: 18),
                    Text(
                      'Matricule trouvé',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[700],
                      ),
                    ),
                    SizedBox(height: 24),
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Matricule :', style: TextStyle(fontSize: 16, color: Colors.grey[700])),
                            SizedBox(height: 4),
                            Text(plate, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: primaryColor)),
                            SizedBox(height: 16),
                            Text('Détails :', style: TextStyle(fontSize: 16, color: Colors.grey[700])),
                            SizedBox(height: 4),
                            Text('Véhicule enregistré', style: TextStyle(fontSize: 18)),
                            SizedBox(height: 8),
                            Text('Données Google Sheets :', style: TextStyle(fontSize: 15, color: Colors.grey[600])),
                            Text('Propriétaire: John Doe\nMarque: Toyota\nAnnée: 2020', style: TextStyle(fontSize: 15)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: Text('Nouvelle recherche', style: TextStyle(fontSize: 17)),
                      ),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 80, color: Colors.red),
                    SizedBox(height: 18),
                    Text(
                      'Matricule non trouvé',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.red[700],
                      ),
                    ),
                    SizedBox(height: 24),
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Matricule :', style: TextStyle(fontSize: 16, color: Colors.grey[700])),
                            SizedBox(height: 4),
                            Text(plate, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: primaryColor)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: Text('Réessayer', style: TextStyle(fontSize: 17)),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
