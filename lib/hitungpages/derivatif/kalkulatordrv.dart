import 'package:ecculate/hitungpages/derivatif/elastisitaspenawarandrv.dart';
import 'package:ecculate/hitungpages/derivatif/elastisitaspermintaandrv.dart';
import 'package:ecculate/hitungpages/derivatif/elastisitasproduksidrv.dart';
import 'package:ecculate/hitungpages/derivatif/fungsibiayadrv.dart';
import 'package:ecculate/hitungpages/derivatif/fungsilabadrv.dart';
import 'package:ecculate/hitungpages/derivatif/fungsipenerimaandrv.dart';
import 'package:flutter/material.dart';

class KalkulatorDerivatifPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white), // Ubah warna ikon back
        title: Text(
          'KALKULATOR DERIVATIF',
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
        color: Color.fromARGB(255, 165, 250, 162),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width * 0.9,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildActionButton(context, 'Elas. Penawaran', ElastisitasPenawaranPage()),
                  SizedBox(height: 15),
                  _buildActionButton(context, 'Elas. Permintaan', ElastisitasPermintaanPage()),
                  SizedBox(height: 15),
                  _buildActionButton(context, 'Elas. Produksi', ElastisitasProduksiPage()),
                  SizedBox(height: 15),
                  _buildActionButton(context, 'Fungsi Biaya', FungsiBiayaDerivatifPage()),
                  SizedBox(height: 15),
                  _buildActionButton(context, 'Fungsi Laba', FungsiLabaDerivatifPage()),
                  SizedBox(height: 15),
                  _buildActionButton(context, 'Fungsi Penerimaan', FungsiPenawaranDerivatifPage()),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action for help or info
        },
        backgroundColor: Colors.black,
        child: Icon(Icons.help_outline, color: Colors.white),
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
            textAlign: TextAlign.center,
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
