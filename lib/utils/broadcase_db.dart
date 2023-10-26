import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'messages_model.dart';

class UserDatabaseProvider with ChangeNotifier {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "bc_messge.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE messages (
            id TEXT PRIMARY KEY,
            name TEXT,
            message TEXT,
            date DATETIME  ,
            sender TEXT,
            level INT,
            view BOOLEAN DEFAULT 0
          )
        ''');
    });
  }

  Future<void> addMessage(Messages msg) async {
    final db = await database;
    await db.insert('messages', msg.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    notifyListeners();
  }
}
