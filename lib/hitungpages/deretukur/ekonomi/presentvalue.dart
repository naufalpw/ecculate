import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Kalkulator Present Value
/// Rumus:
///   •  P = Fn / (1 + I)ⁿ              (jika m kosong atau = 1)
///   •  P = Fn / (1 + I/m)^(m·n)       (jika m diisi)
class PresentValuePage extends StatefulWidget {
  const PresentValuePage({super.key});

  @override
  State<PresentValuePage> createState() => _PresentValuePageState();
}

class _PresentValuePageState extends State<PresentValuePage> {
  // ───────── controller ─────────
  final _fnCtrl = TextEditingController();
  final _iCtrl  = TextEditingController();
  final _nCtrl  = TextEditingController();
  final _mCtrl  = TextEditingController();

  String _message = '';

  // ───────── RESET ─────────
  void _reset() {
    _fnCtrl.clear();
    _iCtrl.clear();
    _nCtrl.clear();
    _mCtrl.clear();
    setState(() => _message = '');
  }

  // ───────── HITUNG P ─────────
  void _hitung() {
    if ([_fnCtrl, _iCtrl, _nCtrl].any((c) => c.text.trim().isEmpty)) {
      setState(() => _message = 'Fn, I, dan n wajib diisi!');
      return;
    }

    final Fn = double.tryParse(_fnCtrl.text);
    final I  = double.tryParse(_iCtrl.text);
    final n  = double.tryParse(_nCtrl.text);
    final m  = double.tryParse(_mCtrl.text) ?? 1;

    if (Fn == null || I == null || n == null || Fn <= 0 || n <= 0 || m <= 0) {
      setState(() => _message = 'Input tidak valid!');
      return;
    }

    final P = m == 1
        ? Fn / math.pow(1 + I, n)
        : Fn / math.pow(1 + I / m, m * n);

    setState(() => _message = 'Present Value  P = ${P.toStringAsFixed(2)}');
  }

  // ───────── FIELD helper ─────────
  Widget _field(String label, TextEditingController c,
      {bool optional = false}) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: TextField(
          controller: c,
          keyboardType:
              const TextInputType.numberWithOptions(decimal: true, signed: false),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
          ],
          style: const TextStyle(fontFamily: 'PressStart2P', fontSize: 12),
          decoration: InputDecoration(
            labelText: optional ? '$label' : label,
            labelStyle:
                const TextStyle(fontFamily: 'PressStart2P', fontSize: 10),
            border: const OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2.0),
            ),
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
          'MODEL PRESENT VALUE',
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
                    'PRESENT VALUE',
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

            // Input area
            Container(
              padding: const EdgeInsets.all(12),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black, width: 2)),
              child: Column(
                children: [
                  _field('Fn (Investasi masa depan)', _fnCtrl),
                  _field('I (tingkat bunga per tahun)', _iCtrl),
                  _field('n (jumlah tahun)', _nCtrl),
                  _field('m (frekuensi per tahun)', _mCtrl, optional: true),
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 8),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 33, 255, 12),
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 8),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 240, 14, 14),
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
    _fnCtrl.dispose();
    _iCtrl.dispose();
    _nCtrl.dispose();
    _mCtrl.dispose();
    super.dispose();
  }
}
