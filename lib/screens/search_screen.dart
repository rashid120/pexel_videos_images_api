import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pexels_project/model/video_model.dart';
import 'package:pexels_project/widget/video_file.dart';

class SearchScreen extends StatefulWidget {
   const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _searchQuery = '';


  Future<PixelVideoModel> fetchVideos(String searchQuery) async{
    String apiKey = '0qnbFPoX3fASDQsBu6Ofp9SDUAOlgpfFIftLRQueFJtTk0V5w0gh5DtW';
    var baseUrl = 'https://api.pexels.com/videos/';
    String endPoint = _searchQuery;

    http.Response response = await http.get(Uri.parse('${baseUrl}search?query=$endPoint'),headers: {
      'Authorization' : apiKey,
    });

    if(response.statusCode == 200) {
      var data = jsonDecode(response.body) as Map<String, dynamic>;
      PixelVideoModel videoModel = PixelVideoModel.fromJson(data);
      return videoModel;
    }else{
      return PixelVideoModel(page: 1, perPage: 1, videos: [], totalResults: 2, nextPage: '', url: '',);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pixel Videos'),
        backgroundColor: Colors.green.shade300,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Search',
                hintText: 'Enter video title or keyword',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {},
                ),
              ),
            ),
          ),
          Expanded(
            child: _searchQuery.isEmpty
                ? const Center(child: Text('Search for videos above'))
                : FutureBuilder<PixelVideoModel>(
              future: fetchVideos(_searchQuery),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {

                  PixelVideoModel data = snapshot.data;

                  return VideoRow(videoFile: data.videos);
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
