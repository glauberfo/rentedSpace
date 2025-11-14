const http = require('http');
const fs = require('fs');
const path = require('path');

const server = http.createServer((req, res) => {
  // Headers CORS
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');

  // Handle OPTIONS
  if (req.method === 'OPTIONS') {
    res.writeHead(200);
    res.end();
    return;
  }

  let filePath = '';
  let contentType = 'text/html';

  if (req.url === '/' || req.url === '') {
    filePath = path.join(__dirname, 'public', 'index.html');
    contentType = 'text/html';
  } else if (req.url === '/styles.css') {
    filePath = path.join(__dirname, 'public', 'styles.css');
    contentType = 'text/css';
  } else if (req.url === '/app.js') {
    filePath = path.join(__dirname, 'public', 'app.js');
    contentType = 'application/javascript';
  } else {
    // Para qualquer outra rota, servir index.html (SPA)
    filePath = path.join(__dirname, 'public', 'index.html');
    contentType = 'text/html';
  }

  try {
    const data = fs.readFileSync(filePath);
    res.writeHead(200, { 'Content-Type': contentType });
    res.end(data);
  } catch (err) {
    console.error(`Erro ao ler arquivo ${filePath}:`, err.message);
    res.writeHead(500, { 'Content-Type': 'text/html' });
    res.end('<h1>500 - Erro Interno do Servidor</h1><p>' + err.message + '</p>');
  }
});

const PORT = 3000;
server.listen(PORT, () => {
  console.log(`SpaceRented Web - dev server`);
  console.log(`Server running on http://localhost:${PORT}`);
  console.log(`Public files: ${path.join(__dirname, 'public')}`);
});
