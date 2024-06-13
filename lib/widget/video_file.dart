import 'package:flutter/material.dart';
import 'package:pexels_project/widget/player.dart';

import '../model/video_model.dart';
import '../screens/video_details.dart';

class VideoRow extends StatefulWidget {
  final List<Video> videoFile;
  const VideoRow({super.key, required this.videoFile});

  @override
  State<VideoRow> createState() => _VideoRowState();
}

class _VideoRowState extends State<VideoRow> {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.videoFile.length,
      itemBuilder: (context, index) {

        var videoFile = widget.videoFile[index].videoFiles;
        var userData = widget.videoFile[index].user;
        var videoPic = widget.videoFile[index].videoPictures;

        return Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userData.name, style: const TextStyle(fontWeight: FontWeight.bold),),
              const SizedBox(height: 8),
              SizedBox(
                height: 150,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: videoFile.length,
                  itemBuilder: (context, index) {
                    var videos = videoFile[index];
                    // video player
                    return InkWell(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => VideoDetails(videoUri: videos.link, videoPic: videoPic, user: userData,),)),
                        child: MyPlayer(videoLink: videos.link)
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(width: 30,),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
