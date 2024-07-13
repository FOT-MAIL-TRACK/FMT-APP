import 'package:mongo_dart/mongo_dart.dart';

class MongoService {
  final Db db = Db(
      'mongodb+srv://<username>:<password>@cluster0.mongodb.net/<dbname>?retryWrites=true&w=majority');

  Future<void> init() async {
    await db.open();
  }

  Future<void> updateTracker(String letterId, String status,
      {String? reason}) async {
    var collection = db.collection('letters');
    await collection.updateOne(
      where.eq('letterId', letterId),
      modify.set('status', status).set('reason', reason),
    );
  }
}
