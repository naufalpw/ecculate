import 'package:flutter/material.dart';
import 'dart:math';

class FungsiPenerimaanPage extends StatefulWidget {
  @override
  _FungsiPenerimaanPageState createState() => _FungsiPenerimaanPageState();
}

class _FungsiPenerimaanPageState extends State<FungsiPenerimaanPage> {
  int jumlahVariabel = 1;
  List<TextEditingController> koefController =
      List.generate(5, (_) => TextEditingController());
  List<TextEditingController> pangkatController =
      List.generate(5, (_) => TextEditingController());
  final kController = TextEditingController();
  final qController = TextEditingController();
  String hasil = '';

  void _reset() {
    for (var ctrl in koefController) ctrl.clear();
    for (var ctrl in pangkatController) ctrl.clear();
    kController.clear();
    qController.clear();
    setState(() {
      hasil = '';
      jumlahVariabel = 1;
    });
  }

String formatAngka(double value) {
  if (value % 1 == 0) {
    return value.toInt().toString(); // Jika bilangan bulat, tampilkan sebagai integer
  } else {
    return value.toStringAsFixed(3).replaceFirst(RegExp(r'\.?0+$'), ''); // Jika desimal, hapus 0 di belakang
  }
}


  String toSuperscript(int number) {
    const superscriptMap = {
      '0': '⁰', '1': '¹', '2': '²', '3': '³', '4': '⁴',
      '5': '⁵', '6': '⁶', '7': '⁷', '8': '⁸', '9': '⁹'
    };
    return number
        .toString()
        .split('')
        .map((c) => superscriptMap[c] ?? '')
        .join();
  }

  void _hitung() {
    double k = double.tryParse(kController.text) ?? 0;
    double q = double.tryParse(qController.text) ?? 0;

    if (q == 0) {
      setState(() {
        hasil = 'Nilai Q tidak boleh nol';
      });
      return;
    }

    double integral = 0;
    List<String> bentukIntegral = [];

    for (int i = 0; i < jumlahVariabel; i++) {
      double a = double.tryParse(koefController[i].text) ?? 0;
      int n = int.tryParse(pangkatController[i].text) ?? 0;

      if (a != 0) {
        double nilaiKoef = a / (n + 1);
        double integralAtQ = nilaiKoef * pow(q, n + 1);
        integral += integralAtQ;

        bentukIntegral.add('${formatAngka(nilaiKoef)}Q${toSuperscript(n + 1)}');
      }
    }

    double kq = k * q;
    double tr = integral + kq;
    double ar = tr / q;

    String bentuk = [
      ...bentukIntegral,
      '${formatAngka(k)}Q'
    ].join(' + ');

    setState(() {
      hasil =
          '∫MR dQ =\n$bentuk\n\n'
          'TR = ∫MR =\n${formatAngka(integral)} + ${formatAngka(k)}x${formatAngka(q)}\n\n'
          'TR = ${formatAngka(tr)}\n'
          'AR = ${formatAngka(ar)}';
    });
  }

  Widget _field(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        style: const TextStyle(fontFamily: 'PressStart2P', fontSize: 12),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontFamily: 'PressStart2P', fontSize: 10),
          border: const OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  Widget _dropdownVariabel() {
    return DropdownButtonFormField<int>(
      value: jumlahVariabel,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Jumlah Variabel MR',
        filled: true,
        fillColor: Colors.white,
      ),
      items: List.generate(5, (i) {
        return DropdownMenuItem(
          value: i + 1,
          child: Text('${i + 1} Variabel',
              style: const TextStyle(fontFamily: 'PressStart2P', fontSize: 12)),
        );
      }),
      onChanged: (val) {
        if (val != null) {
          setState(() => jumlahVariabel = val);
        }
      },
    );
  }

  Widget _buildInputKoefisienPangkat(int index) {
    return Row(
      children: [
        Expanded(child: _field('Koefisien ${index + 1}', koefController[index])),
        const SizedBox(width: 8),
        Expanded(child: _field('Pangkat Koef ${index + 1}', pangkatController[index])),
      ],
    );
  }

  @override
  void dispose() {
    for (var ctrl in koefController) ctrl.dispose();
    for (var ctrl in pangkatController) ctrl.dispose();
    kController.dispose();
    qController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 154, 243, 174),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white), // Ubah warna ikon back
        title: const Text(
          'FUNGSI PENERIMAAN',
          style: TextStyle(
            fontFamily: 'PressStart2P',
            fontSize: 14,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 3),
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Column(
                children: const [
                  Text(
                    'KALKULATOR',
                    style: TextStyle(
                      fontFamily: 'PressStart2P',
                      fontSize: 24,
                      color: Colors.deepOrange,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'PENERIMAAN',
                    style: TextStyle(
                      fontFamily: 'PressStart2P',
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _dropdownVariabel(),
            const SizedBox(height: 16),
            for (int i = 0; i < jumlahVariabel; i++) _buildInputKoefisienPangkat(i),
            const SizedBox(height: 10),
            _field('Konstanta MR (k)', kController),
            _field('Jumlah Output Q', qController),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _button('HITUNG', _hitung, const Color.fromARGB(255, 43, 245, 49))),
                const SizedBox(width: 10),
                Expanded(child: _button('RESET', _reset, const Color.fromARGB(255, 250, 54, 40))),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Container(
                constraints: const BoxConstraints(minHeight: 150),
                alignment: Alignment.topLeft,
                child: Text(
                  hasil.isNotEmpty ? hasil : 'Hasil :',
                  style: const TextStyle(
                    fontFamily: 'PressStart2P',
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _button(String label, VoidCallback onTap, Color color) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: Colors.black, width: 2),
          boxShadow: const [
            BoxShadow(color: Colors.black54, offset: Offset(3, 3)),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'PressStart2P',
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
