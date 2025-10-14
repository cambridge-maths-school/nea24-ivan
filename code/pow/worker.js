// Simple fake hash function
function fakeHash(input) {
  var hash = 0;
  for (var i = 0; i < input.length; i++) {
    hash = (hash * 67 + input.charCodeAt(i)) & 0xffffffff;
  }
  return hash.toString(16).padStart(8, "0");
}
// Handle messages from the main thread
self.onmessage = function (e) {
  var _a = e.data,
    baseData = _a.baseData,
    difficulty = _a.difficulty,
    startNonce = _a.startNonce,
    chunkSize = _a.chunkSize;
  var prefix = "0".repeat(difficulty);
  for (var i = 0; i < chunkSize; i++) {
    var nonce = startNonce + i;
    var hash = fakeHash("".concat(baseData).concat(nonce));
    // Log the attempt for debugging
    // console.log(
    //   "Worker trying nonce="
    //     .concat(nonce, ", target=")
    //     .concat(prefix, ", hash=")
    //     .concat(hash)
    // );
    // Check if hash meets difficulty
    if (hash.startsWith(prefix)) {
      self.postMessage({ nonce: nonce, hash: hash });
      break; // stop once a valid nonce is found
    }
  }
};
