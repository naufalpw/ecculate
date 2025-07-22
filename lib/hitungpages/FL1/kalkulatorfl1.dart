import 'package:ecculate/hitungpages/FL1/Qd_Pe.dart';
import 'package:ecculate/hitungpages/FL1/varpajakpro.dart';
import 'package:ecculate/hitungpages/FL1/varpajakspes.dart';
import 'package:ecculate/hitungpages/FL1/varsubsidi.dart';
import 'package:flutter/material.dart';

class KalkulatorFL1Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white), // Ubah warna ikon back
        title: Text(
          'FUNGSI LINIER 1',
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
        color: Color.fromARGB(255, 179, 253, 183),
        child: Center( // Membungkus dengan Center untuk memposisikan di tengah
          child: Container(
            padding: EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width * 0.9, // Lebar 90% dari layar
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Memposisikan vertikal di tengah
                children: [
                  _buildActionButton(context, 'Qd dan Qe', PeQePage()),
                  SizedBox(height: 15),
                  _buildActionButton(context, 'PAJAK PROPOSIONAL', PajakProposionalPage()),
                  SizedBox(height: 15),
                  _buildActionButton(context, 'PAJAK SPESIFIK', PajakSpesifikPage()),
                  SizedBox(height: 15),
                  _buildActionButton(context, 'SUBSIDI', SubsidiPage()),
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
          width: double.infinity, // Lebar penuh
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 24),
          decoration: BoxDecoration(
            color: Colors.deepOrange,
            border: Border.all(color: Colors.black, width: 3),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black54,
                offset: Offset(4, 4),
                blurRadius: 0,
              ),
            ],
          ),
          child: Text(
            text,
            textAlign: TextAlign.center, // Teks di tengah
            style: TextStyle(
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