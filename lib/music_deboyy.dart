import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class musicdeboyy extends StatefulWidget {
  const musicdeboyy({Key? key}) : super(key: key);

  @override
  _musicdeboyyState createState() => _musicdeboyyState();
}

class _musicdeboyyState extends State<musicdeboyy> {
  final TextEditingController _searchController = TextEditingController();
  final AudioPlayer _audioPlayer = AudioPlayer();

  bool isPlaying = false;
  int currentIndex = 0;
  Duration currentPosition = Duration.zero;
  Duration songDuration = Duration.zero;

  final Map<String, List<Map<String, String>>> artistData = {
    "My Chemical Romance": [
      {"title": "Helena", "audioUrl": "assets/song/Helena.mp3"},
      {"title": "The Ghost Of You", "audioUrl": "assets/song/Theghostofyou.mp3"},
      {"title": "Disenchanted", "audioUrl": "assets/song/Disenchanted.mp3"},
    ],
    "Evanescence": [
      {"title": "Bring Me To Life", "audioUrl": "assets/song/Bringmetolife.mp3"},
      {"title": "My Immortal", "audioUrl": "assets/song/Myimmortal.mp3"},
      {"title": "Going Under", "audioUrl": "assets/song/Goingunder.mp3"},
    ],
  };

  List<Map<String, String>> currentSongList = [];
  List<Map<String, String>> filteredSongList = [];

  @override
  void initState() {
    super.initState();

    _audioPlayer.positionStream.listen((position) {
      setState(() {
        currentPosition = position;
      });
    });

    _audioPlayer.durationStream.listen((duration) {
      setState(() {
        songDuration = duration ?? Duration.zero;
      });
    });
    
    _audioPlayer.playerStateStream.listen((state) {
      setState(() {
        isPlaying = state.playing;
      });
    });

    _audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        if (currentIndex + 1 < filteredSongList.length) {
          playSong(currentIndex + 1);
        }
      }
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void playSong(int index) async {
    final song = filteredSongList[index];
    final audioUrl = song["audioUrl"]!;

    setState(() {
      currentIndex = index;
    });

    try {
      await _audioPlayer.setAsset(audioUrl);
      await _audioPlayer.play();
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  void pauseOrResumeSong() async {
    if (isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play();
    }
  }

  void filterSongs(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredSongList = currentSongList;
      } else {
        filteredSongList = currentSongList
            .where((song) =>
                song["title"]!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void showArtistSelection() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black87,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: artistData.keys.map((artist) {
              return ListTile(
                title: Text(
                  artist,
                  style: const TextStyle(color: Colors.white),
                ),
                onTap: () {
                  setState(() {
                    currentSongList = artistData[artist]!;
                    filteredSongList = currentSongList;
                  });
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'Cari lagu...',
            hintStyle: TextStyle(color: Colors.white54),
            border: InputBorder.none,
          ),
          onChanged: filterSongs,
        ),
        backgroundColor: Colors.black87,
        actions: [
          IconButton(
            icon: const Icon(Icons.library_music, color: Colors.greenAccent,),
            onPressed: showArtistSelection,
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          if (filteredSongList.isEmpty)
            const Expanded(
              child: Center(
                child: Text(
                  'Deboyy Musik',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: filteredSongList.length,
                itemBuilder: (context, index) {
                  final song = filteredSongList[index];
                  return Card(
                    color: index == currentIndex
                        ? Colors.green.withOpacity(0.2)
                        : Colors.black54,
                    child: ListTile(
                      leading: const Icon(Icons.music_note, color: Colors.white),
                      title: Text(
                        song["title"]!,
                        style: const TextStyle(color: Colors.white),
                      ),
                      onTap: () => playSong(index),
                    ),
                  );
                },
              ),
            ),
          Container(
            color: Colors.black54,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Slider(
                  value: currentPosition.inSeconds.toDouble(),
                  max: songDuration.inSeconds.toDouble(),
                  onChanged: (value) async {
                    await _audioPlayer.seek(Duration(seconds: value.toInt()));
                  },
                  activeColor: Colors.greenAccent,
                  inactiveColor: Colors.white24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${currentPosition.inMinutes}:${(currentPosition.inSeconds % 60).toString().padLeft(2, '0')}",
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      "${songDuration.inMinutes}:${(songDuration.inSeconds % 60).toString().padLeft(2, '0')}",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.skip_previous,
                          color: Colors.greenAccent),
                      onPressed: () {
                        if (currentIndex > 0) {
                          playSong(currentIndex - 1);
                        }
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        isPlaying ? Icons.pause_circle : Icons.play_circle,
                        color: Colors.greenAccent,
                        size: 48,
                      ),
                      onPressed: pauseOrResumeSong,
                    ),
                    IconButton(
                      icon: const Icon(Icons.skip_next,
                          color: Colors.greenAccent),
                      onPressed: () {
                        if (currentIndex + 1 < filteredSongList.length) {
                          playSong(currentIndex + 1);
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
