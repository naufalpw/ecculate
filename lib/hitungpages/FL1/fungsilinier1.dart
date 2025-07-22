import 'package:ecculate/hitungpages/FL1/kalkulatorfl1.dart';
import 'package:flutter/material.dart';

class FungsiLinier1Page extends StatelessWidget {
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
        color: Color.fromARGB(255, 162, 255, 167),
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
                '📌 Pengertian Fungsi Linier\n'
                'Fungsi linier (Linear Function) adalah fungsi berbentuk\n'
                '  f(x) = m·x + c\n'
                'di mana m = gradien (kemiringan) dan c = intersep (titik potong sumbu y).\n'
                'Grafiknya selalu berupa garis lurus.\n\n'

                '🧮 Elemen-elemen Penting\n'
                '• Gradien  (m):  menunjukkan seberapa besar perubahan y setiap kenaikan 1 satuan x.\n'
                '• Intersep (c):  nilai y saat x = 0.\n'
                '• Titik Potong x :  x-intercept = -c / m   (jika m ≠ 0).\n\n'

                '💼 Penerapan Ekonomi & Bisnis\n'
                '1. Fungsi Permintaan :  \nQ_d = a - bP\n'
                '2. Fungsi Penawaran  :  \nQ_s = -a + bP\n'
                '3. Total Cost  :  \nTC(Q) = FC + VC·Q  ( biaya tetap + variabel )\n'
                '4. Pendapatan Linier :  \nTR(Q) = P·Q  (jika harga P konstan)\n'
                '5. Break-Even Point :  \nSet f_Pendapatan(Q) = f_Biaya(Q) untuk mencari titik impas.\n\n'

                '🔑 Sifat Turunan\n'
                'Turunan fungsi linier selalu konstan, yaitu f\'(x) = m. '
                'Ini berarti laju perubahan tidak tergantung pada nilai x.\n\n'

                '🛠️ Contoh Cepat\n'
                'Misal \nTC(Q) = 50 + 8Q  ⇨  FC = 50,  VC per unit = 8.\n'
                'Jika \nTR(Q) = 12Q, maka Break-Even terjadi saat:\n'
                '12Q = 50 + 8Q  ⇒  4Q = 50  ⇒  Q = 12.5 unit.\n\n'

                '📎 Ringkasan\n'
                'Fungsi linier mudah dianalisis karena hubungan antar variabel bersifat '
                'proporsional tetap. Konsep ini menjadi pondasi bagi analisis biaya, penetapan harga, '
                'dan model keseimbangan sederhana.',
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
                  MaterialPageRoute(builder: (_) => KalkulatorFL1Page()),
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