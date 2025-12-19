@JS()
import 'dart:js_interop';
import 'dart:math';
import 'dart:typed_data';

import 'package:pointycastle/src/impl/entropy.dart';

import 'node_crypto.dart';
import 'platform_check.dart';

class PlatformWeb extends Platform {
  static final PlatformWeb instance = PlatformWeb();
  static bool useBuiltInRng = !isNodeJS;

  const PlatformWeb();

  @override
  bool get isNative => false;

  @override
  String get platform => 'web';

  @override
  EntropySource platformEntropySource() {
    if (useBuiltInRng) {
      return _JsBuiltInEntropySource();
    }
    //
    // Assume that if we cannot get a built in Secure RNG then we are
    // probably on NodeJS.
    //
    return _JsNodeEntropySource();
  }
}

// Uses the built in entropy source
class _JsBuiltInEntropySource implements EntropySource {
  final _src = Random.secure();

  @override
  Uint8List getBytes(int len) {
    final Uint8List bytes = Uint8List(len);
    for (int i = 0; i < len; i++) {
      bytes[i] = _src.nextInt(256);
    }
    return bytes;
  }
}

///
class _JsNodeEntropySource implements EntropySource {
  @override
  Uint8List getBytes(int len) => NodeCrypto.randomBytes(len).toDart;
}

Platform getPlatform() => PlatformWeb.instance;
