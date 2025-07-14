import { serve } from "bun";
import app from "./index.html";
import test from "./test.html";

let server = serve({
  routes: {
    "/": app,
    "/test": test,
  },
});

console.log(`Listening on ${server.url}`);
