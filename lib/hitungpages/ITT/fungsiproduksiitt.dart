import 'package:flutter/material.dart';
import 'dart:math';

class FungsiProduksiPage extends StatefulWidget {
  @override
  _FungsiProduksiPageState createState() => _FungsiProduksiPageState();
}

class _FungsiProduksiPageState extends State<FungsiProduksiPage> {
  int jumlahVariabel = 1;
  List<TextEditingController> koefController =
      List.generate(5, (_) => TextEditingController());
  List<TextEditingController> pangkatController =
      List.generate(5, (_) => TextEditingController());
  final kController = TextEditingController(); // Konstanta MP
  final xController = TextEditingController(); // Jumlah input (X)
  final konstantaController = TextEditingController(); // Konstanta biasa
  String hasil = '';

  void _reset() {
    for (var ctrl in koefController) ctrl.clear();
    for (var ctrl in pangkatController) ctrl.clear();
    kController.clear();
    xController.clear();
    konstantaController.clear();
    setState(() {
      hasil = '';
      jumlahVariabel = 1;
    });
  }

  String formatAngka(double value) {
    if (value % 1 == 0) {
      return value.toInt().toString();
    } else {
      return value.toStringAsFixed(3).replaceFirst(RegExp(r'\.?0+$'), '');
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
  double x = double.tryParse(xController.text) ?? 0;
  double konstanta = double.tryParse(konstantaController.text) ?? 0;

  if (x == 0) {
    setState(() {
      hasil = 'Nilai X tidak boleh nol';
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
      double integralAtX = nilaiKoef * pow(x, n + 1);
      integral += integralAtX;

      bentukIntegral.add('${formatAngka(nilaiKoef)}X${toSuperscript(n + 1)}');
    }
  }

  double kx = k * x;
  double tp = integral + kx + konstanta; // kX dulu, baru konstanta
  double ap = tp / x;

  String bentuk = [
    ...bentukIntegral,
    '${formatAngka(k)}X',
    if (konstanta != 0) formatAngka(konstanta),
  ].join(' + ');

  setState(() {
    hasil =
        '∫MP dX =\n$bentuk\n\n'
        'TP = ∫MP =\n${formatAngka(integral)} + ${formatAngka(k)}x${formatAngka(x)} + ${formatAngka(konstanta)}\n\n'
        'TP = ${formatAngka(tp)}\n'
        'AP = ${formatAngka(ap)}';
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
        labelText: 'Jumlah Variabel MP',
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

  @override
  void dispose() {
    for (var ctrl in koefController) ctrl.dispose();
    for (var ctrl in pangkatController) ctrl.dispose();
    kController.dispose();
    xController.dispose();
    konstantaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 173, 245, 183),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white), // Ubah warna ikon back
        title: const Text(
          'FUNGSI PRODUKSI',
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
                    'PRODUKSI',
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
            _field('Konstanta MP (k)', kController),
            _field('Konstanta k', konstantaController),
            _field('Jumlah Input X', xController),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _button('HITUNG', _hitung, const Color.fromARGB(255, 36, 253, 43))),
                const SizedBox(width: 10),
                Expanded(child: _button('RESET', _reset, const Color.fromARGB(255, 250, 53, 39))),
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
}
