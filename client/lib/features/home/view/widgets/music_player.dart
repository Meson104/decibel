import 'package:client/core/providers/current_song_notifier.dart';
import 'package:client/core/theme/app_palette.dart';
import 'package:client/core/utils.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MusicPlayer extends ConsumerWidget {
  const MusicPlayer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSong = ref.watch(currentSongNotifierProvider);
    final songNotifier = ref.read(currentSongNotifierProvider.notifier);
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            HexToColor(currentSong!.hexColor),
            const Color(0xff121212),
          ])),
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Scaffold(
        backgroundColor: Pallete.transparentColor,
        appBar: AppBar(
          backgroundColor: Pallete.transparentColor,
          leading: Transform.translate(
            offset: const Offset(-15, 0),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  'assets/images/pull-down-arrow.png',
                  color: Pallete.whiteColor,
                ),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Hero(
                  tag: 'song-thumbnail',
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          currentSong!.thumbnail_url,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 230,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currentSong.song_name,
                              maxLines: 1,
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 24,
                                color: Pallete.whiteColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              currentSong.artist,
                              maxLines: 1,
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 16,
                                color: Pallete.subtitleText,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(child: const SizedBox()),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            CupertinoIcons.heart,
                            color: Pallete.whiteColor,
                          ))
                    ],
                  ),
                  const SizedBox(height: 15),
                  StreamBuilder(
                      stream: songNotifier.audioPlayer!.positionStream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const SizedBox();
                        }
                        final position = snapshot.data;
                        final duration = songNotifier.audioPlayer!.duration;
                        double sliderValue = 0.0;
                        if (position != null && duration != null) {
                          sliderValue =
                              position.inMilliseconds / duration.inMilliseconds;
                        }
                        return Column(
                          children: [
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                activeTrackColor: Pallete.whiteColor,
                                inactiveTrackColor:
                                    Pallete.whiteColor.withOpacity(0.117),
                                thumbColor: Pallete.whiteColor,
                                trackHeight: 4,
                                overlayShape: SliderComponentShape.noOverlay,
                              ),
                              child: Slider(
                                value: sliderValue,
                                min: 0,
                                max: 1,
                                onChanged: (value) {
                                  sliderValue = value;
                                },
                                onChangeEnd: songNotifier.seek,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  '${position?.inMinutes} : ${(position?.inSeconds ?? 0) < 10 ? '0${position?.inSeconds}' : '${position?.inSeconds}'}',
                                  style: const TextStyle(
                                    color: Pallete.subtitleText,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                const Expanded(child: SizedBox()),
                                Text(
                                  '${duration?.inMinutes} : ${(duration?.inSeconds ?? 0) < 10 ? '0${duration?.inSeconds}' : '${duration?.inSeconds}'}',
                                  style: const TextStyle(
                                    color: Pallete.subtitleText,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w300,
                                  ),
                                )
                              ],
                            ),
                          ],
                        );
                      }),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Image.asset(
                          'assets/images/shuffle.png',
                          color: Pallete.whiteColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Image.asset(
                          'assets/images/previous-song.png',
                          color: Pallete.whiteColor,
                        ),
                      ),
                      IconButton(
                        onPressed: songNotifier.playPause,
                        iconSize: 80,
                        icon: songNotifier.isPlaying
                            ? Icon(
                                CupertinoIcons.pause_circle_fill,
                                color: Pallete.whiteColor,
                              )
                            : Icon(
                                CupertinoIcons.play_circle_fill,
                                color: Pallete.whiteColor,
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Image.asset(
                          'assets/images/next-song.png',
                          color: Pallete.whiteColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Image.asset(
                          'assets/images/repeat.png',
                          color: Pallete.whiteColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Image.asset(
                          'assets/images/connect-device.png',
                          color: Pallete.whiteColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Image.asset(
                          'assets/images/playlist.png',
                          color: Pallete.whiteColor,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
