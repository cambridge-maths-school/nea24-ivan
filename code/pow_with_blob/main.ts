// @ts-ignore
import os from "os";
let numThreads = os.cpus().length; // no. of threads
let eighty_percent_of_threads = Math.max(1, Math.floor(numThreads * 0.8));
console.log(`Detected ${numThreads} logical CPU cores.`);
let startTime: number;
let NUM_WORKERS = eighty_percent_of_threads;
let CHUNK_SIZE = 50000;

let nonceOffset = 0; // Tracks the starting nonce for the next batch
let running = false; // Indicates if mining is currently active
let workers: Worker[] = [];

export async function startMining(baseData: string, difficulty: number) {
  workers = [];
  if (running) {
    console.log("Mining already in progress.");
    return Promise.resolve({ nonce: 0, hash: "" });
  }

  nonceOffset = 0;
  running = true;
  startTime = performance.now();
  console.log(
    `Starting mining with string="${baseData}", difficulty=${difficulty}, threads=${NUM_WORKERS}`
  );
  return new Promise<{ nonce: number; hash: string }>((resolve) => {
    let workerCode: string = `
  function fakeHash(input) {
    let hash = 0;
    for (let i = 0; i < input.length; i++) {
      hash = (hash * 67 + input.charCodeAt(i)) >>> 0;
      }
      return hash.toString(16).padStart(8, "0");
      }
      
      self.onmessage = (e) => {
        let { baseData, difficulty, startNonce, chunkSize } = e.data;
        let prefix = "0".repeat(difficulty);
        for (let i = 0; i < chunkSize; i++) {
          let nonce = startNonce + i;
          let hash = fakeHash(baseData + nonce);
          if (hash.startsWith(prefix)) {
            self.postMessage({ nonce, hash });
            break;
            }
            }
            };
            `;
    // Creating workers
    for (let i = 0; i < NUM_WORKERS; i++) {
      let blob = new Blob([workerCode], { type: "application/javascript" });
      let worker = new Worker(URL.createObjectURL(blob));

      workers.push(worker);
      // Handle message from worker when a valid nonce is found
      worker.onmessage = (e) => {
        let endTime = performance.now();
        console.log(`=== HIT! nonce=${e.data.nonce}, hash=${e.data.hash}`);
        console.log(`Mining took ${(endTime - startTime).toFixed(2)} ms`);
        stopMining(); // Stop all workers when one finds a valid nonce
        resolve({ nonce: e.data.nonce, hash: e.data.hash });
      };

      // Assign work to the worker in repeated chunks
      let assignWork = () => {
        if (!running) return;
        worker.postMessage({
          baseData,
          difficulty,
          startNonce: nonceOffset,
          chunkSize: CHUNK_SIZE,
        });
        nonceOffset += CHUNK_SIZE; // Increment nonce start for next batch
        setTimeout(assignWork, 0); // Schedule next batch asynchronously
      };
      assignWork(); // Start first batch
    }
  });
}

// Terminate all workers when nonce is found or mining is stopped
export function stopMining() {
  running = false;
  for (let w of workers) w.terminate();
  workers.length = 0;
  console.log("Mining stopped.");
}

// startMining("Hello World", 4);
