import 'package:flutter/material.dart';
import 'dart:math';

class SurplusKonsumen extends StatefulWidget {
  @override
  _SurplusKonsumenState createState() => _SurplusKonsumenState();
}

class _SurplusKonsumenState extends State<SurplusKonsumen> {
  int jumlahVariabel = 1;

  List<TextEditingController> koefController =
      List.generate(3, (_) => TextEditingController());
  List<TextEditingController> pangkatController =
      List.generate(3, (_) => TextEditingController());
  final konstantaController = TextEditingController();
  final qeController = TextEditingController();
  final peController = TextEditingController();

  String hasil = '';

  void _reset() {
    for (var ctrl in koefController) ctrl.clear();
    for (var ctrl in pangkatController) ctrl.clear();
    konstantaController.clear();
    qeController.clear();
    peController.clear();
    setState(() {
      hasil = '';
      jumlahVariabel = 1;
    });
  }

  String formatAngka(double value) {
    if (value == value.roundToDouble()) {
      return value.toInt().toString();
    } else {
      return value.toStringAsFixed(3).replaceFirst(RegExp(r'\.?0+$'), '');
    }
  }

  void _hitung() {
    double? qe = double.tryParse(qeController.text);
    double? pe = double.tryParse(peController.text);
    double k = double.tryParse(konstantaController.text) ?? 0;

    if (qe == null || pe == null) {
      setState(() {
        hasil = 'Qₑ dan Pₑ wajib diisi';
      });
      return;
    }

    double h = qe / 1000;
    double integral = 0;
    for (int i = 0; i <= 1000; i++) {
      double q = i * h;
      double sum = 0;
      for (int j = 0; j < jumlahVariabel; j++) {
        double a = double.tryParse(koefController[j].text) ?? 0;
        double n = double.tryParse(pangkatController[j].text) ?? 0;
        sum += a * pow(q, n);
      }
      double f = sum + k;
      integral += (i == 0 || i == 1000) ? 0.5 * f : f;
    }
    integral *= h;
    double surplus = integral - (qe * pe);

    setState(() {
      hasil =
          'CS = ∫Pd(Q)dQ - Qₑ × Pₑ\n\n'
          'CS = ${formatAngka(integral)} - ${formatAngka(qe)} × ${formatAngka(pe)}\n\n'
          'CS = ${formatAngka(surplus)}';
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
          labelStyle:
              const TextStyle(fontFamily: 'PressStart2P', fontSize: 10),
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
        labelText: 'Jumlah Variabel',
        filled: true,
        fillColor: Colors.white,
      ),
      items: List.generate(3, (i) {
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
    konstantaController.dispose();
    qeController.dispose();
    peController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 155, 247, 160),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white), // Ubah warna ikon back
        title: const Text(
          'SURPLUS KONSUMEN',
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
                    'SURPLUS KONSUMEN',
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
            _field('Konstanta', konstantaController),
            _field('Qₑ (Kuantitas)', qeController),
            _field('Pₑ (Harga)', peController),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _button('HITUNG', _hitung, const Color.fromARGB(255, 54, 255, 60))),
                const SizedBox(width: 10),
                Expanded(child: _button('RESET', _reset, const Color.fromARGB(255, 255, 47, 33))),
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
