import 'dart:math' as math;
import 'package:flutter/material.dart';

class BungaMajemukPage extends StatefulWidget {
  const BungaMajemukPage({super.key});

  @override
  State<BungaMajemukPage> createState() => _BungaMajemukPageState();
}

class _BungaMajemukPageState extends State<BungaMajemukPage> {
  final _pCtrl = TextEditingController();
  final _iCtrl = TextEditingController();
  final _nCtrl = TextEditingController();
  final _mCtrl = TextEditingController(); // boleh kosong → dianggap 1

  String _message = '';

  // ───────── RESET ─────────
  void _reset() {
    _pCtrl.clear();
    _iCtrl.clear();
    _nCtrl.clear();
    _mCtrl.clear();
    setState(() => _message = '');
  }

  // ───────── HITUNG Fn ─────────
  void _hitung() {
    if ([_pCtrl, _iCtrl, _nCtrl].any((c) => c.text.trim().isEmpty)) {
      setState(() => _message = 'P, I, dan n wajib diisi!');
      return;
    }

    final P = double.tryParse(_pCtrl.text);
    final I = double.tryParse(_iCtrl.text);
    final n = double.tryParse(_nCtrl.text);
    final m = double.tryParse(_mCtrl.text) ?? 1; // kosong → 1

    if (P == null || I == null || n == null || P <= 0 || n <= 0 || m <= 0) {
      setState(() => _message = 'Input tidak valid!');
      return;
    }

    final Fn = m == 1
        ? P * math.pow(1 + I, n)
        : P * math.pow(1 + I / m, m * n);

    setState(() => _message = 'Fn = ${Fn.toStringAsFixed(2)}');
  }

  // ───────── FIELD HELPER ─────────
  Widget _field(String label, TextEditingController c) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: TextField(
          controller: c,
          keyboardType: TextInputType.number,
          style: const TextStyle(fontFamily: 'PressStart2P', fontSize: 12),
          decoration: InputDecoration(
            labelText: label,
            labelStyle:
                const TextStyle(fontFamily: 'PressStart2P', fontSize: 10),
            border: const OutlineInputBorder(),
            filled: true,
            fillColor: Colors.white
          ),
        ),
      );

  // ───────── UI ─────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white), // Ubah warna ikon back
        title: const Text(
          'MODEL BUNGA MAJEMUK',
          style: TextStyle(
            fontFamily: 'PressStart2P',
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                    'BUNGA MAJEMUK',
                    style: TextStyle(
                      fontFamily: 'PressStart2P',
                      fontSize: 16,
                      color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 24),

            // Input
            Container(
              padding: const EdgeInsets.all(12),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black, width: 2)),
              child: Column(
                children: [
                  _field('P (Present)', _pCtrl),
                  _field('I (suku bunga per tahun)', _iCtrl),
                  _field('n (Jumlah Tahun)', _nCtrl),
                  _field('m (Frekuensi per tahun)', _mCtrl),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Tombol Hitung & Reset
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: _hitung,
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 10, 248, 10),
                        border: Border.all(color: Colors.black, width: 3),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black54,
                            offset: Offset(4, 4),
                            blurRadius: 0,
                          ),
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
                      padding:
                          const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 252, 17, 17),
                        border: Border.all(color: Colors.black, width: 3),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black54,
                            offset: Offset(4, 4),
                            blurRadius: 0,
                          ),
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
            const SizedBox(height: 24),

            // Area hasil
            Container(
              padding: const EdgeInsets.all(12),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black, width: 2),color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hasil :',
                    style: TextStyle(
                      fontFamily: 'PressStart2P',
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _message,
                    style: const TextStyle(
                      fontFamily: 'PressStart2P',
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ───────── bersihkan controller ─────────
  @override
  void dispose() {
    _pCtrl.dispose();
    _iCtrl.dispose();
    _nCtrl.dispose();
    _mCtrl.dispose();
    super.dispose();
  }
}
