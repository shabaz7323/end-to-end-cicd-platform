const http = require('http');
http.get('http://localhost:3000/health', res => {
  console.log('statusCode:', res.statusCode);
  process.exit(res.statusCode === 200 ? 0 : 1);
}).on('error', () => process.exit(2));
