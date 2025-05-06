import express from 'express'
import bodyParser from "body-parser";
import fetch from 'node-fetch'
import { fileURLToPath } from 'url';
import path from 'path';

const app = express()
const PORT = 5001;

// Fix __dirname
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// Serve static files
app.use(express.static('public')); // serves static files (CSS, JS, etc.)

// import usersRoutes from "./routes/users.js";
app.use(bodyParser.json());
// app.use("/people", usersRoutes);


app.get("/", (req, res) => res.send("Welcome to the Users API!"));
app.get('/1', (req, res) => res.json("Hahaha I got you!!! "))
app.get('/2', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', '2.html'));
    // res.json("Hahaha I got you!!! 222 "))
})
app.get('/id', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'id.html'));
    // res.json("Hahaha I got you!!! 222 "))
})
app.get('/user/:userId', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'user.html'));
  });
  
// Create a route
app.get('/api/carts', async (req, res) => {
    
    
    try {
        const response = await fetch('https://dummyjson.com/carts');
        const data = await response.json();
        
        // res.sendFile(path.join(__dirname, 'public', 'carts.html'));
        res.json(data); // send the fetched JSON to client
    } catch (error) {
      console.error('Error fetching carts:', error);
      res.status(500).json({ error: 'Failed to fetch carts' });
    }
});
  
app.all("*", (req, res) =>res.send("You've tried reaching a route that doesn't exist."));
app.listen(PORT, () =>console.log(`Server running on port: http://localhost:${PORT}`));