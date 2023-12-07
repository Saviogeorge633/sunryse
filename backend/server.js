const jsonServer = require('json-server');
const server = jsonServer.create();
const router = jsonServer.router('db.json');
const middlewares = jsonServer.defaults();

server.use(middlewares);
server.use(jsonServer.bodyParser);

server.post('/signup', (req, res) => {
  const db = router.db; // Assign the lowdb instance
  const { username, password } = req.body;

  if (db.get('users').find({ username }).value()) {
    // User already exists
    res.sendStatus(400);
  } else {
    // Insert new user
    db.get('users').push({ username, password }).write();
    res.sendStatus(200);
  }
});

server.post('/login', (req, res) => {
  const db = router.db;
  const { username, password } = req.body;

  if (db.get('users').find({ username, password }).value()) {
    // User exists
    res.sendStatus(200);
  } else {
    // User doesn't exist
    res.sendStatus(400);
  }
});

server.use(router);
server.listen(3000,'172.22.39.28',() => console.log('Server is running'));