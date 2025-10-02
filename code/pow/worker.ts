// export interface WorkerMessage {
//   baseData: string;
//   difficulty: number;
//   startNonce: number;
//   chunkSize: number;
// }

// // Simple fake hash function
// function fakeHash(input: string): string {
//   let hash = 0;
//   for (let i = 0; i < input.length; i++) {
//     hash = (hash * 31 + input.charCodeAt(i)) & 0xffffffff;
//   }
//   return hash.toString(16).padStart(8, "0");
// }

// // Handle messages from the main thread
// self.onmessage = (e: MessageEvent<WorkerMessage>) => {
//   let { baseData, difficulty, startNonce, chunkSize } = e.data;
//   let prefix = "0".repeat(difficulty);

//   for (let i = 0; i < chunkSize; i++) {
//     let nonce = startNonce + i;
//     let hash = fakeHash(`${baseData}${nonce}`);

//     // Log the attempt for debugging
//     console.log(`Worker trying nonce=${nonce}, target=${prefix}, hash=${hash}`);

//     // Check if hash meets difficulty
//     if (hash.startsWith(prefix)) {
//       self.postMessage({ nonce, hash });
//       break; // stop once a valid nonce is found
//     }
//   }
// };
