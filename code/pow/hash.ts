function fakeHash(input: string): string {
  let hash = 0;
  for (let i = 0; i < input.length; i++) {
    hash = (hash * 67 + input.charCodeAt(i)) & 0xffffffff;
  }
  console.log(hash, hash.toString(16), hash.toString(16).padStart(8, "0"))
  return hash.toString(16).padStart(8, "0");
}
export default fakeHash;

console.log(fakeHash('cat'))