import 'package:ecculate/hitungpages/derivatif/kalkulatordrv.dart';
import 'package:flutter/material.dart';

class DerivatifPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white), // Ubah warna ikon back
        title: Text(
          'DERIVATIF',
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
        color: Color.fromARGB(255, 170, 255, 177),
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
                    '📌 Pengertian Derivatif (Turunan)\n'
                    'Turunan atau derivatif adalah hasil yang diperoleh dari proses diferensiasi,'
                    'yang dimana diferensiasi adalah proses penurunan sebuah fungsi atau proses'
                    ' pendiferensiasian, sedangkan diferensial membahas tentang tingkat perubahan'
                    ' suatu fungsi sehubungan dengan perubahan kecil dalam variabel bebas fungsi yang'
                    ' bersangkutan.\n'
                    'Dengan kata lain, turunan menunjukkan seberapa cepat nilai suatu fungsi berubah ketika nilai inputnya berubah.\n\n'

                    '📚 Penerapan dalam Ekonomi\n'
                    'Dalam konteks ekonomi dan bisnis, derivatif sangat penting karena dapat digunakan untuk:\n'
                    '• Menghitung marginal cost (biaya marjinal)\n'
                    '• Menghitung marginal revenue (pendapatan marjinal)\n'
                    '• Menganalisis titik maksimum/minimum keuntungan\n'
                    '• Menentukan elastisitas permintaan\n\n'

                    '📐 Rumus-Rumus Umum\n'
                    '1. Turunan fungsi pangkat:  \nd/dx [xⁿ] = n·xⁿ⁻¹\n'
                    '2. Turunan konstanta:       \nd/dx [c] = 0\n'
                    '3. Aturan penjumlahan:      \nd/dx [f(x) + g(x)] = f\'(x) + g\'(x)\n\n'

                    '🧠 Contoh:\n'
                    'Jika C(x) = 5x² + 3x + 10, maka turunan C\'(x) = 10x + 3\n'
                    '→ C\'(x) dapat diartikan sebagai biaya marjinal pada saat produksi sebanyak x unit.\n\n'

                    '📎 Catatan:\n'
                    'Turunan sangat berguna dalam analisis perubahan, prediksi tren ekonomi, dan pengambilan keputusan yang optimal.\n',
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
                  MaterialPageRoute(builder: (_) => KalkulatorDerivatifPage()),
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