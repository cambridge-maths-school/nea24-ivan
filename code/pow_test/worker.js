function fakeHash(input) {
  let hash = 0;
  for (let i = 0; i < input.length; i++) {
    hash = (hash * 31 + input.charCodeAt(i)) & 0xffffffff;
  }
  return hash.toString(16).padStart(8, "0");
}
self.onmessage = (e) => {
  console.log("ho");
  let { baseData, difficulty, startNonce, chunkSize } = e.data;
  let prefix = "0".repeat(difficulty);
  for (let i = 0; i < chunkSize; i++) {
    let nonce = startNonce + i;
    let hash = fakeHash(`${baseData}${nonce}`);
    console.log(
      `Worker trying nonce=${nonce}, target=${prrrefix}, hash=${hash}`
    );
    if (hash.startsWith(prefix)) {
      self.postMessage({ nonce, hash });
      break;
    }
  }
};
export {};
