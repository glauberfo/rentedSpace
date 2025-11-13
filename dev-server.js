// Placeholder dev server for Builder.io
const http = require('http');

const server = http.createServer((req, res) => {
  res.writeHead(200, { 'Content-Type': 'text/html' });
  res.end(`
    <!DOCTYPE html>
    <html>
    <head>
      <title>Flutter Project - Builder.io Placeholder</title>
    </head>
    <body>
      <h1>Flutter Project</h1>
      <p>This is a Flutter project. Use: flutter run</p>
      <p>This server is only for Builder.io integration.</p>
    </body>
    </html>
  `);
});

const PORT = 3000;
server.listen(PORT, () => {
  console.log(`Flutter project - dev server placeholder`);
  console.log(`This is a Flutter project. Use: flutter run`);
  console.log(`Server running on http://localhost:${PORT}`);
  console.log('Keeping process alive for Builder.io...');
});

