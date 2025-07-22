import 'package:ecculate/hitungpages/ITT/fungsibiayaitt.dart';
import 'package:ecculate/hitungpages/ITT/fungsikonsumsiitt.dart';
import 'package:ecculate/hitungpages/ITT/fungsipenerimaanitt.dart';
import 'package:ecculate/hitungpages/ITT/fungsiproduksiitt.dart';
import 'package:ecculate/hitungpages/ITT/fungsitabunganitt.dart';
import 'package:flutter/material.dart';

class KalkulatorIntegralTakTentuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white), // Ubah warna ikon back
        title: Text(
          'INTEGRAL TAK TENTU',
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
        color: Color.fromARGB(255, 180, 228, 173),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width * 0.9,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildActionButton(context, 'FUNGSI BIAYA', FungsiBiayaPage()),
                  SizedBox(height: 15),
                  _buildActionButton(context, 'FUNGSI PENERIMAAN', FungsiPenerimaanPage()),
                  SizedBox(height: 15),
                  _buildActionButton(context, 'FUNGSI PRODUKSI', FungsiProduksiPage()),
                  SizedBox(height: 15),
                  _buildActionButton(context, 'FUNGSI KONSUMSI', FungsiKonsumsiPage()),
                  SizedBox(height: 15),
                  _buildActionButton(context, 'FUNGSI TABUNGAN', FungsiTabunganPage()),
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
