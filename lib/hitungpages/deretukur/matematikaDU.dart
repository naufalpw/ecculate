import 'dart:math' as math;
import 'package:flutter/material.dart';


enum Target { none, a, r, n, un, sn }

class MatematikaDU extends StatefulWidget {
  const MatematikaDU({super.key});

  @override
  State<MatematikaDU> createState() =>
      _MatematikaDUState();
}

class _MatematikaDUState extends State<MatematikaDU> {
  // ───────── controller ─────────
  final _aCtrl = TextEditingController();
  final _rCtrl = TextEditingController();
  final _nCtrl = TextEditingController();
  final _unCtrl = TextEditingController();
  final _snCtrl = TextEditingController();

  Target _target = Target.none;
  String _message = '';

  // ───────── reset ─────────
  void _reset() {
    _aCtrl.clear();
    _rCtrl.clear();
    _nCtrl.clear();
    _unCtrl.clear();
    _snCtrl.clear();
    setState(() {
      _target = Target.none;
      _message = '';
    });
  }

  // ───────── helper ─────────
  bool _hide(Target t) => _target == t;

Widget _targetButton(String label, Target t) => Container(
  width: 60, // Sesuai referensi
  margin: const EdgeInsets.symmetric(vertical: 6),
  decoration: BoxDecoration(
    color: _target == t
        ? const Color.fromARGB(255, 31, 255, 24)
        : Colors.grey.shade700,
    border: Border.all(color: Colors.black, width: 3),
    borderRadius: BorderRadius.circular(8),
    boxShadow: const [
      BoxShadow(
        color: Colors.black54,
        offset: Offset(4, 4),
        blurRadius: 0,
      ),
    ],
  ),
  child: Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: () {
        setState(() {
          _target = t;
          switch (t) {
            case Target.a:
              _aCtrl.clear();
              break;
            case Target.r:
              _rCtrl.clear();
              break;
            case Target.n:
              _nCtrl.clear();
              break;
            case Target.un:
              _unCtrl.clear();
              break;
            case Target.sn:
              _snCtrl.clear();
              break;
            case Target.none:
              break;
          }
          _message = '';
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        alignment: Alignment.center,
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'PressStart2P',
            fontSize: 12,
            color: Colors.white,
          ),
        ),
      ),
    ),
  ),
);


  // ───────── HITUNG ─────────
  void _hitung() {
    double? a = double.tryParse(_aCtrl.text);
    double? r = double.tryParse(_rCtrl.text);
    double? n = double.tryParse(_nCtrl.text);
    double? un = double.tryParse(_unCtrl.text);
    double? sn = double.tryParse(_snCtrl.text);
    String result;

    try {
      switch (_target) {
        // ── Cari a ──────────────────────────────
        case Target.a:
          if (r != null && n != null && un != null) {
            if (r == 0) throw 'r tidak boleh 0';
            a = un / math.pow(r, n - 1);
          } else if (r != null && n != null && sn != null) {
            if (r == 1) {
              a = sn / n;
            } else if (r > 1) {
              a = sn * (r - 1) / (math.pow(r, n) - 1);
            } else {
              a = sn * (1 - r) / (1 - math.pow(r, n));
            }
          } else {
            throw 'Isi r & n + (Un atau Sn).';
          }
          _aCtrl.text = a.toString();
          result = 'a = $a';
          break;

        // ── Cari r ──────────────────────────────
        case Target.r:
          if (a != null && n != null && un != null) {
            if (n <= 1) throw 'n harus > 1 untuk mencari r';
            if (a == 0) throw 'a tidak boleh 0';
            r = math.pow(un / a, 1 / (n - 1)) as double?;
          } else {
            throw 'Isi a & n & Un.';
          }
          _rCtrl.text = r.toString();
          result = 'r = $r';
          break;

        // ── Cari n ──────────────────────────────
        case Target.n:
          if (a == null || r == null) throw 'Isi a & r.';
          if (r == 1) {
            if (un != null && un != a) throw 'Un tidak cocok dengan r=1';
            if (sn != null) {
              n = sn / a;
            } else if (un != null) {
              n = 1;
            } else {
              throw 'Isi Un atau Sn.';
            }
          } else if (un != null) {
            if (a == 0) throw 'a tidak boleh 0';
            n = (math.log(un / a) / math.log(r)) + 1;
          } else if (sn != null) {
            if (r > 1) {
              final expr = sn * (r - 1) / a + 1;
              n = math.log(expr) / math.log(r);
            } else {
              final expr = 1 - sn * (1 - r) / a;
              if (expr <= 0) throw 'Nilai tidak valid untuk r < 1';
              n = math.log(expr) / math.log(r);
            }
          } else {
            throw 'Isi Un atau Sn untuk mencari n.';
          }
          if (n == null || n < 1 || n % 1 != 0) {
            throw 'n harus bilangan bulat ≥ 1';
          }
          _nCtrl.text = n.toInt().toString();
          result = 'n = ${n.toInt()}';
          break;

        // ── Cari Un ─────────────────────────────
        case Target.un:
          if (a == null || r == null || n == null) throw 'Isi a, r, dan n.';
          un = a * math.pow(r, n - 1);
          _unCtrl.text = un.toString();
          result = 'Un = $un';
          break;

        // ── Cari Sn ─────────────────────────────
        case Target.sn:
          if (a == null || r == null || n == null) throw 'Isi a, r, dan n.';
          if (r == 1) {
            sn = a * n;
          } else if (r > 1) {
            sn = a * (math.pow(r, n) - 1) / (r - 1);
          } else {
            sn = a * (1 - math.pow(r, n)) / (1 - r);
          }
          _snCtrl.text = sn.toString();
          result = 'Sn = $sn';
          break;

        case Target.none:
          throw 'Pilih variabel yang ingin dihitung.';
      }

      setState(() => _message = 'Hasil: $result');
    } catch (e) {
      setState(() => _message = e.toString());
    }
  }

  // ───────── FIELD widget ─────────
  Widget _field(String label, TextEditingController ctrl, Target t) {
    if (_hide(t)) return const SizedBox.shrink();
    final bool enabled = _target != Target.none;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: ctrl,
        keyboardType: TextInputType.number,
        enabled: enabled,
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
  }

  // ───────── UI ─────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white), // Ubah warna ikon back
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          'DERET UKUR',
          style:
              TextStyle(fontFamily: 'PressStart2P', fontSize: 16, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Container(
          color: const Color.fromARGB(255, 184, 255, 181),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Header
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
                    'DERET UKUR',
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
              const Text(
                'Pilih salah satu yang ingin dicari :)',
                style: TextStyle(
                  fontFamily: 'PressStart2P',
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 12),
              // Tombol target
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _targetButton('a', Target.a),
                  _targetButton('r', Target.r),
                  _targetButton('n', Target.n),
                  _targetButton('Un', Target.un),
                  _targetButton('Sn', Target.sn),
                ],
              ),
              const SizedBox(height: 24),
              // Input area (border tetap, isi scroll)
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black, width: 2)),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _field('Suku Pertama (a)', _aCtrl, Target.a),
                        _field('Rasio (r)', _rCtrl, Target.r),
                        _field('Jumlah Suku (n)', _nCtrl, Target.n),
                        _field('Suku Ke n (Un)', _unCtrl, Target.un),
                        _field('Jumlah (Sn)', _snCtrl, Target.sn),
                      ],
                    ),
                  ),
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
                          color: const Color.fromARGB(255, 24, 247, 17),
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
                          color: const Color.fromARGB(255, 241, 16, 16),
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
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black, width: 2),color: Colors.white),
                  child: ListView(
                    children: [
                      const Text(
                        'Hasil :',
                        style: TextStyle(
                            fontFamily: 'PressStart2P', fontSize: 14),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _message,
                        style: const TextStyle(
                            fontFamily: 'PressStart2P', fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ───────── bersihkan controller ─────────
  @override
  void dispose() {
    _aCtrl.dispose();
    _rCtrl.dispose();
    _nCtrl.dispose();
    _unCtrl.dispose();
    _snCtrl.dispose();
    super.dispose();
  }
}
