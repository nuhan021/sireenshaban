import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String audioUrl;
  final bool isCurrentUser;
  final VoidCallback? onPlayStart;
  final VoidCallback? onPlayEnd;

  const AudioPlayerWidget({
    super.key,
    required this.audioUrl,
    required this.isCurrentUser,
    this.onPlayStart,
    this.onPlayEnd,
  });

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  late AudioPlayer _audioPlayer;
  RxBool isPlaying = false.obs;
  RxDouble playbackPosition = 0.0.obs;
  RxDouble duration = 0.0.obs;
  RxBool isLoading = false.obs;
  RxString? errorMessage;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _setupAudioPlayer();
  }

  void _setupAudioPlayer() {
    try {
      _audioPlayer.positionStream.listen((position) {
        playbackPosition.value = position.inSeconds.toDouble();
      });

      _audioPlayer.durationStream.listen((dur) {
        if (dur != null) {
          duration.value = dur.inSeconds.toDouble();
        }
      });

      _audioPlayer.playerStateStream.listen((state) {
        isPlaying.value = state.playing;
        if (state.processingState == ProcessingState.completed) {
          isPlaying.value = false;
          playbackPosition.value = 0.0;
          widget.onPlayEnd?.call();
        }
      });
    } catch (e) {
      debugPrint('❌ [AudioPlayer] Error setting up streams: $e');
    }
  }

  Future<void> _playAudio() async {
    try {
      if (isPlaying.value) {
        await _audioPlayer.pause();
        return;
      }

      // Try to load the audio if not already loaded
      if (_audioPlayer.audioSource == null) {
        isLoading.value = true;
        debugPrint('📻 [AudioPlayer] Loading audio from: ${widget.audioUrl}');
        debugPrint(
          '📻 [AudioPlayer] URL is valid: ${widget.audioUrl.isNotEmpty}',
        );
        debugPrint(
          '📻 [AudioPlayer] URL starts with http: ${widget.audioUrl.startsWith('http')}',
        );

        try {
          await _audioPlayer.setUrl(widget.audioUrl);
          isLoading.value = false;
          debugPrint('✅ [AudioPlayer] Audio loaded successfully');
        } catch (loadError) {
          isLoading.value = false;
          debugPrint('❌ [AudioPlayer] Error loading audio: $loadError');
          debugPrint('   Error details: ${loadError.toString()}');

          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to load audio: ${loadError.toString()}'),
                duration: const Duration(seconds: 3),
              ),
            );
          }
          return;
        }
      }

      widget.onPlayStart?.call();
      await _audioPlayer.play();
      debugPrint('▶️ [AudioPlayer] Playing audio');
    } catch (e) {
      debugPrint('❌ [AudioPlayer] Error playing audio: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error playing audio: $e'),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  String _formatDuration(double seconds) {
    if (seconds.isNaN || seconds.isInfinite) {
      return '0:00';
    }

    final duration = Duration(seconds: seconds.toInt());
    final minutes = duration.inMinutes;
    final secs = duration.inSeconds % 60;
    return '$minutes:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: isLoading.value ? null : _playAudio,
                child: Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    color: widget.isCurrentUser
                        ? Colors.white.withOpacity(0.3)
                        : Colors.grey.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: isLoading.value
                      ? SizedBox(
                          width: 18.sp,
                          height: 18.sp,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              widget.isCurrentUser
                                  ? Colors.white
                                  : Colors.black87,
                            ),
                          ),
                        )
                      : Icon(
                          isPlaying.value ? Icons.pause : Icons.play_arrow,
                          color: widget.isCurrentUser
                              ? Colors.white
                              : Colors.black87,
                          size: 18.sp,
                        ),
                ),
              ),
              SizedBox(width: 8.w),
              Flexible(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4.r),
                  child: LinearProgressIndicator(
                    minHeight: 3.h,
                    value: duration.value > 0
                        ? (playbackPosition.value / duration.value).clamp(
                            0.0,
                            1.0,
                          )
                        : 0.0,
                    backgroundColor: widget.isCurrentUser
                        ? Colors.white24
                        : Colors.grey[400],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      widget.isCurrentUser ? Colors.white : Colors.blue,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                _formatDuration(duration.value),
                style: getTextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w400,
                  color: widget.isCurrentUser ? Colors.white70 : Colors.black54,
                ),
              ),
            ],
          ),
        ],
      );
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
