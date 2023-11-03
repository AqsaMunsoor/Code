// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper.internal();

  static Database? _database;
  Future<int> insertApiResult(String medication, String disease) async {
    Database db = await database;
    Result result = Result(
      medication: medication,
      disease: disease,
      date: DateTime.now(),
      improvement: 0.0, // You can set the improvement score as needed
    );
    return await db.insert('Results', result.toMap());
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'results.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE Results('
          'id INTEGER PRIMARY KEY AUTOINCREMENT, '
          'medication TEXT, '
          'disease TEXT, '
          'date TEXT, '
          'improvement REAL)',
        );
      },
    );
  }

  Future<int> insertResult(Result result) async {
    Database db = await database;
    return await db.insert('Results', result.toMap());
  }

  Future<List<Result>> getAllResults() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('Results');
    return List.generate(maps.length, (i) {
      return Result.fromMap(maps[i]);
    });
  }
}

class Result {
  final int? id;
  final String medication;
  final String disease;
  final DateTime date;
  final double improvement;

  Result({
    this.id,
    required this.medication,
    required this.disease,
    required this.date,
    required this.improvement,
  });

  Result copyWith({
    int? id,
    String? medication,
    String? disease,
    DateTime? date,
    double? improvement,
  }) {
    return Result(
      id: id ?? this.id,
      medication: medication ?? this.medication,
      disease: disease ?? this.disease,
      date: date ?? this.date,
      improvement: improvement ?? this.improvement,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'medication': medication,
      'disease': disease,
      'date': date.toIso8601String(),
      'improvement': improvement,
    };
  }

  factory Result.fromMap(Map<String, dynamic> map) {
    return Result(
      id: map['id'],
      medication: map['medication'],
      disease: map['disease'],
      date: DateTime.parse(map['date']),
      improvement: map['improvement'],
    );
  }
}
