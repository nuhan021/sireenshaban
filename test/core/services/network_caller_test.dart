import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:http/http.dart';

import 'package:sireenshaban/core/services/network_caller.dart';

void main() {
  const testUrl = 'https://example.com/test';

  group('NetworkCaller', () {
    test('JSON parsing error handling', () async {
      final mockClient = MockClient((request) async {
        return Response('this is not json', 200);
      });

      final caller = NetworkCaller(client: mockClient, timeoutDuration: 5);
      final res = await caller.getRequest(testUrl);

      expect(res.isSuccess, isFalse);
      expect(res.statusCode, equals(200));
      expect(res.errorMessage, contains('Failed to parse server response'));
    });

    test('Authorization header format for GET', () async {
      final mockClient = MockClient((request) async {
        // header key is lowercase in some clients, ensure check is case-insensitive
        expect(request.headers['authorization'], equals('Bearer mytoken'));
        return Response(jsonEncode({'success': true}), 200);
      });

      final caller = NetworkCaller(client: mockClient);
      final res = await caller.getRequest(testUrl, token: 'mytoken');

      expect(res.isSuccess, isTrue);
      expect(res.statusCode, equals(200));
    });

    test('Authorization header format for POST', () async {
      final mockClient = MockClient((request) async {
        expect(request.headers['authorization'], equals('Bearer posttoken'));
        final body = jsonDecode(request.body);
        expect(body['key'], equals('value'));
        return Response(jsonEncode({'success': true}), 200);
      });

      final caller = NetworkCaller(client: mockClient);
      final res = await caller.postRequest(
        testUrl,
        token: 'posttoken',
        body: {'key': 'value'},
      );

      expect(res.isSuccess, isTrue);
      expect(res.statusCode, equals(200));
    });

    test('Timeout handling', () async {
      final mockClient = MockClient((request) async {
        // Simulate a delay longer than timeout
        await Future.delayed(Duration(seconds: 2));
        return Response(jsonEncode({'success': true}), 200);
      });

      final caller = NetworkCaller(client: mockClient, timeoutDuration: 1);
      final res = await caller.getRequest(testUrl);

      expect(res.isSuccess, isFalse);
      // timeout maps to statusCode 408 in NetworkCaller
      expect(res.statusCode, equals(408));
      expect(res.errorMessage, contains('Request timeout'));
    });

    test('401/403 error handling', () async {
      final mockClient = MockClient((request) async {
        return Response(jsonEncode({'message': 'Unauthorized access'}), 401);
      });

      final caller = NetworkCaller(client: mockClient);
      final res = await caller.getRequest(testUrl);

      expect(res.isSuccess, isFalse);
      expect(res.statusCode, equals(401));
      expect(res.errorMessage, contains('Unauthorized access'));
    });

    test('Malformed response handling (missing success/message)', () async {
      final mockClient = MockClient((request) async {
        return Response(jsonEncode({'data': 123}), 200);
      });

      final caller = NetworkCaller(client: mockClient);
      final res = await caller.getRequest(testUrl);

      expect(res.isSuccess, isFalse);
      expect(res.statusCode, equals(200));
      expect(res.errorMessage, contains('Unknown error occurred'));
    });

    test('400 validation error with errorSources list', () async {
      final mockClient = MockClient((request) async {
        return Response(
          jsonEncode({
            'errorSources': [
              {'message': 'Field A required'},
              {'message': 'Field B invalid'},
            ],
          }),
          400,
        );
      });

      final caller = NetworkCaller(client: mockClient);
      final res = await caller.getRequest(testUrl);

      expect(res.isSuccess, isFalse);
      expect(res.statusCode, equals(400));
      expect(res.errorMessage, contains('Field A required'));
      expect(res.errorMessage, contains('Field B invalid'));
    });

    test('400 validation error with malformed errorSources', () async {
      final mockClient = MockClient((request) async {
        return Response(jsonEncode({'errorSources': 'not_a_list'}), 400);
      });

      final caller = NetworkCaller(client: mockClient);
      final res = await caller.getRequest(testUrl);

      expect(res.isSuccess, isFalse);
      expect(res.statusCode, equals(400));
      expect(res.errorMessage, contains('Validation error'));
    });

    test('500 handling with missing message', () async {
      final mockClient = MockClient((request) async {
        return Response(jsonEncode({}), 500);
      });

      final caller = NetworkCaller(client: mockClient);
      final res = await caller.getRequest(testUrl);

      expect(res.isSuccess, isFalse);
      expect(res.statusCode, equals(500));
      expect(res.errorMessage, contains('An unexpected error occurred'));
    });

    test('ClientException (network error) handling', () async {
      final mockClient = MockClient((request) async {
        throw ClientException('Failed host lookup');
      });

      final caller = NetworkCaller(client: mockClient);
      final res = await caller.getRequest(testUrl);

      expect(res.isSuccess, isFalse);
      expect(res.statusCode, equals(500));
      expect(res.errorMessage, contains('Network error occurred'));
    });

    test('403 error handling', () async {
      final mockClient = MockClient((request) async {
        return Response(jsonEncode({'message': 'Forbidden access'}), 403);
      });

      final caller = NetworkCaller(client: mockClient);
      final res = await caller.getRequest(testUrl);

      expect(res.isSuccess, isFalse);
      expect(res.statusCode, equals(403));
      expect(res.errorMessage, contains('Forbidden access'));
    });

    test('decoded success false with message returns that message', () async {
      final mockClient = MockClient((request) async {
        return Response(
          jsonEncode({'success': false, 'message': 'Not allowed'}),
          200,
        );
      });

      final caller = NetworkCaller(client: mockClient);
      final res = await caller.getRequest(testUrl);

      expect(res.isSuccess, isFalse);
      expect(res.statusCode, equals(200));
      expect(res.errorMessage, contains('Not allowed'));
    });

    test('POST: preserve provided Authorization header', () async {
      final mockClient = MockClient((request) async {
        // User provided Authorization header should not be overridden
        expect(request.headers['authorization'], equals('Bearer custom'));
        return Response(jsonEncode({'success': true}), 200);
      });

      final caller = NetworkCaller(client: mockClient);
      final res = await caller.postRequest(
        testUrl,
        token: 'ignored',
        headers: {'Authorization': 'Bearer custom', 'X-Extra': '1'},
        body: {'a': 1},
      );

      expect(res.isSuccess, isTrue);
      expect(res.statusCode, equals(200));
    });

    test(
      'GET/POST include content-type and accept headers when not provided',
      () async {
        final mockClient = MockClient((request) async {
          expect(request.headers['content-type'], isNotNull);
          expect(request.headers['accept'], isNotNull);
          return Response(jsonEncode({'success': true}), 200);
        });

        final caller = NetworkCaller(client: mockClient);
        final res1 = await caller.getRequest(testUrl, token: 't');
        expect(res1.isSuccess, isTrue);

        final res2 = await caller.postRequest(
          testUrl,
          token: 't',
          body: {'x': 2},
        );
        expect(res2.isSuccess, isTrue);
      },
    );
  });
}
