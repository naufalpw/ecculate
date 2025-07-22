import 'dart:math' as math;
import 'package:flutter/material.dart';


enum Target { none, a, b, n, un, sn }

class KalkulatorDeretHitungPage extends StatefulWidget {
  const KalkulatorDeretHitungPage({super.key});

  @override
  State<KalkulatorDeretHitungPage> createState() => _KalkulatorDeretHitungPageState();
}

class _KalkulatorDeretHitungPageState extends State<KalkulatorDeretHitungPage> {
  


  final _aCtrl = TextEditingController();
  final _bCtrl = TextEditingController();
  final _nCtrl = TextEditingController();
  final _unCtrl = TextEditingController();
  final _snCtrl = TextEditingController();

  Target _target = Target.none;
  String _message = '';

  void _reset() {
    _aCtrl.clear();
    _bCtrl.clear();
    _nCtrl.clear();
    _unCtrl.clear();
    _snCtrl.clear();
    setState(() {
      _target = Target.none;
      _message = '';
    });
  }

  bool _hide(Target t) => _target == t;

  String formatResult(double value) {
    return value == value.roundToDouble()
        ? value.toInt().toString()
        : value.toStringAsFixed(3).replaceFirst(RegExp(r'\.?0+$'), '');
  }

Widget _targetButton(String label, Target t) => Container(
  width: 60, // Ukuran tetap agar semua tombol sejajar
  margin: const EdgeInsets.symmetric(vertical: 6),
  decoration: BoxDecoration(
    color: _target == t
        ? const Color.fromARGB(255, 35, 223, 11) // Warna aktif
        : const Color.fromARGB(255, 114, 111, 111), // Warna tidak aktif
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
            case Target.a: _aCtrl.clear(); break;
            case Target.b: _bCtrl.clear(); break;
            case Target.n: _nCtrl.clear(); break;
            case Target.un: _unCtrl.clear(); break;
            case Target.sn: _snCtrl.clear(); break;
            case Target.none: break;
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
    double? a = double.tryParse(_aCtrl.text);
    double? b = double.tryParse(_bCtrl.text);
    double? n = double.tryParse(_nCtrl.text);
    double? un = double.tryParse(_unCtrl.text);
    double? sn = double.tryParse(_snCtrl.text);
    String result;

    try {
      switch (_target) {
        case Target.a:
          if (b != null && n != null && un != null) {
            a = un - (n - 1) * b;
          } else if (b != null && n != null && sn != null) {
            a = (2 * sn / n - (n - 1) * b) / 2;
          } else {
            throw 'Isi b & n + (Un atau Sn).';
          }
          _aCtrl.text = a.toString();
          result = 'a = ${formatResult(a)}';
          break;

        case Target.b:
          if (a != null && n != null && un != null) {
            b = (un - a) / (n - 1);
          } else if (a != null && n != null && sn != null) {
            b = (2 * sn / n - 2 * a) / (n - 1);
          } else {
            throw 'Isi a & n + (Un atau Sn).';
          }
          _bCtrl.text = b.toString();
          result = 'b = ${formatResult(b)}';
          break;

        case Target.n:
          if (a == null || b == null) throw 'Isi a & b.';
          if (un != null) {
            if (b == 0) throw 'b tidak boleh 0';
            n = ((un - a) / b) + 1;
          } else if (sn != null) {
            if (b == 0) {
              if (a == 0) throw 'Tidak terdefinisi (a = b = 0)';
              n = sn / a;
            } else {
              final disc = math.pow(2 * a - b, 2) + 8 * b * sn;
              if (disc < 0) throw 'Diskriminan negatif, n tidak real';
              n = (-(2 * a - b) + math.sqrt(disc)) / (2 * b);
            }
          } else {
            throw 'Isi Un atau Sn.';
          }
          if (n! < 1 || n % 1 != 0) throw 'n harus bilangan bulat ≥ 1';
          _nCtrl.text = n.toInt().toString();
          result = 'n = ${n.toInt()}';
          break;

        case Target.un:
          if (a == null || b == null || n == null) throw 'Isi a, b, dan n.';
          un = a + (n - 1) * b;
          _unCtrl.text = un.toString();
          result = 'Un = ${formatResult(un)}';
          break;

        case Target.sn:
          if (a == null || n == null) throw 'Isi a dan n.';
          
          if (b != null) {
            // Rumus: Sn = n/2 × (2a + (n - 1)b)
            sn = n / 2 * (2 * a + (n - 1) * b);
          } else if (un != null) {
            // Rumus alternatif: Sn = n/2 × (a + Un)
            sn = n / 2 * (a + un);
          } else {
            // Rumus alternatif jika Un kosong: Hitung Un dulu jika mungkin
            // Un = a + (n - 1) × b → tapi karena b juga null, kita tidak bisa lanjut
            throw 'Isi b atau Un.';
          }
        
          _snCtrl.text = sn.toString();
          result = 'Sn = ${formatResult(sn)}';
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
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2.0),
          ),
          filled: true,
          fillColor: Colors.white,
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
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          'DERET HITUNG',
          style: TextStyle(fontFamily: 'PressStart2P', fontSize: 16, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Container(
          color: const Color.fromARGB(255, 194, 255, 189),
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
                    Text('KALKULATOR',
                        style: TextStyle(
                            fontFamily: 'PressStart2P',
                            fontSize: 24,
                            color: Colors.deepOrange)),
                    SizedBox(height: 8),
                    Text('DERET HITUNG',
                        style: TextStyle(
                            fontFamily: 'PressStart2P',
                            fontSize: 16,
                            color: Colors.black)),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Pilih salah satu yang ingin dicari :)',
                style: TextStyle(fontFamily: 'PressStart2P', fontSize: 12),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _targetButton('a', Target.a),
                  _targetButton('b', Target.b),
                  _targetButton('n', Target.n),
                  _targetButton('Un', Target.un),
                  _targetButton('Sn', Target.sn),
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
                        _field('Suku Pertama (a)', _aCtrl, Target.a),
                        _field('Beda (b)', _bCtrl, Target.b),
                        _field('Jumlah Suku (n)', _nCtrl, Target.n),
                        _field('Suku Ke-n (Un)', _unCtrl, Target.un),
                        _field('Jumlah (Sn)', _snCtrl, Target.sn),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: _hitung,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 5, 231, 43),
                          border: Border.all(color: Colors.black, width: 3),
                          boxShadow: const [BoxShadow(color: Colors.black54, offset: Offset(4, 4))],
                        ),
                        child: const Center(
                          child: Text('HITUNG',
                              style: TextStyle(fontFamily: 'PressStart2P', fontSize: 12, color: Colors.white)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: InkWell(
                      onTap: _reset,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 245, 10, 10),
                          border: Border.all(color: Colors.black, width: 3),
                          boxShadow: const [BoxShadow(color: Colors.black54, offset: Offset(4, 4))],
                        ),
                        child: const Center(
                          child: Text('RESET',
                              style: TextStyle(fontFamily: 'PressStart2P', fontSize: 12, color: Colors.white)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    color: Colors.white,
                  ),
                  child: ListView(
                    children: [
                      const Text('Hasil :', style: TextStyle(fontFamily: 'PressStart2P', fontSize: 14)),
                      const SizedBox(height: 8),
                      Text(_message, style: const TextStyle(fontFamily: 'PressStart2P', fontSize: 12)),
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
    _aCtrl.dispose();
    _bCtrl.dispose();
    _nCtrl.dispose();
    _unCtrl.dispose();
    _snCtrl.dispose();
    super.dispose();
  }
}
