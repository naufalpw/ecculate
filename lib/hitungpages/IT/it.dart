import 'package:ecculate/hitungpages/IT/kalkulatorit.dart';
import 'package:flutter/material.dart';

class IntegralTertentuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white), // Ubah warna ikon back
        title: Text(
          'INTEGRAL TERTENTU',
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
        color: Color.fromARGB(255, 174, 253, 181),
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
                '📌 Pengertian Integral Tertentu\n'
                'Integral tertentu ∫ₐᵇ f(x) dx adalah jumlah (luas bersigne) di bawah kurva f(x) dari x = a hingga x = b. '
                'Secara geometris, untuk fungsi f(x) ≥ 0, integral tersebut merepresentasikan luas bidang di bawah grafik.\n\n'

                '🧮 Rumus Dasar (Teorema Fundamental Kalkulus)\n'
                'Jika F\'(x) = f(x), maka:\n'
                '   ∫ₐᵇ f(x) dx = F(b) - F(a)\n'
                'Artinya kita cukup mencari anti-turunan F(x) lalu substitusi batas a dan b.\n\n'

                '🛠️ Sifat-sifat Penting\n'
                '• Linearitas   :  ∫ₐᵇ [cf(x) + dg(x)] dx = c∫ₐᵇ f(x) dx + d∫ₐᵇ g(x) dx\n'
                '• Pembagian     :  ∫ₐᵇ f = ∫ₐᶜ f + ∫ᶜᵇ f  (untuk c di antara a dan b)\n'
                '• Jika f(x) ≥ 0 pada [a, b] maka ∫ₐᵇ f(x) dx ≥ 0 (menjadi luas positif).\n\n'

                '💼 Penerapan dalam Ekonomi\n'
                '1. Total Cost (TC)   :  TC = ∫ MC(q) dq   — luas di bawah kurva biaya marjinal.\n'
                '2. Consumer Surplus  :  ∫₀^Q  (P_demand - P_market) dq.\n'
                '3. Producer Surplus  :  ∫₀^Q  (P_market - P_supply) dq.\n\n'

                '🔑 Contoh Cepat\n'
                'Diketahui MC(q) = 5q + 20 (dalam ribu rupiah).\n'
                'Total Cost memproduksi 10 unit:\n'
                '   TC = ∫₀¹⁰ (5q + 20) dq = [ (5/2)q² + 20q ]₀¹⁰ = (2.5·100) + 200 = 450 (ribu rupiah).\n\n'

                '📎 Catatan\n'
                'Integral tertentu juga memegang peranan penting dalam menghitung probabilitas kumulatif, '
                'nilai sekarang kontinyu, dan model continuous compounding.\n',
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
                  MaterialPageRoute(builder: (_) => KalkulatorIntegralTertentuPage()),
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