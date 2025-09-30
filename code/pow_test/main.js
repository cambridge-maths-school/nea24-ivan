let NUM_WORKERS = 10;
let CHUNK_SIZE = 50000;
let nonceOffset = 0;
let running = false;
let workers = [];

function startMining(baseData, difficulty) {
  if (running) {
    console.log("Mining already in progress.");
    return;
  }
  nonceOffset = 0;
  running = true;
  console.log(
    `Starting mining with string="${baseData}", difficulty=${difficulty}, threads=${NUM_WORKERS}`
  );
  for (let i = 0; i < NUM_WORKERS; i++) {
    // Spawning workers
    let worker = new Worker(
      URL.createObjectURL(
        new Blob(workers.js, { type: "module" })
      )
    );

    workers.push(worker);
    worker.onmessage = (e) => {
      console.log(`=== HIT! nonce=${e.data.nonce}, hash=${e.data.hash}`);
      stopMining();
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
function stopMining() {
  running = false;
  for (let w of workers) w.terminate();
  workers.length = 0;
  console.log("Mining stopped.");
}
// Expose functions to browser console
self.startMining = startMining;
self.stopMining = stopMining;
