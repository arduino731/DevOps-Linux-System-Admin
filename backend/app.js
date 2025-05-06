const express = require('express');
const app = express();
const port = 5001;

app.get('/', (req, res) => {
  res.send('Hello from the backend!');
});

app.listen(port, () => {
  console.log(`Backend is running on http://localhost:${port}`);
});
