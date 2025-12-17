/// Wrapper for needed NodeJS Crypto library function and require.
library nodecrypto;

import 'dart:js_interop';

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
