const express = require('express');
const jwt = require('jsonwebtoken');
const bodyParser = require('body-parser');

const app = express();
app.use(bodyParser.json());

// This is a placeholder. Replace it with your actual user data storage.
let users = [{ username: 'savio', password: '123' }];

app.get('/', (req, res) => {
  res.send('Hello World');
});

app.post('/signup', (req, res) => {
  const { username, password } = req.body;

  // Check if the username already exists
  const userExists = users.find(user => user.username === username);
  if (userExists) {
    return res.status(400).json({ error: 'Username already exists' });
  }

  // Add the new user to the storage
  users.push({ username, password });

  res.status(200).json({ message: 'User created successfully' });
});

app.post('/login', (req, res) => {
  const { username, password } = req.body;

  // Find the user
  const user = users.find(user => user.username === username && user.password === password);
  if (!user) {
    return res.status(400).json({ error: 'Invalid username or password' });
  }

  // Create a token
  const token = jwt.sign({ username }, '12345', { expiresIn: '1h' });

  res.status(200).json({ message: 'Logged in successfully', token });
});

app.listen(3000, () => console.log('Server started on port 3000'));
