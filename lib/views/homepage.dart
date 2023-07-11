import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

import 'ResultPage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final recorder = FlutterSoundRecorder();
  final player = FlutterSoundPlayer();
  late String _filePath; // File path for the recorded audio

  @override
  void initState() {
    super.initState();
    initRecorder();
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    player.closePlayer(); // Close the audio session when disposing
    super.dispose();
  }

  Future initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw 'Permission not granted';
    }
    await recorder.openRecorder();
    recorder.setSubscriptionDuration(const Duration(milliseconds: 500)); // Sets the frequency at which duration updates are sent to duration listeners.
    final defaultButtonColor = ThemeData().elevatedButtonTheme.style?.backgroundColor;

    print(defaultButtonColor);
  }

  Future startRecord() async {
    final fileName = 'audio_${DateTime.now().microsecondsSinceEpoch}.wav';
    _filePath = '/sdcard/Download/$fileName';

    // final appDir = await getApplicationDocumentsDirectory();
    // final fileName = 'audio_${DateTime.now().microsecondsSinceEpoch}.wav';
    // _filePath = '${appDir.path}/$fileName';

    await recorder.startRecorder(toFile: _filePath, codec: Codec.pcm16WAV);
  }

  Future stopRecorder() async {
    await recorder.stopRecorder();
    print('Recorded file path: $_filePath');
    await sendAudioToServer(File(_filePath));
  }

  Future<void> sendAudioToServer(File audioFile) async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        });
    final audioData = await audioFile.readAsBytes();

    final response = await http.post(
      Uri.parse('http://192.1.150.116:8080/speech-to-text/transcribe'),
      body: audioData,
      headers: {'Content-Type': 'application/octet-stream'},
    );
    Navigator.of(context).pop();
    if (response.statusCode == 200) {
      print(response.body);
      final decodedData = jsonDecode(response.body) as Map<String, dynamic>;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultPage(jsonData: decodedData),
        ),
      );
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade700,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<RecordingDisposition>(
              builder: (context, snapshot) {
                final duration =
                    snapshot.hasData ? snapshot.data!.duration : Duration.zero;

                String twoDigits(int n) => n.toString().padLeft(2, '0');

                final twoDigitMinutes =
                    twoDigits(duration.inMinutes.remainder(60));
                final twoDigitSeconds =
                    twoDigits(duration.inSeconds.remainder(60));

                return Text(
                  '$twoDigitMinutes:$twoDigitSeconds',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
              stream: recorder.onProgress,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (recorder.isRecording) {
                  await stopRecorder();
                } else {
                  await startRecord();
                }
                setState(() {});
              },
              child: Icon(
                recorder.isRecording ? Icons.stop : Icons.mic,
                size: 100,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await player.openPlayer();
                await player.startPlayer(fromURI: _filePath);
              },
              child: Icon(
                Icons.play_arrow,
                size: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
