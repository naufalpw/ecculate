import 'dart:math' as math;
import 'package:flutter/material.dart';

enum Target { none, p1, pt, r, t }

class PertumbuhanPendudukPage extends StatefulWidget {
  const PertumbuhanPendudukPage({super.key});
  @override
  State<PertumbuhanPendudukPage> createState() => _PertumbuhanPendudukPageState();
}

class _PertumbuhanPendudukPageState extends State<PertumbuhanPendudukPage> {
  final _p1Ctrl = TextEditingController();
  final _ptCtrl = TextEditingController();
  final _rCtrl = TextEditingController();
  final _tCtrl = TextEditingController();

  Target _target = Target.none;
  String _message = '';

  void _reset() {
    _p1Ctrl.clear();
    _ptCtrl.clear();
    _rCtrl.clear();
    _tCtrl.clear();
    setState(() {
      _target = Target.none;
      _message = '';
    });
  }

  bool _hide(Target t) => _target == t;

Widget _targetButton(String label, Target t) => Container(
  width: 60, // Ukuran tetap agar semua tombol sejajar
  margin: const EdgeInsets.symmetric(vertical: 6), // Jarak antar tombol
  decoration: BoxDecoration(
    color: _target == t
        ? const Color.fromARGB(255, 14, 252, 14) // Warna aktif
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
            case Target.p1:
              _p1Ctrl.clear();
              break;
            case Target.pt:
              _ptCtrl.clear();
              break;
            case Target.r:
              _rCtrl.clear();
              break;
            case Target.t:
              _tCtrl.clear();
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


  void _hitung() {
    double? p1 = double.tryParse(_p1Ctrl.text);
    double? pt = double.tryParse(_ptCtrl.text);
    double? r = double.tryParse(_rCtrl.text);
    double? t = double.tryParse(_tCtrl.text);
    String result;

    try {
      switch (_target) {
        case Target.p1:
          if (pt == null || r == null || t == null) throw 'Isi Pt, r, dan t.';
          double R = 1 + r / 100;
          p1 = pt / math.pow(R, t - 1);
          int p1Int = p1.round();
          _p1Ctrl.text = p1Int.toString();
          result = 'P1 = $p1Int';
          break;

        case Target.pt:
          if (p1 == null || r == null || t == null) throw 'Isi P1, r, dan t.';
          double R = 1 + r / 100;
          pt = p1 * math.pow(R, t - 1);
          int ptInt = pt.round();
          _ptCtrl.text = ptInt.toString();
          result = 'Pt = $ptInt';
          break;

        case Target.r:
          if (p1 == null || pt == null || t == null) throw 'Isi P1, Pt, dan t.';
          if (p1 <= 0 || pt <= 0) throw 'P1 dan Pt harus > 0';
          num R = math.pow(pt / p1, 1 / (t - 1));
          r = (R - 1) * 100;
          _rCtrl.text = r.toStringAsFixed(2);
          result = 'r = ${r.toStringAsFixed(2)} %';
          break;

        case Target.t:
          if (p1 == null || pt == null || r == null) throw 'Isi P1, Pt, dan r.';
          if (r == -100) throw 'r tidak boleh -100%';
          double R = 1 + r / 100;
          t = (math.log(pt / p1) / math.log(R)) + 1;
          _tCtrl.text = t.toInt().toString();
          result = 't = ${t.toInt()} tahun';
          break;

        case Target.none:
          throw 'Pilih variabel yang ingin dihitung.';
      }

      setState(() => _message = 'Hasil: $result');
    } catch (e) {
      setState(() => _message = e.toString());
    }
  }

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
          labelStyle: const TextStyle(fontFamily: 'PressStart2P', fontSize: 10),
          border: const OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2.0), // Ketebalan border
        ),
        filled: true,
        fillColor: Colors.white
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white), // Ubah warna ikon back
        title: const Text(
          'MODEL PERTUMBUHAN PENDUDUK',
          style: TextStyle(fontFamily: 'PressStart2P', fontSize: 16, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Container(
          color: const Color.fromARGB(255, 178, 250, 160),
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
                    'PERTUMBUHAN PENDUDUK',
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
                style: TextStyle(fontFamily: 'PressStart2P', fontSize: 12, color: Colors.black),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _targetButton('P1', Target.p1),
                  _targetButton('Pt', Target.pt),
                  _targetButton('r', Target.r),
                  _targetButton('t', Target.t),
                ],
              ),
              const SizedBox(height: 24),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _field('P1 (Penduduk Awal)', _p1Ctrl, Target.p1),
                        _field('Pt (Penduduk Tahun ke-t)', _ptCtrl, Target.pt),
                        _field('r (%) Pertumbuhan per Tahun', _rCtrl, Target.r),
                        _field('t (Jumlah Tahun)', _tCtrl, Target.t),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: _hitung,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 20, 245, 12),
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
                            style: TextStyle(fontFamily: 'PressStart2P', fontSize: 12, color: Colors.white),
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
                          color: const Color.fromARGB(255, 255, 13, 13),
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
                            style: TextStyle(fontFamily: 'PressStart2P', fontSize: 12, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    color: Colors.white
                  ),
                  child: ListView(
                    children: [
                      const Text(
                        'Hasil :',
                        style: TextStyle(fontFamily: 'PressStart2P', fontSize: 14),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _message,
                        style: const TextStyle(fontFamily: 'PressStart2P', fontSize: 12),
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

  @override
  void dispose() {
    _p1Ctrl.dispose();
    _ptCtrl.dispose();
    _rCtrl.dispose();
    _tCtrl.dispose();
    super.dispose();
  }
}
