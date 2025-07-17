import 'package:flutter/material.dart';
import 'result_page.dart';

class ScanPage extends StatefulWidget {
  static const routeName = '/scan';
  final String role;
  final String username;

  const ScanPage({Key? key, this.role = 'Agent', this.username = ''}) : super(key: key);

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final _manualController = TextEditingController();
  bool _scanning = false;
  String? _recognizedPlate;

  void _scanPlate() {
    setState(() => _scanning = true);
    // TODO: intégrer la caméra + OCR ici
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _scanning = false;
        _recognizedPlate = 'ABC1234'; // Simulated OCR result
      });
    });
  }

  void _confirmPlate() {
    if (_recognizedPlate == null || _recognizedPlate!.isEmpty) return;
    Navigator.pushNamed(context, ResultPage.routeName, arguments: {'plate': _recognizedPlate, 'role': widget.role, 'username': widget.username});
  }

  void _manualSubmit() {
    final plate = _manualController.text.trim();
    if (plate.isEmpty) return;
    Navigator.pushNamed(context, ResultPage.routeName, arguments: {'plate': plate, 'role': widget.role, 'username': widget.username});
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Color(0xFF0D47A1);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.camera_alt, size: 72, color: primaryColor),
              SizedBox(height: 16),
              Text(
                'Scanner un matricule',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _scanning ? null : _scanPlate,
                  icon: _scanning
                      ? SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.5,
                          ),
                        )
                      : Icon(Icons.camera_alt),
                  label: Text(
                    _scanning ? 'Scan en cours...' : 'Scanner avec caméra',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              if (_recognizedPlate != null)
                Column(
                  children: [
                    SizedBox(height: 24),
                    Text('Matricule reconnu :', style: TextStyle(fontSize: 16, color: Colors.grey[700])),
                    SizedBox(height: 6),
                    Text(_recognizedPlate!, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: primaryColor)),
                    SizedBox(height: 12),
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
                        onPressed: _confirmPlate,
                        child: Text('Confirmer et rechercher', style: TextStyle(fontSize: 17)),
                      ),
                    ),
                  ],
                ),
              if (_recognizedPlate == null)
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        TextField(
                          controller: _manualController,
                          decoration: InputDecoration(
                            labelText: 'Saisir le matricule',
                            prefixIcon: Icon(Icons.edit),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onSubmitted: (_) => _manualSubmit(),
                        ),
                        SizedBox(height: 18),
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
                            onPressed: _manualSubmit,
                            child: Text('Rechercher', style: TextStyle(fontSize: 17)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              SizedBox(height: 32),
              Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text('OU', style: TextStyle(color: Colors.grey[700])),
                  ),
                  Expanded(child: Divider()),
                ],
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
                    children: [
                      TextField(
                        controller: _manualController,
                        decoration: InputDecoration(
                          labelText: 'Saisir le matricule',
                          prefixIcon: Icon(Icons.edit),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onSubmitted: (_) => _manualSubmit(),
                      ),
                      SizedBox(height: 18),
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
                          onPressed: _manualSubmit,
                          child: Text('Rechercher', style: TextStyle(fontSize: 17)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
