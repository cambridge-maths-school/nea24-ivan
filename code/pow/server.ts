// @ts-ignore
import { serve } from "bun";

serve({
  port: 3000,
  // Handle each incoming HTTP request
  fetch(req: Request) {
    let url = new URL(req.url);
    let path = `.${url.pathname}`;

    try {
      if (url.pathname === "/") {
        path = "./index.html";
      }
      // Respond with the requested file
      // @ts-ignore
      return new Response(Bun.file(path));
    } catch {
      return new Response("Not found", { status: 404 });
    }
  },
});

console.log("Server running at http://localhost:3000");
