function fakeHash(input) {
  let hash = 0;
  for (let i = 0; i < input.length; i++) {
    hash = (hash * 31 + input.charCodeAt(i)) & 0xffffffff;
  }
  return hash.toString(16).padStart(8, "0");
}
self.onmessage = (e) => {
  const { baseData, difficulty, startNonce, chunkSize } = e.data;
  const prefix = "0".repeat(difficulty);
  for (let i = 0; i < chunkSize; i++) {
    const nonce = startNonce + i;
    const hash = fakeHash(`${baseData}${nonce}`);
    // console.log(`Worker trying nonce=${nonce}, target=${prefix}, hash=${hash}`);
    if (hash.startsWith(prefix)) {
      self.postMessage({ nonce, hash });
      break;
    }
  }
};
export {};
