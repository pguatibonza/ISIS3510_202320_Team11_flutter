import 'package:flutter_test/flutter_test.dart';
import 'package:tucamion/controller/truckservices.dart';

void main() {
  group('TrailerController Integration Tests', () {
    late TrailerController trailerController;

    setUp(() {
      trailerController = TrailerController();
    });

    test('should get trailers by owner id when data exists', () async {
      var trailers = await trailerController.getTrailersByOwnerId(1);
      expect(trailers.isNotEmpty, true);
      expect(trailers[0]['plates'], 'ner643');
    });

    test('should get trailers by owner id when data does not exist', () async {
      var trailers = await trailerController.getTrailersByOwnerId(999);
      expect(trailers.isEmpty, true);
    });

    test('should get trips by trailer id when data exists', () async {
      var trips = await trailerController.getTripsByTrailerId(1);
      expect(trips.isNotEmpty, true);
      expect(trips[0]['id'], 1);
    });

    test('should get trips by trailer id when data does not exist', () async {
      var trips = await trailerController.getTripsByTrailerId(999);
      expect(trips.isEmpty, true);
    });

    test('should get access point by id when data exists', () async {
      var accesspoint = await trailerController.getAccessPointById(3);
      expect(accesspoint, isNotNull);
      expect(accesspoint['id'], 3);
    });

    test('should get access point by id when data does not exist', () async {
      var accesspoint = await trailerController.getAccessPointById(999);
      expect(accesspoint.isEmpty, true);
    });

    test('getTripByTrailerIdAndStatus returns a trip for specific status',
        () async {
      final trips =
          await trailerController.getTripByTrailerIdAndStatus(2, 'IP');
      expect(trips, isA<List<dynamic>>());
      expect(trips.any((trip) => trip['status'] == 'IP'), isTrue);
    });

    test('getTripByTrailerIdAndStatus returns an empty list for invalid status',
        () async {
      final trips =
          await trailerController.getTripByTrailerIdAndStatus(2, 'NA');
      expect(trips.isEmpty, isTrue);
    });

    test('getLoadById returns load data for given load ID', () async {
      final load = await trailerController.getLoadById(1);
      expect(load, isA<Map<String, dynamic>>());
      expect(load['id'], 1);
    });

    test('getLoadById returns empty map for invalid load ID', () async {
      final load = await trailerController.getLoadById(99);
      expect(load, {});
    });
  });
}
