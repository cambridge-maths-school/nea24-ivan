var NUM_WORKERS = 50;
var CHUNK_SIZE = 50000;
var nonceOffset = 0; // Tracks the starting nonce for the next batch
var running = false; // Indicates if mining is currently active
var workers = [];
function startMining(baseData, difficulty) {
  if (running) {
    console.log("Mining already in progress.");
    return;
  }
  nonceOffset = 0;
  running = true;
  console.log(
    'Starting mining with string="'
      .concat(baseData, '", difficulty=')
      .concat(difficulty, ", threads=")
      .concat(NUM_WORKERS)
  );
  var _loop_1 = function (i) {
    var worker = new Worker("worker.js", { type: "module" });
    workers.push(worker);
    // Handle message from worker when a valid nonce is found
    worker.onmessage = function (e) {
      console.log(
        "=== HIT! nonce=".concat(e.data.nonce, ", hash=").concat(e.data.hash)
      );
      stopMining(); // Stop all workers when one finds a valid nonce
    };
    // Assign work to the worker in repeated chunks
    var assignWork = function () {
      if (!running) return;
      worker.postMessage({
        baseData: baseData,
        difficulty: difficulty,
        startNonce: nonceOffset,
        chunkSize: CHUNK_SIZE,
      });
      nonceOffset += CHUNK_SIZE; // Increment nonce start for next batch
      setTimeout(assignWork, 0); // Schedule next batch asynchronously
    };
    assignWork(); // Start first batch
  };
  // Creating workers
  for (var i = 0; i < NUM_WORKERS; i++) {
    _loop_1(i);
  }
}
// Terminate all workers when nonce is found or mining is stopped
function stopMining() {
  running = false;
  for (var _i = 0, workers_1 = workers; _i < workers_1.length; _i++) {
    var w = workers_1[_i];
    w.terminate();
  }
  workers.length = 0;
  console.log("Mining stopped.");
}
// // Expose functions to the global scope
self.startMining = startMining;
self.stopMining = stopMining;
