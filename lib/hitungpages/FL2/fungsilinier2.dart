import 'package:ecculate/hitungpages/FL2/kalkulatorfl2.dart';
import 'package:flutter/material.dart';

class FungsiLinier2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white), // Ubah warna ikon back
        title: Text(
          'FUNGSI LINIER 2',
          style: TextStyle(
            fontFamily: 'PressStart2P',
            fontSize: 14,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Container(
        color: Color.fromARGB(255, 179, 255, 173),
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
              child: Text(
                '📌 Fungsi Linier 2 — Konsumsi Otonom & Pendapatan Nasional\n'
                'Dalam ekonomi Keynesian sederhana, fungsi konsumsi diasumsikan linier:\n'
                '   C = a + bY\n'
                '•  a  = konsumsi otonom (pengeluaran rumah tangga ketika pendapatan nol)\n'
                '•  b  = MPC (marginal propensity to consume, 0 < b < 1)\n'
                '•  Y  = pendapatan nasional/disposable income\n\n'

                '1. Interpretasi a & b\n'
                '•  a  ⇒ kebutuhan dasar yang dibiayai tabungan/kredit saat \nY = 0\n'
                '•  b  ⇒ proporsi tambahan konsumsi setiap penambahan 1 satuan pendapatan\n\n'

                '2. Tabungan\n'
                '   S = Y - C = -a + (1 - b)Y\n'
                '•  -a  = tabungan otonom (biasanya negatif ⇒ dis-saving)\n'
                '•  (1 - b) = MPS (marginal propensity to save)\n\n'

                '3. Pendapatan Nasional\n'
                'Model dua-sektor (tanpa pemerintah & perdagangan):\n'
                '   Y = C + I\n'
                'Substitusi C:\n'
                '   Y = a + bY + I jadi,\n'
                'Y(1 - b) = a + I  ⇒  Y* = (a + I) / (1 - b)\n'
                'Di sini (1 / (1 - b)) disebut *kalkulator pengali* (multiplier).\n\n'

                '4. Dampak Perubahan Investasi ΔI\n'
                'ΔY = (1 / (1 - b)) · ΔI  ⇨ semakin besar MPC, semakin kuat efek multiplier.\n\n'

                '🛠️ Contoh Numerik\n'
                'Misal  a = 40  (dalam triliun)\n'
                '       b = 0.8  (MPC)\n'
                '       I = 60  (investasi)\n'
                'Pendapatan keseimbangan:\n'
                'Y* = (40 + 60) / (1 - 0.8) = 100 / 0.2 = 500\n'
                'Jika investasi naik \nΔI = 20 → ΔY = 5 - 20 = 100, sehingga Y baru = 600.\n\n'

                '✅ Ringkasan\n'
                'Fungsi konsumsi linier menekankan konsumsi otonom dan MPC. '
                'Melalui persamaan keseimbangan Y = C + I, kita memperoleh pendapatan '
                'nasional serta efek multiplier—konsep kunci analisis kebijakan fiskal.',
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
                  MaterialPageRoute(builder: (_) => KalkulatorFL2Page()),
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