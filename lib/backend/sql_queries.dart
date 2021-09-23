class Queries {
  // String createCacheTable = '''

  String createCacheTable = '''
    CREATE TABLE IF NOT EXISTS cache (
      id INTEGER PRIMARY KEY,
      name TEXT,
      doc_id TEXT
      );
      ''';

  String jsonCache = '''
    CREATE TABLE IF NOT EXISTS jsoncache (
      id INTEGER PRIMARY KEY,
      name TEXT,
      email TEXT,
      body TEXT
      );
      ''';

  String dropCacheTable = 'DROP TABLE cache';
  String dropJsonTable = 'DROP TABLE jsoncache';
}
