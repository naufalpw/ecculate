import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';


import 'package:ecculate/hitungpages/FL1/fungsilinier1.dart';
import 'package:ecculate/hitungpages/FL2/fungsilinier2.dart';
import 'package:ecculate/hitungpages/IT/it.dart';
import 'package:ecculate/hitungpages/ITT/itt.dart';
import 'package:ecculate/hitungpages/derethitung/derethitung.dart';
import 'package:ecculate/hitungpages/deretukur/deretukur.dart';
import 'package:ecculate/hitungpages/derivatif/derivatif.dart';
import 'package:ecculate/pages/bantuanpage.dart';
import 'package:ecculate/pages/landingpage.dart';

void main() {
  runApp(ECculateApp());
}


// ================== Pembungkus Lifecycle ==================
class AppLifecycleWrapper extends StatefulWidget {
  @override
  State<AppLifecycleWrapper> createState() => _AppLifecycleWrapperState();
}

class _AppLifecycleWrapperState extends State<AppLifecycleWrapper> with WidgetsBindingObserver {
  DateTime? _backgroundTime;
  final Duration batas = Duration(minutes: 3);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _backgroundTime = DateTime.now();
    } else if (state == AppLifecycleState.resumed && _backgroundTime != null) {
      final selisih = DateTime.now().difference(_backgroundTime!);
      if (selisih > batas) {
        // Restart app ke halaman awal (LandingPage)
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => SplashScreen()),
          (route) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ECculateApp(); // Panggil aplikasi utama
  }
}



class ECculateApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EC-Culate',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.deepOrange,
        scaffoldBackgroundColor: Color.fromARGB(255, 209, 250, 198),
        textTheme: TextTheme(
          headlineMedium: TextStyle(
              fontFamily: 'PressStart2P',
              fontSize: 20,
              fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontFamily: 'PressStart2P', fontSize: 16),
        ),
      ),
      home: SplashScreen(),
    );
  }
}

// ----------------- Splash Screen -----------------
class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LandingPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 153, 252, 159),
      body: Center(
        child: Transform.translate(
          offset: const Offset(10, 0),
          child: Image.asset(
            'assets/images/EC-Culate-NEW.png',
            width: 400,
          ),
        ),
      ),
    );
  }
}

// ----------------- Halaman Utama -----------------
class MainPage extends StatelessWidget {
  final List<Map<String, dynamic>> materi = [
    {
      'title': 'Deret Hitung',
      'icon': Icons.format_list_numbered,
      'page': DeretHitungPage()
    },
    {
      'title': 'Deret Ukur',
      'icon': Icons.stacked_line_chart,
      'page': DeretUkurPage()
    },
    {
      'title': 'Fungsi Linier 1',
      'icon': Icons.timeline,
      'page': FungsiLinier1Page()
    },
    {
      'title': 'Fungsi Linier 2',
      'icon': Icons.trending_up,
      'page': FungsiLinier2Page()
    },
    {
      'title': 'Derivatif',
      'icon': Icons.show_chart,
      'page': DerivatifPage()
    },
    {
      'title': 'Integral Tak Tentu',
      'icon': Icons.integration_instructions,
      'page': IntegralTakTentuPage()
    },
    {
      'title': 'Integral Tertentu',
      'icon': Icons.bar_chart,
      'page': IntegralTertentuPage()
    },
    {
      'title': 'Bantuan',
      'icon': Icons.question_mark,
      'page': BantuanPage()
    },
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await _showExitDialog(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'EC-Culate',
            style: TextStyle(
                fontFamily: 'PressStart2P', fontSize: 20, color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Pilih Materimu :)',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GridView.builder(
                    itemCount: materi.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1,
                    ),
                    itemBuilder: (context, index) {
                      final item = materi[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => item['page']),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 113, 223, 103),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.black, width: 2),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(item['icon'], size: 40, color: const Color.fromARGB(255, 255, 255, 255)),
                              SizedBox(height: 10),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Stack(
                              children: [
                                  Text(
                                    item['title'],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'PressStart2P',
                                      fontSize: 12,
                                      foreground: Paint()
                                      ..style = PaintingStyle.stroke
                                      ..strokeWidth = 2
                                      ..color = Colors.black, // warna outline
                                    ),
                                  ),
                                  Text(
                                    item['title'],
                                    textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'PressStart2P',
                                    fontSize: 12,
                                  color: Colors.white, // warna isi
                                  ),
                                ),
                              ],
                              ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _showExitDialog(BuildContext context) async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Konfirmasi'),
            content: Text('Apa kamu mau keluar aplikasi?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('Ngga, deh'),
              ),
              TextButton(
                onPressed: () {
                  SystemNavigator.pop(); // keluar dari aplikasi
                },
                child: Text('Iya, Keluar'),
              ),
            ],
          ),
        )) ??
        false;
  }
}


