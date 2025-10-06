// var NUM_WORKERS = 20;
// var CHUNK_SIZE = 50000;
// var nonceOffset = 0; // Tracks the starting nonce for the next batch
// var running = false; // Indicates if mining is currently active
// var workers = [];
// function startMining(baseData, difficulty) {
//   if (running) {
//     console.log("Mining already in progress.");
//     return;
//   }
//   nonceOffset = 0;
//   running = true;
//   console.log(
//     'Starting mining with string="'
//       .concat(baseData, '", difficulty=')
//       .concat(difficulty, ", threads=")
//       .concat(NUM_WORKERS)
//   );
//   var workerCode =
//     '\n    function fakeHash(input) {\n      let hash = 0;\n      for (let i = 0; i < input.length; i++) {\n        hash = (hash * 67 + input.charCodeAt(i)) & 0xffffffff;\n      }\n      return hash.toString(16).padStart(8, "0");\n    }\n\n    self.onmessage = (e) => {\n      let { baseData, difficulty, startNonce, chunkSize } = e.data;\n      let prefix = "0".repeat(difficulty);\n      for (let i = 0; i < chunkSize; i++) {\n        let nonce = startNonce + i;\n        let hash = fakeHash(baseData + nonce);\n        if (hash.startsWith(prefix)) {\n          self.postMessage({ nonce, hash });\n          break;\n        }\n      }\n    };\n';
//   var _loop_1 = function (i) {
//     var blob = new Blob([workerCode], { type: "application/javascript" });
//     var worker = new Worker(URL.createObjectURL(blob));
//     workers.push(worker);
//     // Handle message from worker when a valid nonce is found
//     worker.onmessage = function (e) {
//       console.log(
//         "=== HIT! nonce=".concat(e.data.nonce, ", hash=").concat(e.data.hash)
//       );
//       stopMining(); // Stop all workers when one finds a valid nonce
//     };
//     // Assign work to the worker in repeated chunks
//     var assignWork = function () {
//       if (!running) return;
//       worker.postMessage({
//         baseData: baseData,
//         difficulty: difficulty,
//         startNonce: nonceOffset,
//         chunkSize: CHUNK_SIZE,
//       });
//       nonceOffset += CHUNK_SIZE; // Increment nonce start for next batch
//       setTimeout(assignWork, 0); // Schedule next batch asynchronously
//     };
//     assignWork(); // Start first batch
//   };
//   // Creating workers
//   for (var i = 0; i < NUM_WORKERS; i++) {
//     _loop_1(i);
//   }
// }
// // Terminate all workers when nonce is found or mining is stopped
// function stopMining() {
//   running = false;
//   for (var _i = 0, workers_1 = workers; _i < workers_1.length; _i++) {
//     var w = workers_1[_i];
//     w.terminate();
//   }
//   workers.length = 0;
//   console.log("Mining stopped.");
// }
// // // Expose functions to the global scope
// self.startMining = startMining;
// self.stopMining = stopMining;
