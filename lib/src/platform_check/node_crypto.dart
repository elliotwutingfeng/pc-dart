/// Wrapper for needed NodeJS Crypto library function and require.
library nodecrypto;

import 'dart:js_interop';

@JS()
@staticInterop
class Process {}

@JS()
@staticInterop
class Versions {}

@JS('process')
external Process? get _process;

extension on Process {
  external Versions? get versions;
}

extension on Versions {
  external JSAny get node;
}

bool get isNodeJS => _process?.versions?.node != null;

@JS()
@staticInterop
class Crypto {}

extension on Crypto {
  external JSUint8Array randomBytes(int size);
}

@JS()
external Crypto require(String id);

class NodeCrypto {
  static JSUint8Array randomBytes(int size) =>
      require('crypto').randomBytes(size);
}
