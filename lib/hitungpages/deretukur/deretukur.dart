import 'package:ecculate/hitungpages/deretukur/kalkulatorDU.dart';
import 'package:flutter/material.dart';

class DeretUkurPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white), // Ubah warna ikon back
        title: Text(
          'DERET UKUR',
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
        color: Color.fromARGB(255, 193, 255, 185),
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    color: Colors.white,
                  ),
                  child: Text(
                      '📌 Pengertian Deret Ukur\n'
                      'Deret Ukur adalah susunan bilangan yang dibentuk menurut urutan tertentu,'
                      'dimana susunan bilangan di antara dua suku yang berurutan mempunyai rasio'
                      'atau perbandingan yang tetap. Rasio yang tetap ini biasanya dilambangkan'
                      'dengan huruf r.\n\n'

                      '💼 Penerapan dalam Ekonomi:\n'
                      '1. Model bunga majemuk.\n'
                      '2. Model Present Value.\n'
                      '3. Model Pertumbuhan Penduduk.\n\n'

                      '🧮 Rumus-rumus Deret Ukur:\n'
                      '• Suku ke-n (Un):  \n Un = a x rⁿ⁻¹\n'
                      '• Jumlah n suku pertama (Sn):\n'
                      '-> Jika r > 1:     \n Sn = a(rⁿ - 1) / (r - 1)\n'
                      '-> Jika 0 < r < 1: \n Sn = a(1 - rⁿ) / (1 - r)\n\n'
  
                      '📘 Catatan:\n'
                      'Jika |r| < 1 dan n → ∞ maka Sn = a / (1 - r) (konvergen). '
                      'Namun jika |r| ≥ 1 maka deret divergen dan tidak memiliki jumlah hingga.\n\n'

                      '✅ Kesimpulan:\n'
                      'Deret ukur penting untuk memodelkan nilai yang tumbuh atau menyusut secara berkala, '
                      'dan banyak digunakan dalam analisis ekonomi, keuangan, dan akuntansi.',
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.8,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => KalkulatorDeretUkurPage()),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
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
                    'MASUK KE KALKULATOR',
                    style: TextStyle(
                      fontFamily: 'PressStart2P',
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}