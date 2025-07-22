import 'package:flutter/material.dart';
import 'dart:math';

class FungsiLabaDerivatifPage extends StatefulWidget {
  @override
  State<FungsiLabaDerivatifPage> createState() => _FungsiLabaDerivatifPageState();
}

class _FungsiLabaDerivatifPageState extends State<FungsiLabaDerivatifPage> {
  int jumlahVariabel = 1;
  final tcControllers = List.generate(5, (_) => TextEditingController());
  final trControllers = List.generate(5, (_) => TextEditingController());
  final qController = TextEditingController();
  String hasil = '';

  double _parse(TextEditingController ctrl) => double.tryParse(ctrl.text.trim()) ?? 0;

  String formatHasil(num val) {
    if (val % 1 == 0) return val.toInt().toString();
    String str = val.toStringAsFixed(10);
    str = str.replaceFirst(RegExp(r'0+\$'), '').replaceFirst(RegExp(r'\.\$'), '');
    return str;
  }

  void _reset() {
    for (var c in [...tcControllers, ...trControllers, qController]) {
      c.clear();
    }
    setState(() {
      hasil = '';
    });
  }

  void _hitung() {
    final trKoef = List<double>.generate(jumlahVariabel + 1, (i) => _parse(trControllers[jumlahVariabel - i]));
    final tcKoef = List<double>.generate(jumlahVariabel + 1, (i) => _parse(tcControllers[jumlahVariabel - i]));
    final q = _parse(qController);

    double hitungPolinomial(List<double> koef, double q) {
      double total = 0;
      for (int i = 0; i < koef.length; i++) {
        int pangkat = jumlahVariabel - i;
        total += koef[i] * pow(q, pangkat);
      }
      return total;
    }

    String tampilkanPersamaan(List<double> koef) {
      List<String> terms = [];
      for (int i = 0; i < koef.length; i++) {
        int pangkat = jumlahVariabel - i;
        if (koef[i] != 0) {
          final term = '${formatHasil(koef[i])}${pangkat > 0 ? 'Q${pangkat > 1 ? '^$pangkat' : ''}' : ''}';
          terms.add(term);
        }
      }
      return terms.isEmpty ? '0' : terms.join(' + ');
    }

    final bentukTR = tampilkanPersamaan(trKoef);
    final bentukTC = tampilkanPersamaan(tcKoef);
    final nilaiTR = hitungPolinomial(trKoef, q);
    final nilaiTC = hitungPolinomial(tcKoef, q);
    final laba = nilaiTR - nilaiTC;

    hasil = 
            'TR = $bentukTR'
            '\n\nSubstitusi Q = ${formatHasil(q)}\n'
            '\nTR = ${formatHasil(nilaiTR)}\n'
            '----------------------------'
            '\nTC = $bentukTC'
            '\n\nSubstitusi Q = ${formatHasil(q)}\n'
            '\nTC = ${formatHasil(nilaiTC)}\n'
            '----------------------------'
            '\n\nLaba(π) = TR - TC\n'
            '        = ${formatHasil(nilaiTR)} - ${formatHasil(nilaiTC)}\n\n'
            'Laba(π) = ${formatHasil(laba)}';

    setState(() {});
  }

  Widget _field(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        style: const TextStyle(fontFamily: 'PressStart2P', fontSize: 12),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontFamily: 'PressStart2P', fontSize: 10),
          border: const OutlineInputBorder(),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2),
          ),
          filled: true,
          fillColor: Colors.white,
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
          boxShadow: const [BoxShadow(color: Colors.black54, offset: Offset(3, 3))],
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(fontFamily: 'PressStart2P', fontSize: 12, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (final c in [...tcControllers, ...trControllers, qController]) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 174, 255, 174),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white), // Ubah warna ikon back
        title: const Text('FUNGSI LABA', style: TextStyle(fontFamily: 'PressStart2P', fontSize: 14, color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
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
                    'FUNGSI LABA',
                    style: TextStyle(
                      fontFamily: 'PressStart2P',
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<int>(
              value: jumlahVariabel,
              decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Jumlah Variabel', filled: true, fillColor: Colors.white),
              items: List.generate(3, (i) {
                return DropdownMenuItem(
                  value: i + 1,
                  child: Text('${i + 1} Variabel', style: const TextStyle(fontFamily: 'PressStart2P',fontSize: 12)),
                );
              }),
              onChanged: (val) {
                if (val != null) setState(() => jumlahVariabel = val);
              },
            ),
            const SizedBox(height: 16),
            const Text('Fungsi TR', style: TextStyle(fontFamily: 'PressStart2P', fontSize: 10)),
            for (int i = jumlahVariabel; i >= 1; i--) _field('Koefisien Q^$i (TR)', trControllers[i]),
            _field('Konstanta (TR)', trControllers[0]),
            const SizedBox(height: 8),
            const Text('Fungsi TC', style: TextStyle(fontFamily: 'PressStart2P', fontSize: 10)),
            for (int i = jumlahVariabel; i >= 1; i--) _field('Koefisien Q^$i (TC)', tcControllers[i]),
            _field('Konstanta (TC)', tcControllers[0]),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: TextField(
                controller: qController,
                keyboardType: TextInputType.number,
                style: const TextStyle(fontFamily: 'PressStart2P', fontSize: 12),
                decoration: InputDecoration(
                  labelText: 'Nilai Q',
                  labelStyle: const TextStyle(fontFamily: 'PressStart2P', fontSize: 10),
                  border: const OutlineInputBorder(),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _button('HITUNG', _hitung, const Color.fromARGB(255, 19, 238, 19))),
                const SizedBox(width: 12),
                Expanded(child: _button('RESET', _reset, const Color.fromARGB(255, 255, 22, 22))),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 2), color: Colors.white),
              child: Text(
                hasil.isNotEmpty ? hasil : 'Hasil :',
                style: const TextStyle(fontFamily: 'PressStart2P', fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}