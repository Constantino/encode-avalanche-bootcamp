const express = require('express');
const routerApi = require('./routes');

const app = express();
const port = process.env.PORT || 3000;

app.use(express.json());

app.get('/', (req, res) => {
  res.send('Hello from the other side');
});

routerApi(app);

app.listen(port, () => {
  console.log('Mi port:' + port);
})
