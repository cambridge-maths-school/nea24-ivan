function fakeHash(input: string): string {
  let hash = 0;
  for (let i = 0; i < input.length; i++) {
    hash = (hash * 67 + input.charCodeAt(i)) >>> 0;
  }
  return hash.toString(16).padStart(8, "0");
}

export { fakeHash };

// console.log(fakeHash("cat"));
// console.log(fakeHash("hello world"));
// console.log(fakeHash("William"));
