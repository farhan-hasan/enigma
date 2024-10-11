import 'dart:async';

import 'package:enigma/src/core/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StoryScreen extends ConsumerStatefulWidget {
  const StoryScreen({super.key});
  static const route = "/story";

  static setRoute() => "/story";

  @override
  _StoryScreenState createState() => _StoryScreenState();
}

class _StoryScreenState extends ConsumerState<StoryScreen> {
  PageController _pageController = PageController();
  int _currentStoryIndex = 0;
  List<String> _stories = [
    'https://example.com/story1.jpg',
    'https://example.com/story2.jpg',
    'https://example.com/story3.jpg',
  ];
  double _progress = 0.0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startProgress();
  }

  void _startProgress() {
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        _progress += 0.01;
      });

      if (_progress >= 1.0) {
        _goToNextStory();
      }
    });
  }

  void _goToNextStory() {
    _timer?.cancel();
    if (_currentStoryIndex < _stories.length - 1) {
      setState(() {
        _currentStoryIndex++;
        _progress = 0.0;
      });
      _pageController.nextPage(
          duration: Duration(milliseconds: 300), curve: Curves.easeIn);
      _startProgress();
    } else {
      // Story ended
      ref.read(goRouterProvider).pop(); // Close popup
    }
  }

  void _goToPreviousStory() {
    _timer?.cancel();
    if (_currentStoryIndex > 0) {
      setState(() {
        _currentStoryIndex--;
        _progress = 0.0;
      });
      _pageController.previousPage(
          duration: Duration(milliseconds: 300), curve: Curves.easeIn);
      _startProgress();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Story content
          PageView.builder(
            controller: _pageController,
            itemCount: _stories.length,
            onPageChanged: (index) {
              setState(() {
                _currentStoryIndex = index;
                _progress = 0.0;
                _startProgress();
              });
            },
            itemBuilder: (context, index) {
              return GestureDetector(
                onTapDown: (details) {
                  if (details.globalPosition.dx <
                      MediaQuery.of(context).size.width / 2) {
                    _goToPreviousStory();
                  } else {
                    _goToNextStory();
                  }
                },
                child: Image.network(
                  _stories[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              );
            },
          ),
          // Progress bar
          Positioned(
            top: 50,
            left: 10,
            right: 10,
            child: LinearProgressIndicator(
              value: _progress,
              backgroundColor: Colors.white38,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
