import 'package:flutter/material.dart';
import 'dart:math';

class FungsiPenawaranDerivatifPage extends StatefulWidget {
  @override
  State<FungsiPenawaranDerivatifPage> createState() =>
      _FungsiPenawaranDerivatifPageState();
}

class _FungsiPenawaranDerivatifPageState
    extends State<FungsiPenawaranDerivatifPage> {
  final qController = TextEditingController(); // Quantity input
  final cController = TextEditingController(); // Constant
  final q1Controller = TextEditingController(); // Koef Q
  final q2Controller = TextEditingController(); // Koef Q²
  final q3Controller = TextEditingController(); // Koef Q³

  String hasil = '';
  int pangkatTerbesar = 1;

  double _parse(TextEditingController ctrl) =>
      double.tryParse(ctrl.text.trim()) ?? 0;

  String formatHasil(num val) =>
      val == val.toInt() ? val.toInt().toString() : val.toStringAsFixed(2);

  String formatKoef(TextEditingController ctrl) {
    final val = double.tryParse(ctrl.text.trim());
    if (val == null || val == 0) return '';
    return val == val.toInt() ? val.toInt().toString() : val.toString();
  }

  void _hitung() {
    final nilaiQ = double.tryParse(qController.text);
    if (nilaiQ == null || nilaiQ == 0) {
      setState(() => hasil = 'Nilai Q tidak valid atau nol');
      return;
    }

    final a = pangkatTerbesar >= 3 ? _parse(q3Controller) : 0;
    final b = pangkatTerbesar >= 2 ? _parse(q2Controller) : 0;
    final c = _parse(q1Controller);
    final d = _parse(cController);

    if (a == 0 && b == 0 && c == 0 && d == 0) {
      setState(() => hasil = 'Masukkan minimal satu koefisien atau konstanta!');
      return;
    }

    // Bentuk P(Q)
    List<String> bentukP = [];
    if (a != 0) bentukP.add('${formatKoef(q3Controller)}Q³');
    if (b != 0) bentukP.add('${formatKoef(q2Controller)}Q²');
    if (c != 0) bentukP.add('${formatKoef(q1Controller)}Q');
    if (d != 0) bentukP.add('${formatKoef(cController)}');
    final persamaanP = bentukP.join(' + ');

    // TR(Q) = P(Q) * Q
    double tr = (a * pow(nilaiQ, 3) + b * pow(nilaiQ, 2) + c * nilaiQ + d) * nilaiQ;

    List<String> bentukTR = [];
    if (a != 0) bentukTR.add('${formatHasil(a)}Q⁴');
    if (b != 0) bentukTR.add('${formatHasil(b)}Q³');
    if (c != 0) bentukTR.add('${formatHasil(c)}Q²');
    if (d != 0) bentukTR.add('${formatHasil(d)}Q');
    final persamaanTR = bentukTR.join(' + ');

    // MR = turunan TR(Q)
    double mr = 4 * a * pow(nilaiQ, 3) + 3 * b * pow(nilaiQ, 2) + 2 * c * nilaiQ + d;
    List<String> bentukMR = [];
    if (a != 0) bentukMR.add('${formatHasil(4 * a)}Q³');
    if (b != 0) bentukMR.add('${formatHasil(3 * b)}Q²');
    if (c != 0) bentukMR.add('${formatHasil(2 * c)}Q');
    if (d != 0) bentukMR.add('${formatHasil(d)}');
    final turunanTR = bentukMR.join(' + ');

    // AR
    double ar = tr / nilaiQ;

    setState(() {
      hasil =
          'P = $persamaanP\n\n'
          '---------------------------\n\n'
          'TR(Q) = PxQ = $persamaanTR\n'
          'TR($nilaiQ) = ${formatHasil(tr)}\n\n'
          'TR = ${formatHasil(tr)}\n\n'
          '---------------------------\n\n'
          'AR = TR/Q = ${formatHasil(tr)} / ${formatHasil(nilaiQ)} = ${formatHasil(ar)}\n\n'
          'AR = ${formatHasil(ar)}\n\n'
          '---------------------------\n\n'
          'MR = $turunanTR\n'
          'MR($nilaiQ) = ${formatHasil(mr)}\n\n'
          'MR = ${formatHasil(mr)}';

    });
  }

  void _reset() {
    qController.clear();
    cController.clear();
    q1Controller.clear();
    q2Controller.clear();
    q3Controller.clear();
    hasil = '';
    pangkatTerbesar = 1;
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

  Widget _dropdown() {
    return DropdownButtonFormField<int>(
      value: pangkatTerbesar,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Pangkat Tertinggi',
        filled: true,
        fillColor: Colors.white,
      ),
      items: const [
        DropdownMenuItem(value: 1, child: Text('Pangkat 1', style: TextStyle(fontFamily: 'PressStart2P', fontSize: 12))),
        DropdownMenuItem(value: 2, child: Text('Pangkat 2', style: TextStyle(fontFamily: 'PressStart2P', fontSize: 12))),
        DropdownMenuItem(value: 3, child: Text('Pangkat 3', style: TextStyle(fontFamily: 'PressStart2P', fontSize: 12))),
      ],
      onChanged: (val) => setState(() => pangkatTerbesar = val ?? 1),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 187, 255, 170),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white), // Ubah warna ikon back
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          'FUNGSI PENERIMAAN',
          style: TextStyle(fontFamily: 'PressStart2P', fontSize: 14, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Padding(
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
                      'FUNGSI PENERIMAAN',
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
              _dropdown(),
              const SizedBox(height: 20),
              if (pangkatTerbesar >= 3) _field('Koefisien Q³', q3Controller),
              if (pangkatTerbesar >= 2) _field('Koefisien Q²', q2Controller),
              _field('Koefisien Q¹', q1Controller),
              _field('Konstanta', cController),
              _field('Quantity (Q)', qController),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: _hitung,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 43, 243, 50),
                          border: Border.all(color: Colors.black, width: 3),
                          boxShadow: const [
                            BoxShadow(color: Colors.black54, offset: Offset(4, 4))
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            'HITUNG',
                            style: TextStyle(
                              fontFamily: 'PressStart2P',
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: InkWell(
                      onTap: _reset,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 241, 43, 29),
                          border: Border.all(color: Colors.black, width: 3),
                          boxShadow: const [
                            BoxShadow(color: Colors.black54, offset: Offset(4, 4))
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            'RESET',
                            style: TextStyle(
                              fontFamily: 'PressStart2P',
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  color: Colors.white,
                ),
                child: Text(
                  hasil.isNotEmpty ? hasil : 'Hasil :',
                  style: const TextStyle(fontFamily: 'PressStart2P', fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
