
import 'package:flutter/material.dart';
import 'package:pexels_project/widget/player.dart';
// import 'package:share_plus/share_plus.dart';

import '../model/video_model.dart';

class VideoDetails extends StatefulWidget {
  final String videoUri;
  final List<VideoPicture> videoPic;
  final User user;
  const VideoDetails({super.key, required this.videoUri, required this.videoPic, required this.user});

  @override
  State<VideoDetails> createState() => _VideoDetailsState();
}

class _VideoDetailsState extends State<VideoDetails> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Video detail"),
        backgroundColor: Colors.green.shade300,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 300,
                decoration: const BoxDecoration(color: Colors.grey),
                child: MyPlayer(videoLink: widget.videoUri),
              ),

              const SizedBox(height: 10),
              const Text('Images of video', style: TextStyle(fontWeight: FontWeight.bold),),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: widget.videoPic.map((e){
                    return Container(margin: const EdgeInsets.only(right: 10),child: Image(image: NetworkImage(e.picture)));
                  }).toList(),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(color: Colors.grey),
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('User details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    Text("Creator : ${widget.user.name}"),
                    Text("Id : ${widget.user.id}"),
                    Row(
                      children: [
                        const Text("Profile :"),
                        TextButton(onPressed: () {
                          // Share.shareUri(Uri.parse(widget.user.url));
                        }, child: const Text('Link')),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
