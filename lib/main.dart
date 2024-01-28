import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:audioplayers_platform_interface/audioplayers_platform_interface.dart';
import 'package:audioplayers_web/audioplayers_web.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your Daily Yumi',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Your Daily Yumi   : )'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<void> _fetchData;
  late String caption = '';
  late String imageUrl = '';
  late String lastUpdate = '';
  late bool isLocked = false;

  String get url => "https://ydy.dynapaw.eu/audio/meow.mp3";

  @override
  void initState() {
    super.initState();
    _fetchData = _authenticate(); // Start fetching data when the widget initializes
  }

  void _openOffline() async {
    const websiteUrl = 'https://dynapaw.eu/server-offline'; // Replace with your website URL
    if (await canLaunchUrlString(websiteUrl)) {
      await launchUrlString(websiteUrl);
      print('I did launch $websiteUrl');
    } else {
      print('Could not launch $websiteUrl');
    }
  }

  Future<void> _authenticate() async {
    try {
      // Replace 'YOUR_API_KEY' with your actual API key
      String apiKey = '0rQNmflbDVhBA5LZ3iybpFUHU13Pi2HR';

      // Create the URL for your API call
      String url = 'https://api.dynapaw.eu/api/database/rows/table/991/?user_field_names=true';

      // Make the API call using http package
      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'Token $apiKey'},
      );

      if (response.statusCode == 200) {
        final dynamic json = jsonDecode(response.body);
        final List<dynamic> results = json['results'];

        if (results.isNotEmpty) {
          final result = results[0]; // Use the first result for demo purposes
          setState(() {
            caption = result['caption'];
            imageUrl = result['image_url'];
            lastUpdate = result['last_update'];
            isLocked = result['islocked'];
          });
        }
      } else {
        print('API call failed with status code: ${response.statusCode}');
        _openOffline();
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }

  void _openWebsite() async {
    const websiteUrl = 'https://dynapaw.eu/your-daily-yumi/'; // Replace with your website URL
    if (await canLaunchUrlString(websiteUrl)) {
      await launchUrlString(websiteUrl);
      print('I did launch $websiteUrl');
    } else {
      print('Could not launch $websiteUrl');
    }
  }

  void _openWebsite2() async {
    const websiteUrl = 'https://t.me/yourdailyumi'; // Replace with your website URL
    if (await canLaunchUrlString(websiteUrl)) {
      await launchUrlString(websiteUrl);
      print('I did launch $websiteUrl');
    } else {
      print('Could not launch $websiteUrl');
    }
  }

  void _openWebsite3() async {
    const websiteUrl = 'https://dynapaw.eu/privacy-policy-2/'; // Replace with your website URL
    if (await canLaunchUrlString(websiteUrl)) {
      await launchUrlString(websiteUrl);
      print('I did launch $websiteUrl');
    } else {
      print('Could not launch $websiteUrl');
    }
  }


  play() async {
    const websiteUrl = 'https://ydy.dynapaw.eu/audio/meow.mp3'; // Replace with your website URL
    if (await canLaunchUrlString(websiteUrl)) {
      await launchUrlString(websiteUrl);
      print('I did launch $websiteUrl');
    } else {
      print('Could not launch $websiteUrl');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1B230F),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title, style: TextStyle(fontWeight: FontWeight.w900, fontFamily: 'quicksand',)),
        actions: [
          IconButton(
            icon: Icon(Icons.not_started_rounded),
            onPressed: play,
            tooltip: "Play meow sound (new tab)",
            color: Color(0xFF1B230F),
          ),
          IconButton(
            icon: Icon(Icons.circle_notifications_rounded),
            onPressed: _openWebsite2,
            tooltip: "Get notified (telegram)",
            color: Color(0xFF1B230F),
          ),
          IconButton(
            icon: Icon(Icons.info_rounded),
            onPressed: _openWebsite,
            tooltip: "More information about this",
            color: Color(0xFF1B230F),
          ),
          IconButton(
            icon: Icon(Icons.flag_circle_rounded),
            onPressed: _openWebsite3,
            tooltip: "Privacy policy",
            color: Color(0xFF1B230F),
          ),
        ],
      ),
      body: SingleChildScrollView( // Wrap the Column in a SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'With "Your Daily Yumi", you can look at a new picture of my cat Yumi every day! :) Do not forget to check out the links in the upper right corner ;]',
                  style: TextStyle(fontSize: 20, color: Color(0xFFD1EFAA), fontFamily: 'quicksand',),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                FutureBuilder<void>(
                  future: _fetchData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Display a loader while waiting for the API response
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      // Display an error message if there's an error
                      return Text('Error loading data');
                    } else {
                      // Display the fetched data
                      if (isLocked == true) {
                        return Column(
                          children: [
                            const SizedBox(height: 40),
                            Text(
                              "Currently changing, please reload in a moment!",
                              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.redAccent,fontFamily: 'quicksand',),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "Please wait while we're changing this content. Try to reload in a few moments.",
                              style: TextStyle(fontSize: 30, color: Colors.white, fontFamily: 'quicksand',),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            Text(
                              lastUpdate,
                              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.lightGreenAccent, fontFamily: 'quicksand',),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              caption,
                              style: TextStyle(fontSize: 30, color: Colors.white, fontFamily: 'quicksand',),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                imageUrl,
                                width: 700,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'v1.1.0 - Copyright © 2023-2024 Dynapaw',
                              style: TextStyle(fontSize: 15, color: Color(0xFFD1EFAA), fontFamily: 'quicksand',),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
