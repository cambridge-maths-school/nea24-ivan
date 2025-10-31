window.addEventListener("load", () => {

  // Get canvas and its 2D rendering context
  const canvas = document.getElementById("main-canvas");
  const ctx = canvas.getContext("2d");

  // Resize canvas to fill the window
  function resizeCanvas() {
    canvas.width = window.innerWidth;
    canvas.height = window.innerHeight;
  }
  window.addEventListener("resize", resizeCanvas);
  resizeCanvas();

  // Define nodes as objects with x, y coordinates and radius
  const nodes = [
    { x: 0, y: 0, radius: 10 },
    { x: 50, y: 0, radius: 10 },
    { x: 50, y: 50, radius: 10 },
    { x: 100, y: -50, radius: 10 },
  ];

  // Define arcs as arrays of target node indices for each node
  // For example, node 0 connects to nodes 1 and 2
  const arcs = [
    [1, 2],
    [2, 3],
    [],
    []
  ];

  // Render the graph
  function render() {
    ctx.save();
    // Centre origin and flip y-axis so +y is up
    ctx.translate(window.innerWidth / 2, window.innerHeight / 2);
    ctx.scale(1, -1);

    // Set colors for drawing
    ctx.strokeStyle = "black";
    ctx.fillStyle = "white";

    // Draw arcs first so they appear behind nodes
    arcs.forEach((targets, fromIdx) => {
      const fromNode = nodes[fromIdx];
      targets.forEach(toIdx => {
        const toNode = nodes[toIdx];
        ctx.beginPath();
        ctx.moveTo(fromNode.x, fromNode.y);
        ctx.lineTo(toNode.x, toNode.y);
        ctx.stroke();
      });
    });

    // Draw nodes as circles
    nodes.forEach(node => {
      ctx.beginPath();
      ctx.arc(node.x, node.y, node.radius, 0, 2 * Math.PI);
      ctx.fill();
      ctx.stroke();
    });

    ctx.restore(); // Restore context transform
    // Request next frame for smooth updates. Useful for window resizing.
    window.requestAnimationFrame(render);
  }

  // Start rendering loop
  window.requestAnimationFrame(render);
});
