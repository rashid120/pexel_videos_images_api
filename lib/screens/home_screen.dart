import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pexels_project/model/video_model.dart';
import 'package:pexels_project/screens/search_screen.dart';
import 'package:http/http.dart' as http;
import 'package:pexels_project/widget/video_file.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<PixelVideoModel> fetchVideo() async {
    String apiKey = '0qnbFPoX3fASDQsBu6Ofp9SDUAOlgpfFIftLRQueFJtTk0V5w0gh5DtW';
    var baseUrl = 'https://api.pexels.com/videos/';
    String endPoint = 'popular';

    http.Response response = await http.get(Uri.parse(baseUrl + endPoint), headers: {
      'Authorization': apiKey,
    });

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body) as Map<String, dynamic>;
      PixelVideoModel videoModel = PixelVideoModel.fromJson(data);
      return videoModel;
    } else {
      return PixelVideoModel(page: 1, perPage: 1, videos: [], totalResults: 2, nextPage: 'nextPage', url: 'url');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pixel videos",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchScreen()));
              },
              icon: const Icon(Icons.search))
        ],
        backgroundColor: Colors.green.shade300,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<PixelVideoModel>(
        future: fetchVideo(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            PixelVideoModel data = snapshot.data;
            // all users and user's videos
            return VideoRow(videoFile: data.videos);
          }
        },
      ),
    );
  }
}