import 'package:ecculate/hitungpages/derethitung/kalkulatorDH.dart';
import 'package:flutter/material.dart';


class DeretHitungPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white), // Ubah warna ikon back
        title: Text(
          'DERET HITUNG',
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
        color: Color.fromARGB(255, 187, 255, 174),
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
                    '📌 Pengertian Deret Hitung\n'
                    'Barisan adalah suatu susunan bilangan yang dibentuk menurut suatu urutan tertentu. Bilangan-bilangan yang tersusun tersebut disebut suku.\n'
                    'Suku adalah adalah bilangan-bilangan yang merupakan unsur dan pembentuk sebuah barisan atau deret.'
                    'Perubahan di antara suku-suku yang berurutan ditentukan oleh suatu ketambahan bilangan tertentu atau suatu kelipatan bilangan tertentu.\n'
                    'Deret adalah jumlah dari bilangan dalam suatu barisan.'
                    'Deret pada hakikatnya dapat dipahami sebagai suatu rangkaian bilangan yang tersusun secara teratur dan memenuhi kaidah-kaidah tertentu.\n'
                    'Deret hitung adalah jumlah dari suku-suku dalam suatu baris hitung. '
                    'Jumlah dari bilangan dalam barisan tersebut dimulai dari suku pertama (U1 atau a) sampai dengan suku ke-n (Un).\n\n'
                    
                    '💼 Penerapan dalam Ekonomi:\n'
                    'Di bidang bisnis dan ekonomi, teori atau prinsip-prinsip deret sering '
                    'diterapkan dalam kasus-kasus yang menyangkut perkembangan dan pertumbuhan. '
                    'Jika pertumbuhan variabel-variabel tertentu dalam kegiatan usaha misalnya '
                    'output produksi, biaya, pendapatan, atau penggunaan tenaga kerja yang '
                    'berpola seperti deret hitung, maka prinsip-prinsip deret hitung dapat digunakan '
                    'untuk menganalisis perkembangan variabel tersebut. Berpola seperti deret hitung '
                    'maksudnya di sini adalah bahwa variabel yang bersangkutan bertambah dengan '
                    'nilai tertentu secara konstan dari satu periode ke periode berikutnya.\n\n'

                    '🧮 Rumus-rumus Deret Hitung:\n'
                    '1. Suku ke-n (Un):  \n    Un = a + (n-1)·b\n'
                    '2. Jumlah n suku (Sn):  \n    Sn = n/2 x (2a + (n-1)·b)\n'
                    '3. Beda (b):        \n    b = (Un-a) / (n-1)\n\n'

                    '📘 Catatan:\n'
                    'Jika b = 0 barisan konstan; deretnya menjadi Sn = n·a.',
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
                  MaterialPageRoute(builder: (_) => KalkulatorDeretHitungPage()),
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