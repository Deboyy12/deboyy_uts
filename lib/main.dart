import 'package:deboyy_tugas1/Music_Deboyy.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:deboyy_tugas1/splash_screen.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(), 
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'Home',
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
                color: Colors.greenAccent, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      backgroundColor: Colors.black, // Latar belakang hitam
      endDrawer: Drawer(
  child: Container(
    color: Colors.black,  // Menambahkan warna hitam pada seluruh konten drawer
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        UserAccountsDrawerHeader(
          accountName: const Text(
            'Deboyy',
            style: TextStyle(color: Colors.white),
          ),
          accountEmail: const Text(
            'hidayatmisbah497@gmail.com',
            style: TextStyle(color: Colors.white),
          ),
          currentAccountPicture: CircleAvatar(
            child: ClipOval(
              child: Image.asset(
                'assets/dede.jpg',
                fit: BoxFit.cover,
                width: 90,
                height: 90,
              ),
            ),
          ),
          decoration: const BoxDecoration(
              color: Colors.cyan,
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'https://e0.pxfuel.com/wallpapers/44/969/desktop-wallpaper-phone-wall-paper-collage-phone-darkaesthetic-collage-tumblr-collageart-tumblraestheti-edgy-estetika-gelap.jpg'))),
        ),
        ListTile(
          leading: const Icon(FontAwesomeIcons.houseUser),
          title: const Text(
            'Home',
            style: TextStyle(color: Colors.white),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(FontAwesomeIcons.music, color: Colors.greenAccent,),
          title: const Text('Deboyy Musik', style: TextStyle(color: Colors.white)),
          onTap: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeft,
                child: const musicdeboyy(),
              ),
            );
          },
        ),
        ListTile(
          leading: const Icon(FontAwesomeIcons.whatsapp, color: Colors.greenAccent),
          title: const Text(
            'Whatsapp',
            style: TextStyle(color: Colors.white),
          ),
          onTap: () async {
            const whatsappUrl =
                "https://wa.me/6285244086546"; 
            await _launchURL(whatsappUrl);
          },
        ),
        ListTile(
          leading: const Icon(FontAwesomeIcons.instagram, color: Colors.pinkAccent),
          title: const Text('Instagram', style: TextStyle(color: Colors.white)),
          onTap: () async {
            const instagramUrl =
                "https://instagram.com/_.deboyy_"; 
            await _launchURL(instagramUrl);
          },
        ),
        ListTile(
  leading: const Icon(FontAwesomeIcons.github),
  title: const Text('GitHub', style: TextStyle(color: Colors.white)),
  onTap: () async {
    const githubUrl = "https://github.com/Deboyy12"; 
    await _launchURL(githubUrl);
  },
),
        const Divider(color: Colors.white), 
        ListTile(
          leading: const Icon(FontAwesomeIcons.rightFromBracket, color: Colors.redAccent),
          title: const Text('Logout', style: TextStyle(color: Colors.redAccent)),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Logout'),
                content: const Text('Apakah Anda yakin ingin keluar?'),
                actions: [
                  TextButton(
                    child: const Text('Batal'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  TextButton(
                    child: const Text('Keluar',
                        style: TextStyle(color: Colors.red)),
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ],
    ),
  ),
),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 200,
              color: const Color.fromARGB(255, 0, 0, 0),
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.greenAccent,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        'assets/apklogo.png', 
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 0),
                  Text(
                    "Misbah Hidayat",
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText(
                        "Selamat Datang di | Deboyy APK",
                        textStyle: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                        speed: const Duration(milliseconds: 100),
                      ),
                    ],
                    repeatForever: true,
                  ),
                  const SizedBox(height: 20),
            Container(
              height: 90,
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1D24),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text(
                    "Tentang Saya",
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 1,), 
                  Text(
                    "Saya adalah seorang mahasiswa jurusan Teknik Informatika yang sedang menempuh pendidikan di ITB Stikom Ambon.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "My Services",
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ServiceCard(
                        title: "Web Programming",
                        icon: FontAwesomeIcons.laptopCode,
                      ),
                      ServiceCard(
                        title: "Mobile Programming",
                        icon: FontAwesomeIcons.palette,
                      ),
                      ServiceCard(
                        title: "UI/UX Designer",
                        icon: FontAwesomeIcons.globe,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const ServiceCard({required this.title, required this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 120,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1D24),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.greenAccent,
            size: 40,
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: GoogleFonts.montserrat(
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
