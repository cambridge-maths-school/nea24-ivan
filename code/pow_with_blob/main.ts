// @ts-ignore
import os from "os";
// let numThreads = os.cpus().length; // no. of threads
// let eighty_percent_of_threads = Math.max(1, Math.floor(numThreads * 0.8));
let numThreads = navigator.hardwareConcurrency || 4;
let eighty_percent_of_threads = Math.max(1, Math.floor(numThreads * 0.8));
console.log(`Detected ${numThreads} logical CPU cores.`);
let startTime: number;
let NUM_WORKERS = eighty_percent_of_threads;
let CHUNK_SIZE = 50000;

let nonceOffset = 0; // Tracks the starting nonce for the next batch
let running = false; // Indicates if mining is currently active
let workers: Worker[] = [];

export async function startMining(
  baseData: string,
  difficulty: number,
  onProgress?: (nonce: number) => void
) {
  workers = [];
  if (running) {
    console.log("Mining already in progress.");
    return { nonce: 0, hash: "", time: 0 };
  }

  nonceOffset = 0;
  running = true;
  let startTime = performance.now();

  return new Promise<{ nonce: number; hash: string; time: number }>(
    (resolve) => {
      let workerCode = `
      function fakeHash(input){
        let hash = 0;
        for(let i=0;i<input.length;i++){hash=(hash*67+input.charCodeAt(i))>>>0;}
        return hash.toString(16).padStart(8,'0');
      }

      self.onmessage = (e) => {
        let { baseData, difficulty, startNonce, chunkSize } = e.data;
        let prefix = "0".repeat(difficulty);
        for(let i=0;i<chunkSize;i++){
          let nonce = startNonce + i;
          let hash = fakeHash(baseData + nonce);
          self.postMessage({ nonce }); // live progress
          if(hash.startsWith(prefix)){
            self.postMessage({ nonce, hash, found: true });
            break;
          }
        }
      };
    `;

      for (let i = 0; i < NUM_WORKERS; i++) {
        let blob = new Blob([workerCode], { type: "application/javascript" });
        let worker = new Worker(URL.createObjectURL(blob));
        workers.push(worker);

        worker.onmessage = (e) => {
          if (e.data.found) {
            let endTime = performance.now();
            console.log(
              `=== HIT! nonce=${e.data.nonce}, hash=${e.data.hash}`,
              `difficulty=${difficulty}`
            );
            let runtime = parseInt((endTime - startTime).toFixed(2));
            console.log(`Mining took ${(endTime - startTime).toFixed(2)}`);
            stopMining();
            resolve({ nonce: e.data.nonce, hash: e.data.hash, time: runtime });
          } else if (onProgress) {
            onProgress(e.data.nonce);
          }
        };

        let assignWork = () => {
          if (!running) return;
          worker.postMessage({
            baseData,
            difficulty,
            startNonce: nonceOffset,
            chunkSize: CHUNK_SIZE,
          });
          nonceOffset += CHUNK_SIZE;
          setTimeout(assignWork, 0);
        };
        assignWork();
      }
    }
  );
}

export function stopMining() {
  running = false;
  for (let w of workers) w.terminate();
  workers.length = 0;
  console.log("Mining stopped.");
}
