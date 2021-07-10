import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:payumoney_pro_unofficial/payumoney_pro_unofficial.dart';

void main() {
  const MethodChannel channel = MethodChannel('payumoney_pro_unofficial');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });
}
