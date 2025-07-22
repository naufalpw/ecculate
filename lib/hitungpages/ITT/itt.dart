import 'package:ecculate/hitungpages/ITT/kalkulatoritt.dart';
import 'package:flutter/material.dart';

class IntegralTakTentuPage extends StatelessWidget {
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
        elevation: 0,
      ),
      body: Container(
        color: Color.fromARGB(255, 176, 231, 163),
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
                '📌 Pengertian Integral Tak Tentu\n'
                'Integral tak tentu ∫ f(x) dx adalah himpunan semua anti-turunan dari f(x), '
                'ditulis F(x) + C, di mana C adalah konstanta integrasi. '
                'Berbeda dengan integral tertentu, tidak ada batas a maupun b sehingga hasilnya berupa fungsi.\n\n'

                '🧮 Rumus & Aturan Dasar\n'
                '• Aturan pangkat :  ∫ xⁿ dx = xⁿ⁺¹ / (n+1) + C   (n ≠ -1)\n'
                '• Konstanta      :  ∫ k dx = kx + C\n'
                '• Linearitas     :  ∫ [af(x)+bg(x)] dx = a∫f dx + b∫g dx\n'
                '• Substitusi     :  ∫ f(g(x))g\'(x) dx = ∫ f(u) du\n'

                '💼 Penerapan dalam Ekonomi & Bisnis\n'
                '1. Biaya Marjinal → Total Cost :  TC(q) = ∫ MC(q) dq + C\n'
                '2. Pendapatan Marjinal → Total Revenue :  TR(q) = ∫ MR(q) dq + C\n'
                '3. Pemecahan Persamaan Diferensial untuk model pertumbuhan kontinyu.\n'
                '4. Diskontinu Pada Aliran Kas: mencari fungsi present value dari laju arus kas kontinu r(t).\n\n'

                '🔑 Contoh:\n'
                'Misal MC(q) = 6q² - 4q + 10. Total Cost:\n'
                '  TC(q) = ∫ (6q² - 4q + 10) dq = 2q³ - 2q² + 10q + C.\n'
                'Konstanta C ditentukan dari biaya tetap saat q = 0.\n\n'

                '📎 Catatan Penting\n'
                '• Konstanta C WAJIB ditulis karena anti-turunan tidak unik.\n'
                '• Pemilihan metode (substitusi, parsial, trigonometri, dsb.) tergantung bentuk f(x).\n',
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
                  MaterialPageRoute(builder: (_) => KalkulatorIntegralTakTentuPage()),
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