// @ts-ignore
import { serve } from "bun";
// @ts-ignore
import app from "./code/index.html";
// @ts-ignore
import test from "./code/test.html";

let server = serve({
  routes: {
    "/": app,
    "/test/": test,
  },
});

console.log(`Listening on ${server.url}`);
