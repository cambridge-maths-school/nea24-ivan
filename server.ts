// @ts-ignore
import { serve } from "bun";
// @ts-ignore
import app from "./code/index.html";

let server = serve({
  routes: {
    "/": app,
  },
});

console.log(`Listening on ${server.url}`);
