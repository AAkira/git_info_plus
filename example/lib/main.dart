import 'dart:async';

import 'package:flutter/material.dart';
import 'package:git_info_plus/git_info_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _branchName = 'Unknown';
  DateTime? _lastCommitDate;
  String _lastCommitHash = 'Unknown';
  String _lastCommitHashShort = 'Unknown';
  String _lastCommitMessage = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String branchName;
    DateTime? lastCommitDate;
    String lastCommitHash;
    String lastCommitHashShort;
    String lastCommitMessage;

    try {
      branchName = await GitInfo.branchName ?? 'Unknown';
    } catch (_) {
      branchName = 'Error';
    }
    try {
      lastCommitDate = await GitInfo.lastCommitDate;
    } catch (_) {
      // noop
    }
    try {
      lastCommitHash = await GitInfo.lastCommitHash ?? 'Unknown';
    } catch (_) {
      lastCommitHash = 'Error';
    }
    try {
      lastCommitHashShort = await GitInfo.lastCommitHashShort ?? 'Unknown';
    } catch (_) {
      lastCommitHashShort = 'Error';
    }
    try {
      lastCommitMessage = await GitInfo.lastCommitMessage ?? 'Unknown';
    } catch (_) {
      lastCommitMessage = 'Error';
    }

    if (!mounted) return;

    setState(() {
      _branchName = branchName;
      _lastCommitDate = lastCommitDate;
      _lastCommitHash = lastCommitHash;
      _lastCommitHashShort = lastCommitHashShort;
      _lastCommitMessage = lastCommitMessage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('git_info plugin example'),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListTile(
                title: const Text('Branch name'),
                subtitle: Text(_branchName),
                tileColor: Colors.white,
              ),
              const Divider(height: 1),
              ListTile(
                title: const Text('Last commit date'),
                subtitle: Text(_lastCommitDate?.toString() ?? 'Unknown'),
                tileColor: Colors.white,
              ),
              const Divider(height: 1),
              ListTile(
                title: const Text('Last commit hash'),
                subtitle: Text(_lastCommitHash),
                tileColor: Colors.white,
              ),
              const Divider(height: 1),
              ListTile(
                title: const Text('Last commit hash short'),
                subtitle: Text(_lastCommitHashShort),
                tileColor: Colors.white,
              ),
              const Divider(height: 1),
              ListTile(
                title: const Text('Last commit message'),
                subtitle: Text(_lastCommitMessage),
                tileColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
