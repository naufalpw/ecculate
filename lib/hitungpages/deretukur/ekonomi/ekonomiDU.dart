import 'package:flutter/material.dart';
import 'package:ecculate/hitungpages/deretukur/ekonomi/bungamajemuk.dart';
import 'package:ecculate/hitungpages/deretukur/ekonomi/pertumbuhanpenduduk.dart';
import 'package:ecculate/hitungpages/deretukur/ekonomi/presentvalue.dart';

class EkonomiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white), // Ubah warna ikon back
        title: Text(
          'PENERAPAN EKONOMI',
          style: TextStyle(
            fontFamily: 'PressStart2P',
            fontSize: 14,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: const Color.fromARGB(255, 182, 255, 175),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width * 0.9,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  _buildActionButton(context, 'BUNGA MAJEMUK', BungaMajemukPage()),
                  const SizedBox(height: 15),
                  _buildActionButton(context, 'PRESENT VALUE', PresentValuePage()),
                  const SizedBox(height: 15),
                  _buildActionButton(context, 'PERT. PENDUDUK', PertumbuhanPendudukPage()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, String text, Widget page) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => page)),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 24),
          decoration: BoxDecoration(
            color: Colors.deepOrange,
            border: Border.all(color: Colors.black, width: 3),
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black54,
                offset: Offset(4, 4),
                blurRadius: 0,
              ),
            ],
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'PressStart2P',
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
