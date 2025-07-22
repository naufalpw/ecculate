import 'package:flutter/material.dart';

enum TargetPN {
  none, y, yd, m, mo, tr, t, tpajak, io, i, p
}

class PendapatanNasionalPage extends StatefulWidget {
  const PendapatanNasionalPage({super.key});

  @override
  State<PendapatanNasionalPage> createState() => _PendapatanNasionalPageState();
}

class _PendapatanNasionalPageState extends State<PendapatanNasionalPage> {
  final cController = TextEditingController();
  final iController = TextEditingController();
  final gController = TextEditingController();
  final xController = TextEditingController();
  final mController = TextEditingController();
  final moController = TextEditingController();
  final tController = TextEditingController();
  final toController = TextEditingController();
  final txController = TextEditingController();
  final trController = TextEditingController();
  final yController = TextEditingController();
  final ydController = TextEditingController();
  final tPajakController = TextEditingController();
  final ioController = TextEditingController();
  final iBungaController = TextEditingController();
  final pController = TextEditingController();
  final mMarginalController = TextEditingController();
  final aController = TextEditingController();
  final bController = TextEditingController();

  TargetPN _target = TargetPN.none;
  String _result = '';

  void _reset() {
    for (var ctrl in [
      cController, iController, gController, xController, mController,
      moController, tController, toController, txController, trController,
      yController, ydController, tPajakController, ioController,
      iBungaController, pController, mMarginalController, aController, bController
    ]) {
      ctrl.clear();
    }
    setState(() {
      _target = TargetPN.none;
      _result = '';
    });
  }

  @override
  void dispose() {
    for (var ctrl in [
      cController, iController, gController, xController, mController,
      moController, tController, toController, txController, trController,
      yController, ydController, tPajakController, ioController,
      iBungaController, pController, mMarginalController, aController, bController
    ]) {
      ctrl.dispose();
    }
    super.dispose();
  }

  void _hitung() {
    try {
      double? c = double.tryParse(cController.text);
      double? i = double.tryParse(iController.text);
      double? g = double.tryParse(gController.text);
      double? x = double.tryParse(xController.text);
      double? mo = double.tryParse(moController.text);
      double? to = double.tryParse(toController.text);
      double? a = double.tryParse(aController.text);
      double? b = double.tryParse(bController.text);
      double? mMarginal = double.tryParse(mMarginalController.text);
      double? tPajak = double.tryParse(tPajakController.text);
      double? m = double.tryParse(mController.text);
      double? t = double.tryParse(tController.text);
      double? tx = double.tryParse(txController.text);
      double? tr = double.tryParse(trController.text);
      double? y = double.tryParse(yController.text);
      double? yd = double.tryParse(ydController.text);
      double? io = double.tryParse(ioController.text);
      double? iBunga = double.tryParse(iBungaController.text);
      if (iBunga != null) iBunga = iBunga / 100;
      double? p = double.tryParse(pController.text);

      switch (_target) {
        case TargetPN.y:
          if (a != null && b != null && i != null && g != null && x != null && m != null) {
            double penyebut = 1 - b;
            if (penyebut == 0) throw 'Penyebut = 0, tidak bisa menghitung Y';
            double pembilang = a + i + g + x - m;
            y = pembilang / penyebut;
            _result = 'Hasil = Y = ${y.toStringAsFixed(2)}';
          } else if (c != null && i != null && g != null && x != null && m != null) {
            y = c + i + g + (x - m);
            _result = 'Hasil = Y = ${y.toStringAsFixed(2)}';
          } else {
            throw 'Masukkan a dan b (atau C), serta I, G, X, M';
          }
          break;

        case TargetPN.yd:
          if (y == null || tr == null || tx == null) {
            throw 'Masukkan Y, Tr, dan Tx';
          }
          yd = y - tx + tr;
          _result = 'Hasil = Yd = ${yd.toStringAsFixed(2)}';
          break;

        case TargetPN.m:
          if (mo == null || mMarginal == null || y == null) {
            throw 'Masukkan Mo, m, dan Y';
          }
          m = mo + (mMarginal * y);
          _result = 'Hasil = M = ${m.toStringAsFixed(2)}';
          break;

        case TargetPN.mo:
          if (m == null || mMarginal == null || y == null) {
            throw 'Masukkan M, m, dan Y';
          }
          mo = m - (mMarginal * y);
          _result = 'Hasil = Mo = ${mo.toStringAsFixed(2)}';
          break;

        case TargetPN.tr:
          if (yd == null || y == null || tx == null) {
            throw 'Masukkan Yd, Y, dan Tx';
          }
          tr = yd - y + tx;
          _result = 'Hasil = Tr = ${tr.toStringAsFixed(2)}';
          break;

        case TargetPN.t:
          if (to == null || tPajak == null || y == null) {
            throw 'Masukkan To, t, dan Y';
          }
          t = to + tPajak * y;
          _result = 'Hasil = T = ${t.toStringAsFixed(2)}';
          break;

        case TargetPN.tpajak:
          if (t == null || to == null || y == null || y == 0) {
            throw 'Masukkan T, To, dan Y (Y ≠ 0)';
          }
          tPajak = (t - to) / y;
          _result = 'Hasil = t = ${tPajak.toStringAsFixed(2)}';
          break;

        case TargetPN.io:
          if (i == null || p == null || iBunga == null) {
            throw 'Masukkan I, p, dan i';
          }
          io = i + (p * iBunga);
          _result = 'Hasil = Io = ${io.toStringAsFixed(2)}';
          break;

        case TargetPN.i:
          if (io == null || p == null || iBunga == null) {
            throw 'Masukkan Io, p, dan i';
          }
          i = io - (p * iBunga);
          _result = 'Hasil = I = ${i.toStringAsFixed(2)}';
          break;

        case TargetPN.p:
          if (io == null || i == null || iBunga == null || iBunga == 0) {
            throw 'Masukkan Io, I, dan i (dalam %) dan pastikan i ≠ 0';
          }
          p = (io - i) / iBunga;
          _result = 'Hasil = p = ${p.toStringAsFixed(2)}';
          break;


        case TargetPN.none:
          throw 'Pilih variabel yang ingin dihitung';
      }

      setState(() {});
    } catch (e) {
      setState(() {
        _result = 'Error: $e';
      });
    }
  }

  Widget _inputField(String label, TextEditingController ctrl, List<TargetPN> targets) {
    if (_target == TargetPN.none) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: TextField(
          controller: ctrl,
          enabled: false,
          style: const TextStyle(fontFamily: 'PressStart2P', fontSize: 12),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(fontFamily: 'PressStart2P', fontSize: 10),
            border: const OutlineInputBorder(),
            filled: true,
            fillColor: Colors.grey.shade300,
          ),
        ),
      );
    }

    if ((_target == TargetPN.mo && label.startsWith('Mo')) ||
        (_target == TargetPN.tr && label.startsWith('Tr'))) {
      return const SizedBox.shrink();
    }

    if (!targets.contains(_target)) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: ctrl,
        keyboardType: TextInputType.number,
        style: const TextStyle(fontFamily: 'PressStart2P', fontSize: 12),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontFamily: 'PressStart2P', fontSize: 10),
          border: const OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2.0),
            ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

Widget _targetButton(String label, TargetPN target) => Container(
  width: 60,
  margin: const EdgeInsets.symmetric(vertical: 6),
  decoration: BoxDecoration(
    color: _target == target
        ? const Color.fromARGB(255, 28, 253, 21)
        : const Color.fromARGB(255, 94, 91, 91),
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
          _target = target;
          _result = '';
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



  @override
  Widget build(BuildContext context) {
    final targets1 = {
      'Y': TargetPN.y,
      'Yd': TargetPN.yd,
      'M': TargetPN.m,
      'Mo': TargetPN.mo,
      'Tr': TargetPN.tr,
    };
    final targets2 = {
      'T': TargetPN.t,
      't': TargetPN.tpajak,
      'Io': TargetPN.io,
      'I': TargetPN.i,
      'p': TargetPN.p,
    };

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white), // Ubah warna ikon back
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text('PENDAPATAN NASIONAL',
            style: TextStyle(fontFamily: 'PressStart2P', fontSize: 14, color: Colors.white)),
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
                    'PENDAPATAN NASIONAL',
                    style: TextStyle(
                      fontFamily: 'PressStart2P',
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
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
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 10,
              runSpacing: 10,
              children: [
                ...targets1.entries.map((e) => _targetButton(e.key, e.value)),
                ...targets2.entries.map((e) => _targetButton(e.key, e.value)),
              ],
            ),
            const SizedBox(height: 24),
            _inputField('a (Konsumsi Otonom)', aController, [TargetPN.y]),
            _inputField('b (MPC)', bController, [TargetPN.y]),
            _inputField('C (Konsumsi)', cController, [TargetPN.y]),
            _inputField('I (Investasi)', iController, [TargetPN.y, TargetPN.io, TargetPN.p]),
            _inputField('G (Pemerintah)', gController, [TargetPN.y]),
            _inputField('X (Ekspor)', xController, [TargetPN.y]),
            _inputField('M (Impor)', mController, [TargetPN.y, TargetPN.mo]),
            _inputField('Mo (Impor Otonom)', moController, [TargetPN.m]),
            _inputField('T (Pajak)', tController, [TargetPN.tpajak]),
            _inputField('To (Pajak Otonom)', toController, [TargetPN.t, TargetPN.tpajak]),
            _inputField('Tx (Pajak)', txController, [TargetPN.yd, TargetPN.tr]),
            _inputField('Tr (Transfer)', trController, [TargetPN.yd]),
            _inputField('Y (Pendapatan Nasional)', yController, [
              TargetPN.yd, TargetPN.m, TargetPN.mo, TargetPN.t, TargetPN.tpajak, TargetPN.tr
            ]),
            _inputField('Yd (Disposibel)', ydController, [TargetPN.tr]),
            _inputField('t (Proporsi Pajak)', tPajakController, [TargetPN.t]),
            _inputField('Io (Investasi Otonom)', ioController, [TargetPN.i, TargetPN.p]),
            _inputField('i (Tingkat Bunga dalam %)', iBungaController, [TargetPN.io, TargetPN.i, TargetPN.p]),
            _inputField('p (Proporsi Investasi)', pController, [TargetPN.io, TargetPN.i]),
            _inputField('m (MPM)', mMarginalController, [TargetPN.m, TargetPN.mo]),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: _hitung,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 15, 255, 7),
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
                              color: Colors.white),
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
                        color: const Color.fromARGB(255, 255, 4, 4),
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
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _result.isNotEmpty ? _result : 'Hasil : \n',
                style: const TextStyle(fontFamily: 'PressStart2P', fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
